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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.sectionHeadersPinToVisibleBounds = true
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 88)
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: .navigationBarHeight)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ChatDashboardCollectionViewCell.self, forCellWithReuseIdentifier: .chatDashboardCell)
        collectionView.register(ChatDashboardCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: .catChatsSectionHeader)
        collectionView.delegate = UserChatDataSource.shared
        collectionView.dataSource = UserChatDataSource.shared
        return collectionView
    }()
    
    static let shared = ChatDashboardViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        UserChatDataSource.shared.collectionView = chatListCollectionView
        UserChatDataSource.shared.configure()
        setupViews()
    }
    
    func setupViews() {
        
        self.view.addSubview(chatListCollectionView)
        
        let viewsDictionary = ["v0": chatListCollectionView]
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
