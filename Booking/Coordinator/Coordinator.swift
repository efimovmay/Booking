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
			getHotelScene()
		case .rooms:
			getRoomsScene()
		case .register:
			getRegisterScene()
		case .booked:
			BookedView()
		}
	}
	
	func getHotelScene() -> HotelView {
		let viewModel = HotelViewModel()
		let	view = HotelView(viewModel: viewModel)
		return view
	}
	
	func getRoomsScene() -> RoomsView {
		let viewModel = RoomsViewModel()
		let	view = RoomsView(viewModel: viewModel, navigationTitle: "viewModel")
		return view
	}
	
	func getRegisterScene() -> RegisterView {
		let viewModel = RegisterViewModel()
		let	view = RegisterView(viewModel: viewModel)
		return view
	}
}
