//
//  ButtonView.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import SwiftUI

struct ButtonView<Destenation: View>: View {
	let textButton: String
	let destenation: Destenation
	let nameNewView: String
	
	var body: some View {
		NavigationLink(
			destination: destenation
				.toolbarRole(.editor)
				.navigationTitle(nameNewView)) {
					Text(textButton)
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
				.padding(.horizontal, 16.0)
	}
}

struct ButtonView_Previews: PreviewProvider {
	static var previews: some View {
		ButtonView(textButton: "press", destenation: HotelView(), nameNewView: "")
	}
}

