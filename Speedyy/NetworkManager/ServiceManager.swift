//
//  ApiCaller.swift
//  Speedyy
//
//  Created by Shweta Talmale on 05/05/23.
//

import Foundation

// MARK:- MARKER Structure
struct EmptyData: Codable {
}

enum ApiError {
    case PhoneAlreadyExist
}

protocol ServiceManagerProtocol {
    func postApiData<T: Decodable>(requestUrl: URL,
                                   requestBody: Data?,
                                   resultType: T.Type,
                                   completion: @escaping (Result<T?, Error>) -> Void)
}

final class ServiceManager: ServiceManagerProtocol {
    func postApiData<T: Decodable>(requestUrl: URL,
                                   requestBody: Data?,
                                   resultType: T.Type,
                                   completion: @escaping (Result<T?, Error>) -> Void) {
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "post"

        if let requestBody {
            urlRequest.httpBody = requestBody
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        }

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            print(response)
            guard let data, error == nil else {
                completion(.failure(error!))
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
