//
//  NextScreenButtonView.swift
//  Booking
//
//  Created by Aleksey Efimov on 16.12.2023.
//

import SwiftUI

struct NextScreenButtonView: View {
	
	@EnvironmentObject private var coordinator: Coordinator
	let destination: Page
	
	var body: some View {
		ZStack {
			Divider()
			Rectangle()
				.foregroundColor(.white)
			
			Button {
				coordinator.push(destination)
			} label: {
				Text("К выбору номера")
					.styleButtonText()
			}
			.padding(.horizontal, 16.0)
			.padding(.vertical, 16.0)
			.padding(.bottom, 30)
			
		}
	}
}

extension Text {
	func styleButtonText() -> some View {
		self
			.fontWeight(.semibold)
			.frame(maxWidth: .infinity)
			.font(.system(size: 16))
			.foregroundColor(.white)
			.frame(height: 48.0)
			.background(.blue)
			.clipShape(
				RoundedRectangle(cornerRadius: 15)
			)
	}
}

struct NextScreenButtonView_Previews: PreviewProvider {
	static var previews: some View {
		NextScreenButtonView(destination: .hotel)
	}
}
