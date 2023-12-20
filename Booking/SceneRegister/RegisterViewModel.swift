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
	
	@Published var touristsInfo: [Tourist] = [Tourist.getTourist()]
	@Published var fieldsCheckingTourist = [FieldsCheckingTourist()]
	
	// ошибка загрузки данных
	@Published var hasError: Bool = false
	
	// model обновляется
	@Published var isRefreshing: Bool = true
	
	// свойство - все поля заполнены
	@Published var canSubmit: Bool = false
	
	@Published var phoneNumber: String = ""
	@Published var email: String = ""
	
	@Published var isPhoneValid: Bool = true
	@Published var isEmailValid: Bool = true
	
	// строковые свойства секции цен
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
	
	var nameNextScteenButton: String {
		"Оплатить \(finalPriceString)"
	}
	
	// строковые свойства секции информации
	var dataBooking: String {
		"\(infoBooking.tourDateStart)-\(infoBooking.tourDateStop)"
	}
	var numberNight: String {
		"\(infoBooking.numberOfNights) ночей"
	}
	
	private var cancellables = Set<AnyCancellable>()
	
	init() {
		fetchData()
	}
	
	func checkPhoneValid() -> Bool {
		let phoneTest = NSPredicate(format: "SELF MATCHES %@", Regex.phone.rawValue)
		return phoneTest.evaluate(with: phoneNumber)
	}
	
	func checkEmailValid() -> Bool {
		let emailTest = NSPredicate(format: "SELF MATCHES %@", Regex.email.rawValue)
		return emailTest.evaluate(with: email)
	}
	
	func checkEmptyTextField() {
		canSubmit = true
		
		isPhoneValid = !checkPhoneValid() ? false : true
		isEmailValid = !checkEmailValid() ? false : true
		
		if !checkPhoneValid() || !checkEmailValid() {
			canSubmit = false
		}
		fieldsCheckingTourist.indices.forEach { index in
			fieldsCheckingTourist[index].nameIsEmpty = touristsInfo[index].name.isEmpty ? false : true
			fieldsCheckingTourist[index].surnameIsEmpty = touristsInfo[index].surname.isEmpty ? false : true
			fieldsCheckingTourist[index].dateOfBirthIsEmpty = touristsInfo[index].dateOfBirth.isEmpty ? false : true
			fieldsCheckingTourist[index].citizenshipIsEmpty = touristsInfo[index].citizenship.isEmpty ? false : true
			fieldsCheckingTourist[index].numberPassIsEmpty = touristsInfo[index].numberPass.isEmpty ? false : true
			fieldsCheckingTourist[index].validityPassIsEmpty = touristsInfo[index].validityPass.isEmpty ? false : true
			
			if !fieldsCheckingTourist[index].nameIsEmpty ||
				!fieldsCheckingTourist[index].surnameIsEmpty ||
				!fieldsCheckingTourist[index].numberPassIsEmpty ||
				!fieldsCheckingTourist[index].citizenshipIsEmpty ||
				!fieldsCheckingTourist[index].validityPassIsEmpty ||
				!fieldsCheckingTourist[index].dateOfBirthIsEmpty {
				canSubmit = false
			}
		}
	}
	
	func checkEmptyTouristTextField() -> Bool {
		var notEmpty = true
		fieldsCheckingTourist.indices.forEach { index in
			fieldsCheckingTourist[index].nameIsEmpty = touristsInfo[index].name.isEmpty ? false : true
			fieldsCheckingTourist[index].surnameIsEmpty = touristsInfo[index].surname.isEmpty ? false : true
			fieldsCheckingTourist[index].dateOfBirthIsEmpty = touristsInfo[index].dateOfBirth.isEmpty ? false : true
			fieldsCheckingTourist[index].citizenshipIsEmpty = touristsInfo[index].citizenship.isEmpty ? false : true
			fieldsCheckingTourist[index].numberPassIsEmpty = touristsInfo[index].numberPass.isEmpty ? false : true
			fieldsCheckingTourist[index].validityPassIsEmpty = touristsInfo[index].validityPass.isEmpty ? false : true
			
			if fieldsCheckingTourist[index].nameIsEmpty ||
				fieldsCheckingTourist[index].surnameIsEmpty ||
				fieldsCheckingTourist[index].numberPassIsEmpty ||
				fieldsCheckingTourist[index].citizenshipIsEmpty ||
				fieldsCheckingTourist[index].validityPassIsEmpty ||
				fieldsCheckingTourist[index].dateOfBirthIsEmpty {
				notEmpty = false
			}
			
		}
		return notEmpty
	}
	
	func addTourist() {
		touristsInfo.append(Tourist.getTourist())
		fieldsCheckingTourist.append(FieldsCheckingTourist())
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

