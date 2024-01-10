//
//  RoomsViewModel.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import Foundation
import Combine

class RoomsViewModel: ObservableObject {
	
	let networkManager: INetworkManger
	
	@Published var rooms: [Room] = []
	@Published var hasError = false
	var isRefreshing = true
	
	private var cancellables = Set<AnyCancellable>()
	
	init(networkManager: INetworkManger) {
		self.networkManager = networkManager
		fetchData()
	}
	
	func fetchMocData() {
		rooms = Room.getRooms()
		isRefreshing = false
		hasError = false
	}
	
	func fetchData() {
		networkManager.fetchData(url: link.roomsData.rawValue, type: Rooms.self)
			.sink { completion in
				switch completion {
				case .failure(let err):
					print("Error is \(err.localizedDescription)")
					self.hasError = true
				case .finished:
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
