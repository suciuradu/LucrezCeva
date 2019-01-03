//
//  DynamicValue.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 02/01/2019.
//  Copyright © 2019 LucrezCeva. All rights reserved.
//

import Foundation

class DynamicValue<T> {
    typealias Listener = (T) -> ()
    var listeners = [Listener]()
    
    func bind(_ listener: @escaping Listener) {
        self.listeners.append(listener)
    }
    
    func bindAndFire(_ listener: @escaping Listener) {
        self.listeners.append(listener)
        listener(value)
    }
    
    var value: T {
        didSet {
            for item in listeners {
                item(value)
            }
        }
    }
    
    init(_ v: T) {
        value = v
    }
}