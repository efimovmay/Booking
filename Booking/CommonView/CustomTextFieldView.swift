//
//  CustomTextFieldView.swift
//  Booking
//
//  Created by Aleksey Efimov on 17.12.2023.
//

import SwiftUI

struct CustomTextFieldView: View {
	
	private var title: String
	@Binding private var text: String
	private var prompt: String?
	private var isSecure: Bool
	
	init(title: String, text: Binding<String>, prompt: String? = nil, isSecure: Bool = false) {
		self.title = title
		self._text = text
		self.prompt = prompt
		self.isSecure = isSecure
	}
	
	var body: some View {
		
		ZStack(alignment: .leading) {
			
			if isSecure {
				SecureField(title, text: $text)
					.textFieldStyle(CustomTextFieldStyle())
			} else  {
				TextField(title, text: $text)
					.textFieldStyle(CustomTextFieldStyle())

			}
			
			if let prompt = prompt {
				Text(prompt)
					.foregroundColor(Colors.grayText)
					.padding(.horizontal)
					.offset(y: text.isEmpty ? 0 : -20)
					.scaleEffect(text.isEmpty ? 1 : 0.7, anchor: .leading)
					.animation(.default, value: text.isEmpty)
			}
		}
	}
}

struct CustomTextFieldStyle: TextFieldStyle {
	func _body(configuration: TextField<Self._Label>) -> some View {
		return configuration
			.padding(.horizontal, 16)
			.frame(height: 52)
			.background(Colors.backgroundColor.cornerRadius(15))
			.baselineOffset(-4)
			.autocorrectionDisabled()
			.textInputAutocapitalization(.never)
		
		
	}
}

struct CustomTextFeldView_Previews: PreviewProvider {
	static var previews: some View {
		CustomTextFieldView(title: "", text: .constant("") , prompt: "Name")
			.padding(16)
	}
}

