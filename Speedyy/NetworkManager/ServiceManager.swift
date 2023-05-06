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

struct APIResponse: Decodable {
    let errors: [ApiError]?
    let status: Bool?
    let statusCode: Int?
}

struct ApiError: Codable, Error {
    let code: Int?
    let message: String?
}

protocol ServiceManagerProtocol {
    func postApiData<T: Decodable>(requestUrl: URL,
                                   requestBody: Data?,
                                   resultType: T.Type,
                                   completion: @escaping (Result<T?, ApiError>) -> Void)
}

final class ServiceManager: ServiceManagerProtocol {
    func postApiData<T: Decodable>(requestUrl: URL,
                                   requestBody: Data?,
                                   resultType: T.Type,
                                   completion: @escaping (Result<T?, ApiError>) -> Void) {
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "post"

        if let requestBody {
            urlRequest.httpBody = requestBody
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        }

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data, error == nil else {
                if let error {
                    let apiError = ApiError(code: 0, message: error.localizedDescription)
                    completion(.failure(apiError))
                }
                return
            }
            do {
                let result1 = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let apiresponse = try JSONDecoder().decode(APIResponse.self, from: data)
                if apiresponse.status ?? true {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } else if let apiError = apiresponse.errors?.first {
                    completion(.failure(apiError))
                }
            } catch let error {
                let apiError = ApiError(code: 0, message: error.localizedDescription)
                completion(.failure(apiError))
            }
        }.resume()
    }
}
