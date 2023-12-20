//
//  Tourist.swift
//  Booking
//
//  Created by Aleksey Efimov on 17.12.2023.
//

import Foundation


struct Tourist: Hashable {
	var isActive: Bool
	var name: String
	var surname: String
	var dateOfBirth: String
	var citizenship: String
	var numberPass: String
	var validityPass: String
}

extension Tourist {
	static func getTourist() -> Tourist {
		Tourist(
			isActive: true,
			name: "",
			surname: "",
			dateOfBirth: "",
			citizenship: "",
			numberPass: "",
			validityPass: ""
		)
	}
}

struct FieldsCheckingTourist {
	var nameIsEmpty: Bool = true
	var surnameIsEmpty: Bool = true
	var dateOfBirthIsEmpty: Bool = true
	var citizenshipIsEmpty: Bool = true
	var numberPassIsEmpty: Bool = true
	var validityPassIsEmpty: Bool = true
}
