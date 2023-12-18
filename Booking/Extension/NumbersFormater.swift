//
//  NumbersFormater.swift
//  Booking
//
//  Created by Aleksey Efimov on 17.12.2023.
//

import Foundation

extension Formatter {
	static let withSeparator: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.groupingSeparator = " "
		formatter.numberStyle = .decimal
		return formatter
	}()
}

extension Numeric {
	var formattedWithSeparator: String {
		return Formatter.withSeparator.string(for: self) ?? ""
	}
}
