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
	@State var t: [Tourist] = []
	
	
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
						CustomTextFieldView(title: "", text: $viewModel.touristsInfo[index].name, prompt: "Имя")
						CustomTextFieldView(title: "", text: $viewModel.touristsInfo[index].surname, prompt: "Фамилия")
						CustomTextFieldView(title: "", text: $viewModel.touristsInfo[index].dateOfBirth, prompt: "Дата рождения")
						CustomTextFieldView(title: "", text: $viewModel.touristsInfo[index].citizenship, prompt: "Гражданство")
						CustomTextFieldView(title: "", text: $viewModel.touristsInfo[index].numberPass, prompt: "Номер загран паспорта")
						CustomTextFieldView(title: "", text: $viewModel.touristsInfo[index].validityPass, prompt: "Срок действия загран паспорта")
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
						viewModel.addTourist()
						t.append(Tourist.getTourist())
					}, label: {
						Image(systemName: "plus.app.fill")
							.resizable()
							.frame(width: 32, height: 32)
							.foregroundColor(Colors.blueButton)
					}
				)
			}
		}
		.tileStyle()
    }
}

#Preview {
	TouristsInfo(viewModel: RegisterViewModel())
}
