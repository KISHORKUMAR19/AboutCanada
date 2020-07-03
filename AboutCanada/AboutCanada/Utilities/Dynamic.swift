//
//  Dynamic.swift
//  AboutCanada
//
//  Created by Sateesh Yemireddi on 7/3/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation

struct Dynamic<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    mutating func bind(listener: Listener?) {
        self.listener = listener
    }
    
    mutating func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
