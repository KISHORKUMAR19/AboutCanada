//
//  JSONResponse.swift
//  AboutCanada
//
//  Created by Sateesh Yemireddi on 7/3/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation

struct JSONResponse<T: Codable>: Codable {
    var title: String
    var specifications: [T]
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case specifications = "rows"
    }
}
