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
			//MARK: - Header
			header
			
			//MARK: - Image
			ImageStackView(images: viewModel.hotel.imageUrls)
			
			// MARK: - rating
			StarRatingView(rating: viewModel.hotel.rating, ratingName: viewModel.hotel.ratingName)
			
			// MARK: - Name
			textName(text: viewModel.hotel.name)

			// MARK: - Adress
			adressButton(text: viewModel.hotel.adress)
			
			// MARK: - Price
			price(minPrice: viewModel.minimalPriceText, priceForIt: viewModel.hotel.priceForIt)
		}
		.padding(.horizontal, 16)
		.background(.white)
		.clipShape(RoundedRectangle(cornerRadius: 15))
		
	}
	
	private var header: some View {
		HStack {
			Spacer()
			Text("Отель")
				.fontWeight(.semibold)
				.padding(.top, 73)
				.padding(.bottom, 8)
				.font(.system(size: 18))
				.frame(alignment: .center)
			Spacer()
		}
	}
	
	private func textName(text: String) -> some View {
		Text(text)
			.fontWeight(.semibold)
			.font(.system(size: 22))
	}
	
	private func adressButton(text: String) -> some View {
		Button {
			// action botton
		} label: {
			Text(text)
				.font(.system(size: 14))
		}
	}
	
	private func price(minPrice: String, priceForIt: String) -> some View {
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
}

struct InfoHotel_Previews: PreviewProvider {
	static var previews: some View {
		let vm = HotelViewModel()
		let _ = vm.fetchMocData()
		InfoHotel(viewModel: vm)
	}
}
