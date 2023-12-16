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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CoordinatorView()
}
