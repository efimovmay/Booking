//
//  DateFormater.swift
//  Booking
//
//  Created by Aleksey Efimov on 17.12.2023.
//

import Foundation

extension Date {
	var justDate: String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = .none
		dateFormatter.locale = Locale(identifier: "ru_RU")
		return dateFormatter.string(from: self)
	}
}
