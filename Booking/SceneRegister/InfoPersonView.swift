//
//  InfoPersonView.swift
//  Booking
//
//  Created by Aleksey Efimov on 17.12.2023.
//

import SwiftUI

struct InfoPersonView: View {
	
	@StateObject var viewModel: RegisterViewModel
	

	
	var body: some View {
		VStack(alignment: .leading) {
			Text("Информация о покупателе")
				.fontWeight(.semibold)
				.font(.system(size: 22))
			
			CustomTextFieldView(title: "Номер Телефона", text: $viewModel.phoneNumber)
				.background(
					viewModel.isPhoneValid
					? Colors.backgroundColor.cornerRadius(15)
					: Colors.redTextFeeld.opacity(0.15).cornerRadius(15)
				)
				.onChange(of: viewModel.phoneNumber) { newValue in
					DispatchQueue.main.async {
						viewModel.phoneNumber = viewModel.phoneNumber.formattedMask(text: viewModel.phoneNumber, mask: "+X (XXX) XXX-XX-XX")
					}
				}
			CustomTextFieldView(title: "Почта", text: $viewModel.email)
				.background(
					viewModel.isEmailValid
					? Colors.backgroundColor.cornerRadius(15)
					: Colors.redTextFeeld.opacity(0.15).cornerRadius(15)
				)
			text
		}
		.tileStyle()
	}
	var text: some View {
		Text("Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
			.foregroundColor(Colors.grayText)
			.font(.system(size: 14))
	}
}
	


struct InfoPersonView_Previews: PreviewProvider {
	static var previews: some View {
		let vm = RegisterViewModel()
		let _ = vm.fetchMocData()
		InfoPersonView(viewModel: vm)
	}
}
