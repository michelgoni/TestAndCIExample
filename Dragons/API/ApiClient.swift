//
//  ApiClient.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import Foundation


protocol ApiClient {
    
    var session: URLSession {get}
    var printsDebug: Bool {get}
    func fetch<T: Codable>(with request: URLRequest, decode: @escaping (Codable) -> T?, completion: @escaping (Result<T, ApiError>) -> Void)
}

extension ApiClient {
    
    typealias JSONTaskCompletion = (Decodable?, ApiError?) -> Void
    
    func fetch<T: Codable>(with request: URLRequest, decode: @escaping (Codable) -> T?, completion: @escaping (Result<T, ApiError>) -> Void) {
        
        let task = decodingTask(with: request, decodingType: T.self) { (json , error) in
            if self.printsDebug {
                debugPrint(request)
            }
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    return
                }
                if let value = decode(json as! Codable) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        task.resume()
    }
    
    func decodingTask<T: Codable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletion) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                        
                        completion(genericModel, nil)
                    } catch {
                        completion(nil, .jsonParsingFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }
}
