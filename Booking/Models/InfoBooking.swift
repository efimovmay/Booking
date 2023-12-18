//
//  InfoBooking.swift
//  Booking
//
//  Created by Aleksey Efimov on 17.12.2023.
//

import Foundation

struct InfoBooking: Codable {
	let id: Int
	let hotelName: String
	let hotelAdress: String
	let horating: Int
	let ratingName: String
	let departure: String
	let arrivalCountry: String
	let tourDateStart: String
	let tourDateStop: String
	let numberOfNights: Int
	let room: String
	let nutrition: String
	let tourPrice: Int
	let fuelCharge: Int
	let serviceCharge: Int
}

extension InfoHotel {
	static func getInfoBooking() -> InfoBooking {
		InfoBooking(id: 1,
					hotelName: "radison",
					hotelAdress: "moscow",
					horating: 1,
					ratingName: "bad",
					departure: "russia",
					arrivalCountry: "kanada",
					tourDateStart: "01.01.2023",
					tourDateStop: "01.01.2023",
					numberOfNights: 1,
					room: "luxe",
					nutrition: "all inclusive",
					tourPrice: 1,
					fuelCharge: 1,
					serviceCharge: 1)
	}
}

