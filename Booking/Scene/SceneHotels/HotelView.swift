//
//  HotelsView.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import SwiftUI

struct HotelView: View {
	
	@StateObject var viewModel: HotelViewModel
	
	var body: some View {
		ZStack {
			if viewModel.isRefreshing {
				ProgressView()
			} else {
				ScrollView {
					//MARK: - Основные данные об отеле
					InfoHotel(viewModel: viewModel)
					
					//MARK: - Подробные данные об отеле
					AboutHotelView(viewModel: viewModel)
					
					//MARK: - Кнопка выбора отеля
					NextScreenView()
				}
			}
		}
		.navigationBarBackButtonHidden()
		.ignoresSafeArea()
		.background(Colors.backgroundColor)
		
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
			NextScreenButtonView(
				destination: .rooms(title: viewModel.hotel.name),
				title: "К выбору номера"
			)
				.padding(.top, 16.0)
				.padding(.bottom, 25)
			
		}
	}
}

//#Preview {
//	HotelView(viewModel: HotelViewModel())
//}
