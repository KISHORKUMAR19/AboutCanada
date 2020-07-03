//
//  APITransport.swift
//  AboutCanada
//
//  Created by Sateesh Yemireddi on 7/3/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation

public typealias ServiceHandler = ((Result<Data, Error>) -> Void)

public protocol Transport {
    func fetch(request: URLRequest, completion: @escaping ServiceHandler)
}

extension URLSession: Transport {
    public func fetch(request: URLRequest, completion: @escaping ServiceHandler) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if (400..<499 ~= statusCode) {
                    completion(.failure(NetworkError.request))
                } else if (500..<599 ~= statusCode) {
                    completion(.failure(NetworkError.server))
                }
            }
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
