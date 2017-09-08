//
//  FirebaseHelper.swift
//  ChattyCat
//
//  Created by Perris Davis on 9/4/17.
//  Copyright © 2017 I.am.GoodBad. All rights reserved.
//

import Foundation
import Firebase

final class FirebaseHelper {
    
    static let shared = FirebaseHelper()
    
    let catChats = Database.database().reference().child("catChats")

}
