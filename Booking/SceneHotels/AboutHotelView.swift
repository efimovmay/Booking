//
//  AboutHotelView.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import SwiftUI

struct AboutHotelView: View {
	@ObservedObject var viewModel: HotelViewModel
	
	var body: some View {
		VStack (spacing: 16)  {
			header
			TagsView(tags: viewModel.hotel.aboutTheHotel.peculiarities)
			Text(viewModel.hotel.aboutTheHotel.description)
			AboutButtonView()
		}
		.padding(.vertical, 16)
		.padding(.horizontal, 16)
		.background(.white)
		.clipShape(RoundedRectangle(cornerRadius: 15))
	}
	
	private var header: some View {
		HStack {
			Text("Об отеле")
				.font(.system(size: 22))
				.fontWeight(.semibold)
			Spacer()
		}
	}
}

struct AboutHotelView_Previews: PreviewProvider {
	static var previews: some View {
		let vm = HotelViewModel()
		let _ = vm.fetchMocData()
		AboutHotelView(viewModel: vm)
	}
}
