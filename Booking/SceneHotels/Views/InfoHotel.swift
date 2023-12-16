//
//  InfoHotel.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import SwiftUI

struct InfoHotel: View {
	@ObservedObject var viewModel: HotelViewModel
	
	var body: some View {
		
		VStack (alignment: .leading, spacing: 10) {
			//MARK: - Name
			HStack {
				Spacer()
				Text("Отель")
					.fontWeight(.semibold)
					.padding(.top, 73)
					.padding(.bottom, 8)
					.font(.system(size: 18))
				Spacer()
			}
			
			//MARK: - Image
			ImageStackView(images: viewModel.hotel.imageUrls)
			
			// MARK: - rating
			StarRatingView(rating: viewModel.hotel.rating, ratingName: viewModel.hotel.ratingName)
			
			// MARK: - Adress, Name
			
			Text(viewModel.hotel.name)
				.fontWeight(.semibold)
				.font(.system(size: 22))
			Button {
				// action botton
			} label: {
				Text(viewModel.hotel.adress)
					.font(.system(size: 14))
			}
			// MARK: - Price
			
			HStack (alignment: .bottom, spacing: 16) {
				Text(viewModel.minimalPriceText)
					.font(.system(size: 30))
					.fontWeight(.semibold)
				Text(viewModel.hotel.priceForIt)
					.font(.system(size: 16))
					.foregroundColor(Colors.grayText)
			}
			.padding(.bottom, 16.0)
			.padding(.top, 8)
			
		}
		.padding(.horizontal, 16)
		.background(.white)
		.clipShape(RoundedRectangle(cornerRadius: 15))
		
	}
}

#Preview {
	InfoHotel(viewModel: HotelViewModel())
}
