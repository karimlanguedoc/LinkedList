//
//  LinkedList+Extensions.swift
//
//  Created by Karim Languedoc on 4/10/23.
//

import Foundation

public extension LinkedList {
    func append(value: T) {
        let newNode = Node(value: value)
               
        if let lastNode = last {
            newNode.previous = last
            
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    
    func nodeAt(index: Int) -> Node? {
        if index == 0 {
            return head
        }
        
        var node = head?.next
        
        for _ in 1..<index {
            node = node?.next
        }
        
        return node
    }
    
    func insert(value: T, at index: Int) {
        let node = Node(value: value)
        
        if index == 0 {
            let next = head
            
            next?.previous = node
            
            node.next = next
            
            head = node
            
            return
        }
        
        let previous = nodeAt(index: index)?.previous
        
        let next = nodeAt(index: index)?.next
        
        previous?.next = node
        
        node.previous = previous
        
        node.next = next
        
        next?.previous = node
    }
    
    func removeAll() {
        head = nil
    }
    
    func removeAt(index: Int) -> Node? {
        let nodeToDelete = nodeAt(index: index)
        
        if index == 0 {
            let newHead = nodeToDelete?.next
            
            newHead?.previous = nil
            
            head = newHead
            
            return nodeToDelete
        }
        
        let previous = nodeToDelete?.previous
        
        let next = nodeToDelete?.next
        
        previous?.next = next
        
        next?.previous = previous
        
        return nodeToDelete
    }
    
    func firstIndexOf(value: T) -> Int? {
        let node = Node(value: value)
        
        guard var startingNode = head else {
            return nil
        }
        
        if node == startingNode {
            return 0
        }
        
        var index = 1
        while let nextNode = startingNode.next {
            startingNode = nextNode
            
            if nextNode == node {
                return index
            }
            index += 1
        }
        
        return nil
    }
}
