//
//  RegisterViewModel.swift
//  Booking
//
//  Created by Aleksey Efimov on 17.12.2023.
//

import Foundation
import Combine

class RegisterViewModel: ObservableObject {
	
	@Published var infoBooking: InfoBooking!
//	@Published var touristsInfo: [Tourist]
	@Published var name = ""
	@Published var hasError = false
	var isRefreshing = true
	
	@Published var phoneNumber = ""
	@Published var email = ""
	
	@Published var canSubmit = false
	
	@Published private var isValidPhone = false
	@Published private var isValidEmail = false
	
	var phonePrompt: String? {
		if isValidPhone == true || phoneNumber.isEmpty {
			return nil
		} else {
			return "Enter full phone number"
		}
	}
	var emailPromt: String? {
		if isValidEmail == true || email.isEmpty {
			return nil
		} else {
			return "введите корректную почту"
		}
	}
	
	var serviceChargeString: String {
		"\(infoBooking.serviceCharge) ₽"
	}
	var fuelChargeString: String {
		"\(infoBooking.fuelCharge) ₽"
	}
	var tourPriceString: String {
		"\(infoBooking.tourPrice) ₽"
	}
	var finalPriceString: String {
		"\(infoBooking.tourPrice + infoBooking.fuelCharge + infoBooking.serviceCharge) ₽"
	}
	
	var buttonNextScreenTitle: String {
		"Оплатить \(finalPriceString)"
	}
	
	var nameButton: String {
		"Оплатить \(infoBooking.tourPrice.formattedWithSeparator) ₽"
	}
	
	var dataBooking: String {
		"\(infoBooking.tourDateStart)-\(infoBooking.tourDateStop)"
	}
	var numberNight: String {
		"\(infoBooking.numberOfNights) ночей"
	}
	
	private var cancellables = Set<AnyCancellable>()
	
	private let phonePredicate = NSPredicate(format: "SELF MATCHES %@", Regex.phone.rawValue)
	
	private let emailPredicate = NSPredicate(format: "SELF MATCHES %@", Regex.email.rawValue)
	
	init() {
		fetchData()
		
		$phoneNumber
			.debounce(for: 0.5, scheduler: RunLoop.main)
			.map { phone in
				return self.phonePredicate.evaluate(with: phone)
			}
			.assign(to: \.isValidPhone, on: self)
			.store(in: &cancellables)
		$email
			.debounce(for: 0.5, scheduler: RunLoop.main)
			.map { email in
				return self.emailPredicate.evaluate(with: email)
			}
			.assign(to: \.isValidEmail, on: self)
			.store(in: &cancellables)
		
		Publishers.CombineLatest($isValidEmail, $isValidPhone)
			.map { first, second in
				return (first && second)
			}
			.assign(to: \.canSubmit, on: self)
			.store(in: &cancellables)
	}
	
	func fetchMocData() {
		infoBooking = InfoHotel.getInfoBooking()
		isRefreshing = false
		hasError = false
	}
	
	func fetchData() {
		guard let url = URL(string: "https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff") else { return }
		
		isRefreshing = true
		hasError = false
		
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		URLSession.shared.dataTaskPublisher(for: url)
			.receive(on: DispatchQueue.main)
			.tryMap(hanleOutput)
			.decode(type: InfoBooking.self, decoder: decoder)
			.sink { (completion) in
				switch completion {
				case .finished:
					self.isRefreshing = false
				case .failure(let error):
					print("Error: \(error)")
					self.hasError = true
					self.isRefreshing = false
				}
			} receiveValue: { [weak self] info in
				self?.infoBooking = info
			}
			.store(in: &cancellables)
	}
	
	func hanleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
		guard let response = output.response as? HTTPURLResponse,
			  response.statusCode >= 200 && response.statusCode < 300 else {
			throw URLError(.badServerResponse)
		}
		return output.data
	}
}

