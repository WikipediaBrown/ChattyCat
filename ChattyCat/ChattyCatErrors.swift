//
//  ChattyCatErrors.swift
//  ChattyCat
//
//  Created by Perris Davis on 9/7/17.
//  Copyright © 2017 I.am.GoodBad. All rights reserved.
//

import UIKit

enum ChattyCatErrors: Error {
    case noUser
    case errorCreatingURL
}

extension ChattyCatErrors: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .noUser:
            return NSLocalizedString("The user doesn't have a User ID yet.", comment: "")
        case .errorCreatingURL:
            return NSLocalizedString("There was a prblem creating the URL.", comment: "")
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .noUser:
            return NSLocalizedString("For some unknown reason, the user doesn't currently have a user ID.", comment: "")
        case .errorCreatingURL:
            return NSLocalizedString("For some unknown reason, firebase wont give us a token.", comment: "")
        }
    }
}
