//
//  HotelsViewModel.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import Foundation
import Combine

class HotelViewModel: ObservableObject {
	
	@Published var hotel = [Hotel]()
	
	private var cancellables = Set<AnyCancellable>()
	
	var minimalPriceText: String {
		"от \(hotel[0].minimalPrice.formattedWithSeparator) \(getSymbol(code: "RUB") ?? "Р")"
	}
	
	init() {
	}
	
	func fetchData() {
		guard let url = URL(string: "https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3") else { return }
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		URLSession.shared.dataTaskPublisher(for: url)
			.subscribe(on: DispatchQueue.global(qos: .background))
			.receive(on: DispatchQueue.main)
			.tryMap(hanleOutput)
			.decode(type: Hotel.self, decoder: decoder)
			.replaceError(with: Hotel.getHotel())
			.sink { (completion) in
				switch completion {
				case .finished:
					print("complete")
				case .failure(let error):
					print("Error: \(error)")
					self.hotel.append(Hotel.getHotel())
					
				}
			} receiveValue: { [weak self] (hotel) in
				self?.hotel.append(hotel)
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
	
	private func getSymbol(code: String) -> String? {
		let result = Locale
			.availableIdentifiers
			.map { Locale(identifier: $0) }
			.first { $0.currency?.identifier == code }
		
		return result?.currencySymbol
	}
}
