//
//  APIClient.swift
//  AboutCanada
//
//  Created by Sateesh Yemireddi on 7/3/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation

final class APIClient {
    let transport: Transport
    let request: URLRequest
    
    init(transport: Transport = URLSession.shared, with request: URLRequest) {
        self.transport = transport
        self.request = request
    }
    
    func fetch<Model: Codable>(_ model: Model.Type = Model.self,
                                 completion: @escaping(Result<Model, Error>) -> Void) {
        if InternetConnection.shared.isConnected == false {
            completion(.failure(NetworkError.noNetwork))
            return
        }
        transport.fetch(request: request) { result in
            print(try? result.get().prettyPrittedString)
            completion(Result { try JSONDecoder().decode(Model.self,
                                                         from: result.get()) })
            return
        }
    }
}

public extension Data {
    func decoded<T: Decodable>(using decoder: JSONDecoder = JSONDecoder()) throws -> T {
        try decoder.decode(T.self, from: self)
    }
    var prettyPrittedString: String {
        if let object = try? JSONSerialization.jsonObject(with: self,
                                                          options: .mutableLeaves),
            JSONSerialization.isValidJSONObject(object),
            let data = try? JSONSerialization.data(withJSONObject: object,
                                                   options: .prettyPrinted) {
            return String(decoding: data, as: UTF8.self)
        } else {
            return String(decoding: self, as: UTF8.self)
        }
    }
}
