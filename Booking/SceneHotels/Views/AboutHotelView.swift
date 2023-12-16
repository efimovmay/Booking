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
			HStack {
				Text("Об отеле")
					.font(.system(size: 22))
					.fontWeight(.semibold)
				Spacer()
			}
			TagsView(tags: viewModel.hotel.aboutTheHotel.peculiarities)
			Text(viewModel.hotel.aboutTheHotel.description)
			AboutButtonView()
		}
		.padding(.vertical, 16)
		.padding(.horizontal, 16)
		.background(.white)
		.clipShape(RoundedRectangle(cornerRadius: 15))
	}
}

struct AboutHotelView_Previews: PreviewProvider {
	static var previews: some View {
		AboutHotelView(viewModel: HotelViewModel())
	}
}

