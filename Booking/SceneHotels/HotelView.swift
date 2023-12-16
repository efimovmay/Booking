//
//  HotelsView.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import SwiftUI

struct HotelsView: View {
	@EnvironmentObject private var coordinator: Coordinator
	@StateObject private var viewModel = HotelViewModel()
	
	var body: some View {
		NavigationStack {
			ZStack {
				ScrollView {
					InfoHotel(viewModel: viewModel)
					AboutHotelView(viewModel: viewModel)
					ZStack {
						Divider()
						Rectangle()
							.foregroundColor(.white)
						ButtonView(textButton: "К выбору номера",
								   destenation: RoomsView(),
								   nameNewView: "") //viewModel.hotel[0].name)
//						Button("dfd") {
//							coordinator.push(.rooms)
//						}
						.padding(.top, 12)
						.padding(.bottom, 30)
					}
				}
				.ignoresSafeArea()
				.background(Colors.backgroundColor)
				.onAppear(perform: {
					viewModel.fetchData()
				})
			}
		}
		.onAppear(perform: {
			viewModel.fetchData()
		})
	}
	
}

#Preview {
    HotelsView()
}
