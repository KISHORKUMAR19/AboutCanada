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
        transport.fetch(request: request) { data in
            completion(Result { try JSONDecoder().decode(Model.self,
                                                         from: data.get()) })
        }
    }
}
