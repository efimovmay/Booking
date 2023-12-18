//
//  TouristsInfo.swift
//  Booking
//
//  Created by Aleksey Efimov on 17.12.2023.
//

import SwiftUI

struct TouristsInfo: View {
	
	@StateObject var viewModel: RegisterViewModel
	@State var name: String = ""
	@State var active: Bool = false
	
    var body: some View {
		
		VStack {
			HStack {
				Text("Первый турист")
				Spacer()
				Button(
					action: {
						active.toggle()
					}, label: {
						/*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
					}
				)
			}
			if active {
				TextField("", text: $name)
					.foregroundColor(.blue)
			}
		}
		.tileStyle()
		
    }
	
//	private func textfeeldTouristInfo(name: String) -> some View {
//		TextField("Имя", text: name)
//	}
}

#Preview {
	TouristsInfo(viewModel: RegisterViewModel())
}
