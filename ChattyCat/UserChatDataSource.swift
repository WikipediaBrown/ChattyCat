//
//  UserChatDataSource.swift
//  ChattyCat
//
//  Created by Perris Davis on 9/4/17.
//  Copyright © 2017 I.am.GoodBad. All rights reserved.
//

import UIKit
import Firebase

final class UserChatDataSource: NSObject {
    
    static let shared = UserChatDataSource()
    
    var openChats: FirebaseArray?
    
    var collectionView: UICollectionView?
    
    // This configures the Firebase Array (a special array I made for reading lists in Firebase)
    func configure() {
        
        guard
            let uid = Auth.auth().currentUser?.uid
        else {
            return
        }
        
        let chatsReference = FirebaseHelper.shared.catChats,
        query = chatsReference.queryOrdered(byChild: "users/\(uid)").queryEqual(toValue: true)
        self.openChats = FirebaseArray(query: query, identifier: "catChats", delegate: self)
    }

}

/*This extension contains all of the delegate methods collection views associated with the catalog.*/
extension UserChatDataSource: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // Number of Items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let fireProducts = openChats else {return 0}
        return fireProducts.count()
    }
    
    // WillDisplay for Header & Footer
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
        switch elementKind {
        case UICollectionElementKindSectionHeader:
            let view = view as? ChatDashboardCollectionReusableView
            view?.backgroundColor = .blue
            // setup header here
            
        default:
            return
        }
    }
    
    // WillDisplay for Cell
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard
            let cell = cell as? ChatDashboardCollectionViewCell,
            let openChats = openChats
        else {return}
        
        let chatData = openChats.array[indexPath.row]

        // setup cells here
    }
    
    // Create Header and Footer view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: .catChatsSectionHeader, for: indexPath)
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    // Create Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .chatDashboardCell, for: indexPath) as? ChatDashboardCollectionViewCell else {return ChatDashboardCollectionViewCell()}
        return cell
    }
    
    // didSelect for Cells
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        MenuViewController.shared.itemDetailViewController.catalogSection = "Fire"
//        MenuViewController.shared.itemDetailViewController.itemPosition = indexPath.row
//        MenuViewController.shared.swapSection(viewController: MenuViewController.shared.itemDetailViewController)
    }
    
}

/*This extension contains all of the delegate methods for the Fire section's FirebaseArray*/
extension UserChatDataSource: FirebaseArrayDelegate {
    
    func didAddSnapShot(snapshot: DataSnapshot, atIndex: Int, arrayIdentifier: String) {
        guard   let collectionView = collectionView
            else {return}
        collectionView.insertItems(at: [IndexPath(item: atIndex, section: 0)])
    }
    
    func didRemoveSnapShot(snapshot: DataSnapshot, atIndex: Int, arrayIdentifier: String) {
        guard   let collectionView = collectionView
            else {return}
        collectionView.deleteItems(at: [IndexPath(item: atIndex, section: 0)])
    }
    
    func didChangeSnapShot(snapshot: DataSnapshot, atIndex: Int, arrayIdentifier: String) {
        guard   let collectionView = collectionView
            else {return}
        
        collectionView.reloadItems(at: [IndexPath(item: atIndex, section: 0)])
    }
    
}
