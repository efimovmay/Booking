//
//  FinalPrice.swift
//  Booking
//
//  Created by Aleksey Efimov on 17.12.2023.
//

import SwiftUI

struct FinalPriceView: View {
	
	@StateObject var viewModel: RegisterViewModel
	
	let columns = [GridItem(.flexible(maximum: 150)),
				   GridItem(.flexible())]
	var body: some View {
		LazyVGrid (columns: columns, alignment: .leading, spacing: 10) {
			Text("Тур")
				.foregroundColor(Colors.grayText)
			leftText(text: viewModel.tourPriceString)
			Text("Топливный сбор")
				.foregroundColor(Colors.grayText)
			leftText(text: viewModel.fuelChargeString)
			Text("Сервисный сбор")
				.foregroundColor(Colors.grayText)
			leftText(text: viewModel.serviceChargeString)
			Text("К оплате")
				.foregroundColor(Colors.grayText)
			leftText(text: viewModel.finalPriceString)
				.foregroundColor(.blue)
		}
		.padding(.horizontal, 16)
		.padding(.vertical, 16)
		.background(.white)
		.clipShape(RoundedRectangle(cornerRadius: 15))
	}
	
	private func leftText(text: String) -> some View {
		HStack {
			Spacer()
			Text(text)
		}
	}
}

struct FinalPriceView_Previews: PreviewProvider {
	static var previews: some View {
		FinalPriceView(viewModel: RegisterViewModel())
	}
}
