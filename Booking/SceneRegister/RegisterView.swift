//
//  RegisterView.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import SwiftUI

struct RegisterView: View {
	
	@StateObject private var viewModel = RegisterViewModel()
	@EnvironmentObject private var coordinator: Coordinator
	@State private var isShowAlert: Bool = false
	
	var body: some View {
		ScrollView {
			if viewModel.isRefreshing {
				ProgressView()
			} else {
				VStack (spacing: 10) {
					//MARK: - Блок с отелем
					HeadSection(viewModel: viewModel)
					
					//MARK: - Блок с данными брони
					InfoBookingView(viewModel: viewModel)
					
					//MARK: - Блок с информацией о покупателе
					InfoPersonView(viewModel: viewModel)
					
					//MARK: - Блок с информацией о туристах
					TouristsInfo(viewModel: viewModel)
					
					//MARK: - Блок с итоговой ценой
					FinalPriceView(viewModel: viewModel)

					//MARK: - Блок с кнопкой следующего экрана
					NextScreenView()
				}
			}
		}
		.scrollViewStyle(title: "Бронирование")
		
		.alert("Ошибка загрузки данных", isPresented: $viewModel.hasError) {
			Button("Да") { viewModel.fetchMocData() }
			Button("Повторить") { viewModel.fetchData() }
		} message: {
			Text("Отобразить с мок данными?")
		}
		
		.alert("Ошибка", isPresented: $isShowAlert) {
			Button("ОК") { }
		} message: {
			Text("Проверте выделенные поля")
		}
	}
	
	private func NextScreenView() -> some View {
		ZStack {
			Rectangle()
				.foregroundColor(.white)
			Button {
				viewModel.checkEmptyTextField()
				if viewModel.canSubmit {
					coordinator.push(.booked)
				} else {
					isShowAlert.toggle()
				}
			} label: {
				Text(viewModel.nameNextScteenButton)
					.styleNextScreenButtonText()
			}
			.padding(.horizontal, 16.0)
		}
	}
}


struct RegisterView_Previews: PreviewProvider {
	static var previews: some View {
		RegisterView()
	}
}
