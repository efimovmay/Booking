//
//  TouristsInfo.swift
//  Booking
//
//  Created by Aleksey Efimov on 17.12.2023.
//

import SwiftUI

struct TouristsInfo: View {
	
	@StateObject var viewModel: RegisterViewModel
	
	@State var isMaxTourist: Bool = false
	@State var isTextFeeld: Bool = false

    var body: some View {
		ForEach($viewModel.touristsInfo.indices, id: \.self) { index in
				VStack {
					HStack {
						Text("Первый турист")
						Spacer()
						Button(
							action: {
								viewModel.touristsInfo[index].isActive.toggle()
							}, label: {
								ZStack {
									Image(systemName: "chevron.up")
										.resizable()
										.rotationEffect(.degrees(viewModel.touristsInfo[index].isActive ? 0 : 180))
										.frame(width: 12, height: 6)
										.foregroundColor(Colors.blueButton)
									Rectangle()
										.frame(width: 32, height: 32)
										.cornerRadius(6)
										.foregroundColor(Colors.blueButton.opacity(0.1))
								}
							}
						)
					}
					if viewModel.touristsInfo[index].isActive {
						CustomTextFieldView(
							title: "Имя",
							text: $viewModel.touristsInfo[index].name
						)
						.background(Colors.backgroundColor.cornerRadius(15))
						
						CustomTextFieldView(
							title: "Фамилия",
							text: $viewModel.touristsInfo[index].surname
						)
						.background(Colors.backgroundColor.cornerRadius(15))
						
						CustomTextFieldView(
							title: "Дата рождения",
							text: $viewModel.touristsInfo[index].dateOfBirth
						)
						.background(Colors.backgroundColor.cornerRadius(15))
						
						CustomTextFieldView(
							title: "Гражданство",
							text: $viewModel.touristsInfo[index].citizenship
						)
						.background(Colors.backgroundColor.cornerRadius(15))
						
						CustomTextFieldView(
							title: "Номер загран паспорта",
							text: $viewModel.touristsInfo[index].numberPass
						)
						.background(Colors.backgroundColor.cornerRadius(15))
						
						CustomTextFieldView(
							title: "Срок действия загран паспорта",
							text: $viewModel.touristsInfo[index].validityPass
						)
						.background(Colors.backgroundColor.cornerRadius(15))
					}
				}
				.tileStyle()
				.animation(.default, value: viewModel.touristsInfo[index].isActive )
		}

		// MARK: - Добавить туриста
		HStack {
			HStack {
				Text("Добавить туриста")
				Spacer()
				Button(
					action: {
						if viewModel.touristsInfo.count <= 2 {
							viewModel.addTourist()
						} else {
							isMaxTourist.toggle()
						}
					}, label: {
						Image(systemName: "plus.app.fill")
							.resizable()
							.frame(width: 32, height: 32)
							.foregroundColor(Colors.blueButton)
					}
				)
			}
			.alert("Ошибка", isPresented: $isMaxTourist) {
				Button("ОК") { isMaxTourist.toggle() }
			} message: {
				Text("Максимальное число туристов")
			}
		}
		.tileStyle()
    }
}

#Preview {
	TouristsInfo(viewModel: RegisterViewModel())
}
