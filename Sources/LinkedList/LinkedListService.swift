//
//  LinkedListService.swift
//
//  Created by Karim Languedoc on 4/9/23.
//

import Foundation

public final class LinkedListService<T: Codable & Equatable> {
    
    enum Error: String, LocalizedError {
        case unableToEncode = "Unable to encode object into data"
        
        case unableToDecode = "Unable to decode object into data"
        
        var errorDescription: String? {
            return rawValue
        }
    }
    
    private let globalListKey: String
    
    private let userDefaults = UserDefaults.standard
    
    private let globalList: LinkedList<T>
    
    public init(key: String = "com.kl.list") {
        self.globalListKey = key
        
        if let savedData = userDefaults.data(forKey: globalListKey) {
            do {
                let decoder = JSONDecoder()
            
                let decodedRawList = try decoder.decode(
                    [T].self,
                    from: savedData
                )
                
                let linkedList = LinkedList(from: decodedRawList)
                
                globalList = linkedList
            } catch {
                globalList = LinkedList<T>()
            }
        } else {
            globalList = LinkedList<T>()
        }
    }
}

public extension LinkedListService {
    func save() throws {
        do {
            defer {
                userDefaults.synchronize()
            }
            
            let rawList = globalList.rawList()
            
            guard !rawList.isEmpty else {
                userDefaults.removeObject(forKey: globalListKey)
                
                return
            }
            
            let encoder = JSONEncoder()
        
            let data = try encoder.encode(rawList)

            userDefaults.set(data, forKey: globalListKey)
        } catch {
            throw Error.unableToEncode
        }
    }
    
    func removeIfExists(searchedItem: T) {
        if let index = globalList.firstIndexOf(value: searchedItem) {
            _ = globalList.removeAt(index: index)
            
            try? save()
        }
    }
    
    func add(searchedItem: T) {
        globalList.append(value: searchedItem)
        
        try? save()
    }
    
    func add(searchedItem: T, at index: Int) {
        globalList.insert(value: searchedItem, at: index)
        
        try? save()
    }
    
    func removeAll() {
        globalList.removeAll()
        
        try? save()
    }
    
    func removeAt(index: Int) -> LinkedListNode<T>? {
        let fetchedItem = fetchItemAt(index: index)
        
        _ = globalList.removeAt(index: index)
        
        try? save()
 
        return fetchedItem
    }
    
    func fetchItemAt(index: Int) -> LinkedListNode<T>? {
        return globalList.nodeAt(index: index)
    }
    
    func fetchWithLimit(_ limit: Int) -> [LinkedListNode<T>] {
        var fetchedList: [LinkedListNode<T>] = []
        
        guard var node = globalList.head else {
            return fetchedList
        }
        
        fetchedList.append(node)
        
        while let nextNode = node.next {
            node = nextNode
            
            fetchedList.append(nextNode)
        }
        
        let finalList = fetchedList.reversed().limit(limit)
        
        return finalList
    }
}

extension Sequence {
    func limit(_ max: Int) -> [Element] {
        return self.enumerated()
            .filter { $0.offset < max }
            .map { $0.element }
    }
}
