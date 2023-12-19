//
//  CustomTextFieldView.swift
//  Booking
//
//  Created by Aleksey Efimov on 17.12.2023.
//

import SwiftUI

struct CustomTextFieldView: View {
	
	@Binding private var text: String
	private var title: String
	private var isSecure: Bool
	private var isValid: Bool?
	
	init(title: String, text: Binding<String>, isSecure: Bool = false, isValid: Bool? = true) {
		self.title = title
		self._text = text
		self.isSecure = isSecure
		self.isValid = isValid
	}
	
	var body: some View {
		
		ZStack(alignment: .leading) {
			
			if isSecure {
				SecureField("", text: $text)
					.textFieldStyle(CustomTextFieldStyle())
			} else  {
				TextField("", text: $text)
					.textFieldStyle(CustomTextFieldStyle())
			}
			Text(title)
				.foregroundColor(Colors.grayText)
				.padding(.horizontal)
				.offset(y: text.isEmpty ? 0 : -20)
				.scaleEffect(text.isEmpty ? 1 : 0.7, anchor: .leading)
				.animation(.default, value: text.isEmpty)
		}
	}
}

struct CustomTextFieldStyle: TextFieldStyle {
	func _body(configuration: TextField<Self._Label>) -> some View {
		return configuration
			.padding(.horizontal, 16)
			.frame(height: 52)
			.baselineOffset(-4)
			.autocorrectionDisabled()
			.textInputAutocapitalization(.never)
		
		
	}
}

struct CustomTextFeldView_Previews: PreviewProvider {
	static var previews: some View {
		CustomTextFieldView(title: "Name", text: .constant(""))
			.padding(16)
	}
}

