//
//  URLRequest+URL.swift
//  AboutCanada
//
//  Created by Sateesh Yemireddi on 7/3/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation

extension URLRequest {
    init(url: URL, method: HTTPMethod = .GET, body: Data? = nil, headers: HTTPHeaders? = HTTPHeaderField.default) {
        self.init(url: url)
        httpMethod = method.rawValue
        httpBody   = body
        if let headers = headers {
            for (headerField, headerValue) in headers {
                setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
    }
}
