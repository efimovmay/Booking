//
//  RegisterViewModel.swift
//  Booking
//
//  Created by Aleksey Efimov on 17.12.2023.
//

import Foundation
import Combine

class RegisterViewModel: ObservableObject {
	
	let networkManager: INetworkManger
	
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
	
	let nameSectionTourict = ["Первый турист", "Второй турист", "Третий турист"]
	
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
	
	init(networkManager: INetworkManger) {
		self.networkManager = networkManager
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
		networkManager.fetchData(url: link.registerData.rawValue, type: InfoBooking.self)
			.sink { completion in
				switch completion {
				case .failure(let err):
					print("Error is \(err.localizedDescription)")
					self.hasError = true
				case .finished:
					self.isRefreshing = false
				}
			}
	receiveValue: { [weak self] data in
		self?.infoBooking = data
		self?.isRefreshing = false
	}
	.store(in: &cancellables)
	}
}

