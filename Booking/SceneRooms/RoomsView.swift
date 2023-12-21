//
//  RoomsView.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import SwiftUI

struct RoomsView: View {
	
	@StateObject private var viewModel = RoomsViewModel()
	
	let navigationTitle: String
	
	var body: some View {
		ZStack {
			if viewModel.isRefreshing {
				ProgressView()
			} else {
				ScrollView {
					ForEach(viewModel.rooms, id: \.id) { room in
						VStack (alignment: .leading) {
							//MARK: - Image
							ImageStackView(images: room.imageUrls)
							
							//MARK: - Name
							textName(name: room.name)
							
							//MARK: - Tags
							TagsView(tags: room.peculiarities)
							
							//MARK: - buttonAbout
							buttonAbout()
							
							//MARK: - Price
							PriceView(room: room)
							
							//MARK: - Next screen button
							NextScreenButtonView(destination: .register, title: "Выбрать номер")
						}
						.tileStyle()
					}
				}
				.scrollViewStyle()
			}
		}
		.navigationTitle("Номера")
		
		.alert("Ошибка загрузки данных", isPresented: $viewModel.hasError) {
			Button("Да") { viewModel.fetchMocData() }
			Button("Повторить") { viewModel.fetchData() }
		} message: {
			Text("Отобразить с мок данными?")
		}
	}
	
	private func buttonAbout() -> some View {
		Button {
			// action
		} label: {
			HStack {
				Text("Подробнее о номере")
					.font(.system(size: 16))
				Image("BlueButtonIcons")
					.resizable()
					.frame(width: 24, height: 24)
			}
			.frame(height: 29)
			.padding(.horizontal, 5)
			.background(Colors.blueButton.opacity(0.1))
			.clipShape(RoundedRectangle(cornerRadius: 5))
		}
	}
	
	private func textName(name: String) -> some View {
		Text(name)
			.font(.system(size: 22))
			.fontWeight(.semibold)
	}
}

#Preview {
	RoomsView(navigationTitle: "room")
}
