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
		NetworkManger.shared.fetchData(url: link.roomsData.rawValue, type: Rooms.self)
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
		self?.rooms = data.rooms
		self?.isRefreshing = false
	}
	.store(in: &cancellables)
	}
}
