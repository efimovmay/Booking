//
//  InfoBookingView.swift
//  Booking
//
//  Created by Aleksey Efimov on 17.12.2023.
//

import SwiftUI

struct InfoBookingView: View {
	
	@StateObject var viewModel: RegisterViewModel
	
	let columns = [GridItem(.flexible(maximum: 150)),
				   GridItem(.flexible())]
	var body: some View {
		LazyVGrid (columns: columns, alignment: .leading, spacing: 10) {
			Text("Вылет из")
				.foregroundColor(Colors.grayText)
			Text(viewModel.infoBooking.departure)
			Text("Страна, город")
				.foregroundColor(Colors.grayText)
			Text(viewModel.infoBooking.arrivalCountry)
			Text("Даты")
				.foregroundColor(Colors.grayText)
			Text(viewModel.dataBooking)
			Text("Кол-во ночей")
				.foregroundColor(Colors.grayText)
			Text(String(viewModel.numberNight))
			Text("Отель")
				.foregroundColor(Colors.grayText)
			Text(viewModel.infoBooking.hotelName)
		}
		.padding(.horizontal, 16)
		.padding(.vertical, 16)
		.background(.white)
		.clipShape(RoundedRectangle(cornerRadius: 15))
	}
}


struct InfoBookingView_Previews: PreviewProvider {
	static var previews: some View {
		InfoBookingView(viewModel: RegisterViewModel())
	}
}
