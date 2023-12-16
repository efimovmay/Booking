//
//  StarRatingView.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import SwiftUI

struct StarRatingView: View {
	
	let rating: Int
	let ratingName: String
	
	var body: some View {
		HStack (spacing: 5) {
			Image("Star")
				.resizable()
				.frame(width: 15, height: 15)
			Text(String(rating))
			Text(ratingName)
		}
		.padding(.horizontal, 16)
		.foregroundColor(Colors.backgroundStar)
		.fontWeight(.semibold)
		.frame(height: 29)
		.background(Colors.backgroundStar.opacity(0.2))
		.clipShape(RoundedRectangle(cornerRadius: 5))
	}
}

struct StarRatingView_Previews: PreviewProvider {
	static var previews: some View {
		StarRatingView(rating: 2, ratingName: "good")
	}
}
