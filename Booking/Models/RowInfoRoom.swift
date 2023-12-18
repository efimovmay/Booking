//
//  RowInfoRoom.swift
//  Booking
//
//  Created by Aleksey Efimov on 16.12.2023.
//

import Foundation

struct RowInfoRoom: Hashable {
	let image: String
	let header: String
	let info: String
}

extension RowInfoRoom {
	static func getInfo() -> [RowInfoRoom] {
		let info: [RowInfoRoom] = [
			RowInfoRoom(image: "emoji-happy", header: "Удобства", info: "Самое необходимое"),
			RowInfoRoom(image: "tick-square", header: "Что включено", info: "Самое необходимое"),
			RowInfoRoom(image: "close-square", header: "Что не включено", info: "Самое необходимое")
		]
		return info
	}
}
