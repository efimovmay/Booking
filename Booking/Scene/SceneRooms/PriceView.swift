//
//  PriceView.swift
//  Booking
//
//  Created by Aleksey Efimov on 16.12.2023.
//

import SwiftUI

struct PriceView: View {
	let room: Room
	var body: some View {
		HStack (alignment: .bottom, spacing: 5) {
			Text(String(room.price.formattedWithSeparator))
				.font(.system(size: 30))
				.fontWeight(.semibold)
			
			Text("₽")
				.font(.system(size: 30))
				.fontWeight(.semibold)
			
			Text(room.pricePer)
				.font(.system(size: 16))
				.foregroundColor(Colors.grayText)
		}
		.padding(.top, 8)
	}
}

#Preview {
	PriceView(room: Room.getRoom())
}
