//
//  ImageStackView.swift
//  Booking
//
//  Created by Aleksey Efimov on 15.12.2023.
//

import SwiftUI

struct ImageStackView: View {
	let images: [String]
	
	var body: some View {
		TabView {
			ForEach(images, id: \.self) { imageURL in
				AsyncImage(url: URL(string: imageURL )) { phase in
					switch phase {
					case .empty:
						ProgressView()
					case .success(let image):
						image
							.resizable()
							.aspectRatio(contentMode: .fill)
							.transition(.opacity.combined(with: .scale))
					case .failure(_):
						Color.primary
					@unknown default:
						Color.yellow
					}
				}
			}
		}
		.frame(height: 257)
		.cornerRadius(15)
		.tabViewStyle(PageTabViewStyle())
		.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
	}
}

struct ImageStackView_Previews: PreviewProvider {
	static var previews: some View {
		ImageStackView(images: [
			"https://www.atorus.ru/sites/default/files/upload/image/News/56149/Club_Priv%C3%A9_by_Belek_Club_House.jpg",
			"https://deluxe.voyage/useruploads/articles/The_Makadi_Spa_Hotel_02.jpg",
			"https://deluxe.voyage/useruploads/articles/article_1eb0a64d00.jpg"
		])
	}
}
