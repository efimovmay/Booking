//
//  AboutButtonView.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import SwiftUI

struct RowInfoRoom: Hashable {
	let image: String
	let header: String
	let info: String
}

extension RowInfoRoom {
	static func getInfo() -> [RowInfoRoom] {
		let info: [RowInfoRoom] = [
			RowInfoRoom(image: "emoji-happy", header: "Удобства", info: "Самое необходимое"),
			RowInfoRoom(image: "tick-square", header: "Что включено", info: "Самое необходимое"),
			RowInfoRoom(image: "close-square", header: "Что не включено", info: "Самое необходимое")
		]
		return info
	}
}

struct AboutButtonView: View {
	var body: some View {
		List {
			ForEach(RowInfoRoom.getInfo(), id: \.self) { row in
				HStack (spacing: 16) {
					Image(row.image)
						.frame(width: 24.0, height: 24.0)
					VStack(alignment: .leading) {
						Text(row.header)
							.font(.system(size: 16))
							.multilineTextAlignment(.leading)
						Text(row.info)
							.font(.system(size: 14))
							.foregroundColor(Colors.grayText)
							.multilineTextAlignment(.leading)
					}
					Spacer()
					Image("Icons")
						.resizable()
						.frame(width: 24.0, height: 24.0)
				}
				.listRowBackground(Colors.grayColor)
			}
		}
		.listStyle(.inset)
		.cornerRadius(15)
		.frame(height: 174)
		.scrollDisabled(true)
	}
}

struct AboutButtonView_Previews: PreviewProvider {
	static var previews: some View {
		AboutButtonView()
	}
}

