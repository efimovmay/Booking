//
//  HeadSection.swift
//  Booking
//
//  Created by Aleksey Efimov on 17.12.2023.
//

import SwiftUI

struct HeadSection: View {
	
	@StateObject var viewModel: RegisterViewModel
	
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			StarRatingView(rating: viewModel.infoBooking.horating, ratingName: viewModel.infoBooking.ratingName)
			Text(viewModel.infoBooking.hotelName)
				.fontWeight(.semibold)
				.font(.system(size: 22))
			Button {
				// action botton
			} label: {
				Text(viewModel.infoBooking.hotelAdress)
					.font(.system(size: 14))
			}
		}
		.tileStyle()
	}
}


struct HeadSection_Previews: PreviewProvider {
	static var previews: some View {
		let vm = RegisterViewModel(networkManager: NetworkManger())
		let _ = vm.fetchMocData()
		HeadSection(viewModel: vm)
	}
}

