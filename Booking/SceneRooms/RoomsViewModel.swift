//
//  RoomsViewModel.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import Foundation
import Combine

class RoomsViewModel: ObservableObject {
	
	@Published var rooms: [Room] = []
	@Published var hasError = false
	var isRefreshing = true
	
	private var cancellables = Set<AnyCancellable>()
	
	init() {
		fetchData()
	}
	
	func fetchMocData() {
		rooms = Room.getRooms()
		isRefreshing = false
		hasError = false
	}
	
	func fetchData() {
		guard let url = URL(string: "https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195") else { return }
		
		isRefreshing = true
		hasError = false
		
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		
		URLSession.shared.dataTaskPublisher(for: url)
			.receive(on: DispatchQueue.main)
			.tryMap(hanleOutput)
			.decode(type: Rooms.self, decoder: decoder)
			.sink { completion in
				switch completion {
				case .finished:
					self.isRefreshing = false
				case .failure(let error):
					print("Error: \(error)")
					self.hasError = true
				}
			} receiveValue: { [weak self] rooms in
				self?.rooms = rooms.rooms
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
