//
//  HotelsViewModel.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import SwiftUI
import Combine

class HotelViewModel: ObservableObject {
	
	@Published var hotel: Hotel!
	
	@Published var hasError = false
	var isRefreshing = true
	
	var minimalPriceText: String {
		"от \(hotel.minimalPrice.formattedWithSeparator) ₽"
	}
	
	private var cancellables = Set<AnyCancellable>()
	
	init() {
		fetchData()
	}
	
	func fetchMocData() {
		hotel = Hotel.getHotel()
		isRefreshing = false
		hasError = false
	}
	
	func fetchData() {
		NetworkManger.shared.fetchData(url: link.hotelData.rawValue, type: Hotel.self)
			.sink { completion in
				switch completion {
				case .failure(let err):
					print("Error is \(err.localizedDescription)")
					self.hasError = true
				case .finished:
					print("Finished")
					self.isRefreshing = false
				}
			}
	receiveValue: { [weak self] data in
		self?.hotel = data
		self?.isRefreshing = false
	}
	.store(in: &cancellables)
	}
}
