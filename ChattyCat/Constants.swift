//
//  Constants.swift
//  ChattyCat
//
//  Created by Perris Davis on 9/4/17.
//  Copyright © 2017 I.am.GoodBad. All rights reserved.
//

import UIKit

// String Constants
extension String {
    
    static let theEmailAddressIsBadlyFormatted = "The email address is badly formatted."
    static let thePasswordMustBeSixCharactersLongOrMore = "The password must be 6 characters long or more."
    static let theEmailAddressIsAlreadyInUseByAnotherAccount = "The email address is already in use by another account."
    static let thePasswordIsInvalidOrTheUserDoesNotHaveAPassword = "The password is invalid or the user does not have a password."
    static let thereIsNoUserRecordCorrespondingToThisIdentifierTheUserMayHaveBeenDeleted = "There is no user record corresponding to this identifier. The user may have been deleted."
    
    static let chatDashboardCell = "chatDashboardCell"
    static let catChatsSectionHeader = "catChatsSectionHeader"
    
}

// Interval Constants
extension TimeInterval {
    static let defaultInterval: TimeInterval = {
        return TimeInterval(exactly: 45000) ?? TimeInterval()
    }()
}

// Integer Constants
extension Integer {

}

// Core Graphics Float Constants
extension CGFloat {
    static let navigationBarHeight: CGFloat = 64.0
}

// UIColor constants
extension UIColor {
    
    static let backgroundColor: UIColor = {
        return UIColor(red: 255/255, green: 225/255, blue: 255/255, alpha: 1)
    }()
    
}
