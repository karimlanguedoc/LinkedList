//
//  LinkedListNode.swift
//  Wanna
//
//  Created by Karim Languedoc on 4/12/23.
//  Copyright © 2023 Wanna. All rights reserved.
//

import Foundation

public class LinkedListNode<T: Codable & Equatable>: Codable, Equatable {
    public var value: T?
    
    public weak var previous: LinkedListNode?
    
    public var next: LinkedListNode?
    
    public init(value: T) {
        self.value = value
    }
    
    public static func == (lhs: LinkedListNode<T>, rhs: LinkedListNode<T>) -> Bool {
        return lhs.value == rhs.value
    }
}
