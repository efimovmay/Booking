//
//  RegisterView.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import SwiftUI

struct RegisterView: View {
	
	@StateObject private var viewModel = RegisterViewModel()
	
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
	}
	
	private func NextScreenView() -> some View {
		ZStack {
			Rectangle()
				.foregroundColor(.white)
			NextScreenButtonView(destination: .booked, title: viewModel.buttonNextScreenTitle)
				.padding(.top, 16.0)
				.padding(.bottom, 25)
			
		}
	}
}


struct RegisterView_Previews: PreviewProvider {
	static var previews: some View {
		RegisterView()
	}
}
