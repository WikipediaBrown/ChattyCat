//
//  FirebaseArray.swift
//  ChattyCat
//
//  Created by Perris Davis on 9/4/17.
//  Copyright © 2017 I.am.GoodBad. All rights reserved.
//

import UIKit
import Firebase

class FirebaseArray {
    
    var array = [DataSnapshot]()
    
    private var handleArray = [DatabaseHandle]()
    
    let firebaseQuery: DatabaseQuery
    
    let identifier: String
    
    weak var delegate: FirebaseArrayDelegate?
    
    init(query: DatabaseQuery, identifier: String, delegate: FirebaseArrayDelegate) {
        
        self.delegate = delegate
        self.firebaseQuery = query
        self.identifier = identifier
        
        let added = firebaseQuery.observe(.childAdded, andPreviousSiblingKeyWith: { (snapshot, previousChildKey) in
            self.array.append(snapshot)
            self.delegate?.didAddSnapShot(snapshot: snapshot, atIndex: self.array.count - 1, arrayIdentifier: identifier)
        })
        
        let removed = firebaseQuery.observe(.childRemoved, andPreviousSiblingKeyWith: { (snapshot, previousChildKey) in
            let snapshotIndex = self.index(forKey: snapshot.key)
            self.array.remove(at: snapshotIndex)
            self.delegate?.didRemoveSnapShot(snapshot: snapshot, atIndex: snapshotIndex, arrayIdentifier: identifier)
            
        })
        
        let changed = firebaseQuery.observe(.childChanged, andPreviousSiblingKeyWith: { (snapshot, previousChildKey) in
            let snapshotIndex = self.index(forKey: snapshot.key)
            if snapshotIndex == NSNotFound {return}
            self.array[snapshotIndex] = snapshot
            self.delegate?.didChangeSnapShot(snapshot: snapshot, atIndex: snapshotIndex, arrayIdentifier: identifier)
        })
        
        handleArray = [added, removed, changed]
    }
    
    func count() -> Int {
        return array.count
    }
    
    private func index(forKey key: String) -> Int {
        for index in 0..<self.array.count {
            if (key == self.array[index].key) {
                return index
            }
        }
        return NSNotFound
    }
    
    deinit {
        for handle in handleArray {
            firebaseQuery.removeObserver(withHandle: handle)
        }
    }
    
}
protocol FirebaseArrayDelegate: class {
    func didAddSnapShot(snapshot: DataSnapshot, atIndex: Int, arrayIdentifier: String)
    func didRemoveSnapShot(snapshot: DataSnapshot, atIndex: Int, arrayIdentifier: String)
    func didChangeSnapShot(snapshot: DataSnapshot, atIndex: Int, arrayIdentifier: String)
}
