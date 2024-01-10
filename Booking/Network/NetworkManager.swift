//
//  NetvorkManager.swift
//  Booking
//
//  Created by Aleksey Efimov on 19.12.2023.
//

import Foundation
import Combine

enum NetworkError: Error {
	case invalidURL
	case responseError
	case unknown
}

extension NetworkError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .invalidURL:
			return NSLocalizedString("Invalid URL", comment: "Invalid URL")
		case .responseError:
			return NSLocalizedString("Unexpected status code", comment: "Invalid response")
		case .unknown:
			return NSLocalizedString("Unknown error", comment: "Unknown error")
		}
	}
}

protocol INetworkManger {
	func fetchData<T: Decodable>(url: String?, type: T.Type) -> Future<T, Error>
	func hanleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data
}

class NetworkManger: INetworkManger {
	
	private var cancellables = Set<AnyCancellable>()
	
	func fetchData<T: Decodable>(url: String?, type: T.Type) -> Future<T, Error> {
		return Future<T, Error> { [weak self] promise in
			guard let self = self, let url = URL(string: url ?? "") else {
				return promise(.failure(NetworkError.invalidURL))
			}
			
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			
			URLSession.shared.dataTaskPublisher(for: url)
				.receive(on: RunLoop.main)
				.tryMap(hanleOutput)
				.decode(type: T.self, decoder: decoder)
				.sink(receiveCompletion: { (completion) in
					if case let .failure(error) = completion {
						switch error {
						case let decodingError as DecodingError:
							promise(.failure(decodingError))
						case let apiError as NetworkError:
							promise(.failure(apiError))
						default:
							promise(.failure(NetworkError.unknown))
						}
					}
				}, receiveValue: { promise(.success($0)) })
				.store(in: &self.cancellables)
		}
	}
	
	func hanleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
		guard let response = output.response as? HTTPURLResponse,
			  response.statusCode >= 200 && response.statusCode < 300 else {
			throw URLError(.badServerResponse)
		}
		return output.data
	}
}
