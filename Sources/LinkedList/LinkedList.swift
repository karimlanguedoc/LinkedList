//
//  LinkedList.swift
//
//  Created by Karim Languedoc on 4/9/23.
//

import Foundation

public class LinkedList<T: Codable & Equatable>: Codable {
    public typealias Node = LinkedListNode<T>
    public var head: Node?
    
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node? {
        return head
    }
    
    public var last: Node? {
        guard var node = head else { return nil }
        
        while let nextNode = node.next {
            node = nextNode
        }
        
        return node
    }

    public func rawList() -> [T] {
        var list: [T] = []
        
        guard !isEmpty else {
            return list
        }
        
        guard var node = head, let value = node.value else {
            return list
        }
        
        list.append(value)
        
        while let nextNode = node.next {
            
            if let value = nextNode.value {
                list.append(value)
            }
            
            node = nextNode
        }
        
        return list
    }
    
    public init() { }
    
    public init(from rawList: [T]) {
        
        for element in rawList {
            
            append(value: element)
            
        }
    }
}
