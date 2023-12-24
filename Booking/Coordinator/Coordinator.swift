//
//  AppCoordinator.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import SwiftUI
import Combine

enum Page: Hashable, Equatable {
	case hotel
	case rooms(title: String)
	case register
	case booked
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
		case .rooms(let title):
			getRoomsScene(title: title)
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
	
	func getRoomsScene(title: String) -> RoomsView {
		let viewModel = RoomsViewModel()
		let	view = RoomsView(viewModel: viewModel, navigationTitle: title)
		return view
	}
	
	func getRegisterScene() -> RegisterView {
		let viewModel = RegisterViewModel()
		let	view = RegisterView(viewModel: viewModel)
		return view
	}
}
