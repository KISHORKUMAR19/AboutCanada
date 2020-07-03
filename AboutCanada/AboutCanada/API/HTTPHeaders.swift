//
//  HTTPHeaders.swift
//  AboutCanada
//
//  Created by Sateesh Yemireddi on 7/3/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPHeaderField: String {
    case accept                      = "Accept"
    case contentType                 = "Content-Type"
}

extension HTTPHeaderField {
    public enum Value: String {
        case applicationJSON = "application/json"
    }
    static public var `default`: HTTPHeaders {
        var headerFields = [HTTPHeaderField: HTTPHeaderField.Value]()
        headerFields[.accept] = .applicationJSON
        headerFields[.contentType] = .applicationJSON
        
        var headers = HTTPHeaders()
        headerFields.forEach {
            headers[$0.key.rawValue] = $0.value.rawValue
        }
        return headers
    }
}

public extension URLRequest {
    func value(for HTTPHeaderField: HTTPHeaderField) -> String? {
        return value(forHTTPHeaderField: HTTPHeaderField.rawValue)
    }
    mutating func setValue(_ value: String?, for HTTPHeaderField: HTTPHeaderField) {
        setValue(value, forHTTPHeaderField: HTTPHeaderField.rawValue)
    }
}

