//
//  AppCoordinator.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import SwiftUI
import Combine

//protocol NavigationItemProtocol: Hashable, Identifiable {
//	associatedtype SomeView: View
//	func nextView() -> SomeView
//}

enum Page: String, Identifiable {
	case hotel, rooms, register, booked
	
	var id: String {
		self.rawValue
	}
}

final class Coordinator: ObservableObject {
	
	@Published var path = NavigationPath()
	
	func push(_ page: Page) {
		path.append(page)
	}
	
	func pop() {
		path.removeLast()
	}
	
	func popToRoot() {
		path.removeLast(path.count)
	}
	
	@ViewBuilder
	func build(page: Page) -> some View {
		switch page {
		case .hotel:
			HotelView()
		case .rooms:
			RoomsView(navigationTitle: "")
		case .register:
			RegisterView()
		case .booked:
			BookedView()
		}
	}
}
	
	// MARK: Flow Coordinator Bindings
//	private func bind(userCoordinator: UserFlowCoordinator) {
//		userCoordinator.pushCoordinator
//			.receive(on: DispatchQueue.main)
//			.sink(receiveValue: { [weak self] coordinator in
//				self?.push(coordinator)
//			})
//			.store(in: &cancellables)
//	}
//	
//	private func bind(settingsCoordinator: SettingsFlowCoordinator) {
//		settingsCoordinator.pushCoordinator
//			.receive(on: DispatchQueue.main)
//			.sink(receiveValue: { [weak self] coordinator in
//				self?.push(coordinator)
//			})
//			.store(in: &cancellables)
//	}
//	
//	private func bind(profileCoordinator: ProfileFlowCoordinator) {
//		profileCoordinator.pushCoordinator
//			.receive(on: DispatchQueue.main)
//			.sink(receiveValue: { [weak self] coordinator in
//				self?.push(coordinator)
//			})
//			.store(in: &cancellables)
//	}
//}

