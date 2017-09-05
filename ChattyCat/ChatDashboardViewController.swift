//
//  ChatDashboardViewController.swift
//  ChattyCat
//
//  Created by Perris Davis on 9/4/17.
//  Copyright © 2017 I.am.GoodBad. All rights reserved.
//

import UIKit

final class ChatDashboardViewController: UIViewController {
    
    let chatListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    static let shared = ChatDashboardViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }

}
