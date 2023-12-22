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
			//MARK: - "Отель"
			header
			
			//MARK: - Тэги
			TagsView(tags: viewModel.hotel.aboutTheHotel.peculiarities)
			
			//MARK: - Текстовая информаци об отеле
			Text(viewModel.hotel.aboutTheHotel.description)

			//MARK: - Удобства, Что включено...
			AboutButtonView()
		}
		.tileStyle()
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
