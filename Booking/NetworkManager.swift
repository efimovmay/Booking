////
////  NetvorkManager.swift
////  Booking
////
////  Created by Aleksey Efimov on 19.12.2023.
////
//
//import Foundation
//import Combine
//
//enum link: String{
//	case hotelData = "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473"
//	case roomsData = "https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195"
//	case registerData = "https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff"
//}
//
//enum NetworkError: Error {
//	case invalidURL
//	case noData
//	case decodingError
//}
//
//class NetworkManger: ObservableObject {
//	static let shared = NetworkManger()
//	
//	private var cancellables = Set<AnyCancellable>()
//	
//	init() {}
//	
//	func fetchData<T: Decodable>(dataType: T.Type, from url: String? , completion: @escaping(Result<T, NetworkError>) -> Void) {
//		guard let url = URL(string: "https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff") else { return }
//		
//		let decoder = JSONDecoder()
//		decoder.keyDecodingStrategy = .convertFromSnakeCase
//		URLSession.shared.dataTaskPublisher(for: url)
//			.receive(on: DispatchQueue.main)
//			.tryMap(hanleOutput)
//			.decode(type: InfoBooking.self, decoder: decoder)
//			.sink { (completion) in
//				switch completion {
//				case .finished:
//					completion(.success(type))
//				case .failure(let error):
//					print("Error: \(error)")
//					self.hasError = true
//					self.isRefreshing = false
//				}
//			} receiveValue: { [weak self] info in
//				completion(.success(info))
//			}
//			.store(in: &cancellables)
//	}
//	
//	func hanleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
//		guard let response = output.response as? HTTPURLResponse,
//			  response.statusCode >= 200 && response.statusCode < 300 else {
//			throw URLError(.badServerResponse)
//		}
//		return output.data
//	}
//	
//	func fetch<T: Decodable>(dataType: T.Type, from url: String? , completion: @escaping(Result<T, NetworkError>) -> Void) {
//		guard let url = URL(string: url ?? "") else {
//			completion(.failure(.invalidURL))
//			return
//		}
//		
//		URLSession.shared.dataTask(with: url) { (data, _, error) in
//			guard let data = data else {
//				completion(.failure(.noData))
//				print(error?.localizedDescription ?? "No error description")
//				return
//			}
//			do {
//				let type = try JSONDecoder().decode(T.self, from: data)
//				DispatchQueue.main.async {
//					completion(.success(type))
//				}
//			} catch {
//				completion(.failure(.decodingError))
//			}
//		}.resume()
//	}
//}
