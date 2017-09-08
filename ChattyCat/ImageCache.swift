//
//  ImageCache.swift
//  ChattyCat
//
//  Created by Perris Davis on 9/7/17.
//  Copyright © 2017 I.am.GoodBad. All rights reserved.
//

import UIKit

final class ImageCache: NSCache<NSString, UIImage> {
    static let shared = ImageCache()
}
