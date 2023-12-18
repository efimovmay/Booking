//
//  BookedView.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import SwiftUI

struct BookedView: View {
	
	@EnvironmentObject private var coordinator: Coordinator
	
	var body: some View {
		VStack {
			imageCongratulations
			textTitle
			textMain
			Spacer()
			Divider()
			buttonToRoot
		}
		.navigationBarTitleDisplayMode(.inline)
	}

	private var buttonToRoot: some View {
		Button {
			coordinator.popToRoot()
		} label: {
			Text("Супер!")
				.styleButtonText()
		}
		.padding(.horizontal, 16.0)
		.padding(.bottom, 16.0)
	}
	
	private var imageCongratulations: some View {
		ZStack {
			Circle()
				.frame(width: 94.0, height: 94.0)
				.foregroundColor(Colors.backgroundColor)
			Image("PartyPopper")
				.frame(width: 44, height: 44)
		}
		.padding(.top, 122.0)
	}
	
	private var textTitle: some View {
		Text("Ваш заказ принят в работу")
			.font(.system(size: 22))
			.fontWeight(.semibold)
			.padding(.top, 32)
	}
	
	private var textMain: some View {
		Text("Подтверждение заказа №104893 может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.")
			.foregroundColor(Color.gray)
			.multilineTextAlignment(.center)
			.padding([.top, .leading, .trailing], 16.0)
			.font(.system(size: 16))
	}
	
}


struct BookedView_Previews: PreviewProvider {
	static var previews: some View {
		BookedView()
	}
}
