//
//  VStackExtension.swift
//  Booking
//
//  Created by Aleksey Efimov on 17.12.2023.
//

import SwiftUI

extension VStack {
	func tileStyle() -> some View {
		self
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding(.horizontal, 16)
			.padding(.vertical, 16)
			.background(.white)
			.clipShape(RoundedRectangle(cornerRadius: 15))
	}
}

