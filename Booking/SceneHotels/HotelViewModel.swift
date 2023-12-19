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
		guard let url = URL(string: "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473") else { return }
		
		isRefreshing = true
		hasError = false
		
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		
		URLSession.shared.dataTaskPublisher(for: url)
			.receive(on: DispatchQueue.main)
			.tryMap(hanleOutput)
			.decode(type: Hotel.self, decoder: decoder)
			.sink { completion in
				switch completion {
				case .finished:
					self.isRefreshing = false
				case .failure(let error):
					print("Error: \(error)")
					self.hasError = true
				}
			} receiveValue: { [weak self] hotel in
				self?.hotel = hotel
				self?.isRefreshing = false
			}
			.store(in: &cancellables)
	}
	
	private func hanleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
		guard let response = output.response as? HTTPURLResponse,
			  response.statusCode >= 200 && response.statusCode < 300 else {
			throw URLError(.badServerResponse)
		}
		return output.data
	}
}
