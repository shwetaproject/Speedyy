//
//  ApiCaller.swift
//  Speedyy
//
//  Created by Shweta Talmale on 05/05/23.
//

import Foundation

final class ApiCaller {
    func registerUser(userInfo: RegisterNewUser, completion: @escaping (Result<Void, Error>) -> Void) {
        let urlStr = "https://api.dev.speedyy.com/user/customer/auth/register/otp"
        guard let url = URL(string: urlStr) else { return }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "post"

        do {
            let requestBody = try JSONEncoder().encode(userInfo)
            urlRequest.httpBody = requestBody
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        } catch let error {
            print(error)
        }

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            print(response)
            guard let data, error == nil else {
                completion(.failure(error!))
                return
            }


            do {
                let result = try JSONDecoder().decode(EmptyData.self, from: data)
                completion(.success(()))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }

    func verifyRegistrationOtp(otp: VerifyOTP, completion: @escaping (Result<RegistrationOTPResult, Error>) -> Void) {
        let urlStr = "https://api.dev.speedyy.com/user/customer/auth/register/verify"
        guard let url = URL(string: urlStr) else { return }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "post"

        do {
            let requestBody = try JSONEncoder().encode(otp)
            urlRequest.httpBody = requestBody
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        } catch let error {
            print(error)
        }

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            print(response)
            guard let data, error == nil else {
                completion(.failure(error!))
                return
            }


            do {
                if let result = try JSONDecoder().decode(RegistrationOTPResponse.self, from: data).result {
                    completion(.success((result)))
                }
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }

    func loginUser(phoneNumber: LoginPhoneNumber, completion: @escaping (Result<Void, Error>) -> Void) {
        let urlStr = "https://api.dev.speedyy.com/user/customer/auth/login/otp"
        guard let url = URL(string: urlStr) else { return }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "post"

        do {
            let requestBody = try JSONEncoder().encode(phoneNumber)
            urlRequest.httpBody = requestBody
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        } catch let error {
            print(error)
        }

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            print(response)
            guard let data, error == nil else {
                completion(.failure(error!))
                return
            }


            do {
                let result = try JSONDecoder().decode(EmptyData.self, from: data)
                completion(.success(()))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }

    func verifyLoginOtp(otp: VerifyOTP, completion: @escaping (Result<LoginOTPResult, Error>) -> Void) {
        let urlStr = "https://api.dev.speedyy.com/user/customer/auth/login/verify"
        guard let url = URL(string: urlStr) else { return }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "post"

        do {
            let requestBody = try JSONEncoder().encode(otp)
            urlRequest.httpBody = requestBody
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        } catch let error {
            print(error)
        }

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            print(response)
            guard let data, error == nil else {
                completion(.failure(error!))
                return
            }


            do {
                //                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                //                print(result)
                //                if let jsonDict = result as? NSDictionary {
                //                        print (jsonDict)
                //                    }
                let result = try JSONDecoder().decode(LoginOTPResponse.self, from: data)
                print(result)
                if let responseData = result.result {
                    completion(.success((responseData)))
                }


            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }

    func updateUserInfo(userInfo: UpdateUserInfo, userId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let urlStr = "https://api.dev.speedyy.com/user/customer/\(userId)"
        guard let url = URL(string: urlStr) else { return }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "put"

        do {
            let requestBody = try JSONEncoder().encode(userInfo)
            urlRequest.httpBody = requestBody
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        } catch let error {
            print(error)
        }

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            print(response)
            guard let data, error == nil else {
                completion(.failure(error!))
                return
            }

            do {
                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(result)
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
