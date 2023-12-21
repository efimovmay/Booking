//
//  TagsView.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import SwiftUI

struct TagsView: View {
	let tags: [String]
	@State private var totalHeight = CGFloat.zero
	
	var body: some View {
		GeometryReader { geometry in
			self.generateContent(in: geometry)
		}.frame(height: totalHeight)
	}
	
	private func generateContent(in g: GeometryProxy) -> some View {
		var width = CGFloat.zero
		var height = CGFloat.zero
		
		return ZStack(alignment: .topLeading) {
			ForEach(self.tags, id: \.self) { tag in
				self.item(for: tag)
					.padding([.horizontal, .vertical], 4)
					.alignmentGuide(.leading, computeValue: { d in
						if (abs(width - d.width) > g.size.width)
						{
							width = 0
							height -= d.height
						}
						let result = width
						if tag == self.tags.last! {
							width = 0
						} else {
							width -= d.width
						}
						return result
					})
					.alignmentGuide(.top, computeValue: {d in
						let result = height
						if tag == self.tags.last! {
							height = 0
						}
						return result
					})
			}
		}.background(viewHeightReader($totalHeight))
	}
	
	func item(for text: String) -> some View {
		Text(text)
			.font(.system(size: 16))
			.padding(.horizontal, 10)
			.background(Colors.grayColor)
			.foregroundColor(Colors.grayText)
			.clipShape(RoundedRectangle(cornerRadius: 5))
	}
	
	private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
		return GeometryReader { geometry -> Color in
			let rect = geometry.frame(in: .local)
			DispatchQueue.main.async {
				binding.wrappedValue = rect.size.height
			}
			return .clear
		}
	}
}

struct TagsView_Previews: PreviewProvider {
	static var previews: some View {
		TagsView(tags: ["string","22", "33","44"])
	}
}
