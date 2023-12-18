//
//  Hotel.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import Foundation

struct Hotel: Codable {
	let id: Int
	let name: String
	let adress: String
	let minimalPrice: Int
	let priceForIt: String
	let rating: Int
	var ratingName: String
	let imageUrls: [String]
	let aboutTheHotel: AboutTheHotel
}

struct AboutTheHotel: Codable {
	let description: String
	let peculiarities: [String]
}


extension Hotel {
	static func getHotel() -> Hotel {
		Hotel(id: 1,
			  name: "hotel#1",
			  adress: "Moscow",
			  minimalPrice: 100000,
			  priceForIt: "за номер",
			  rating: 2,
			  ratingName: "средний",
			  imageUrls: [
				"https://www.atorus.ru/sites/default/files/upload/image/News/56149/Club_Priv%C3%A9_by_Belek_Club_House.jpg",
				"https://deluxe.voyage/useruploads/articles/The_Makadi_Spa_Hotel_02.jpg",
				"https://deluxe.voyage/useruploads/articles/article_1eb0a64d00.jpg"
			  ],
			  aboutTheHotel: AboutTheHotel(
				description: "Отель VIP-класса",
				peculiarities: [
					"Wifi",
					"1 км до пляжа",
					"Бесплатный фитнес-клуб",
					"20 км до аэропорта"
				]
			  )
		)
	}
}
