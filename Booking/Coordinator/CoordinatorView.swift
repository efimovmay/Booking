//
//  CoordinatorView.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import SwiftUI

struct CoordinatorView: View {
	
	@StateObject private var coordinator = Coordinator()

    var body: some View {
		NavigationStack(path: $coordinator.path) {
			coordinator.build(page: .hotel)
				.navigationDestination(for: Page.self) { page in
					coordinator.build(page: page)
				}
		}
		.environmentObject(coordinator)
    }
}
