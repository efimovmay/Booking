//
//  Room.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import Foundation

struct Rooms: Codable {
	let rooms: [Room]
}

struct Room: Codable, Hashable {
	let id: Int
	let name: String
	let price: Int
	let pricePer: String
	let peculiarities: [String]
	let imageUrls: [String]
}

extension Room {
	static func getRoom() -> Room {
		Room(id: 2,
			 name: "room",
			 price: 20000,
			 pricePer: "20000",
			 peculiarities: [
				"Wifi",
				"1 км до пляжа",
				"Бесплатный фитнес-клуб",
				"20 км до аэропорта"
			 ],
			 imageUrls: [
				"https://www.atorus.ru/sites/default/files/upload/image/News/56149/Club_Priv%C3%A9_by_Belek_Club_House.jpg",
				"https://deluxe.voyage/useruploads/articles/The_Makadi_Spa_Hotel_02.jpg",
				"https://deluxe.voyage/useruploads/articles/article_1eb0a64d00.jpg"
			 ])
	}
	
	static func getRooms() -> [Room] {
		let room = getRoom()
		return [room]
	}
}
