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
	let title: String
	
	var body: some View {

			Button {
				coordinator.push(destination)
			} label: {
				Text(title)
					.styleNextScreenButtonText()
			}
			.padding(.horizontal, 16.0)
	}
}

extension Text {
	func styleNextScreenButtonText() -> some View {
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
		NextScreenButtonView(destination: .hotel, title: "Button")
	}
}
