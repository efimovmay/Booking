//
//  stringFormater.swift
//  Booking
//
//  Created by Aleksey Efimov on 17.12.2023.
//

import Foundation

extension String {
	func formattedMask(text: String, mask: String?) -> String {
		let cleanPhoneNumber = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
		var result = ""
		var index = cleanPhoneNumber.startIndex
		if let mask = mask {
			for ch in mask where index < cleanPhoneNumber.endIndex {
				if ch == "X" {
					result.append(cleanPhoneNumber[index])
					index = cleanPhoneNumber.index(after: index)
				} else {
					result.append(ch)
				}
			}
		}
		return result
	}
}
