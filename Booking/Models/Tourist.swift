//
//  Tourist.swift
//  Booking
//
//  Created by Aleksey Efimov on 17.12.2023.
//

import Foundation


struct Tourist {
	let name: String
	let surname: String
	let dateOfBirth: String
	let citizenship: String
	let numberPass: String
	let validityPass: String
}

extension Tourist {
	static func getTourist() {
		Tourist(name: "",
				surname: "",
				dateOfBirth: "",
				citizenship: "",
				numberPass: "",
				validityPass: "")
	}
}
