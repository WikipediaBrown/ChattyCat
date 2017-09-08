//
//  NetworkedImageView.swift
//  ChattyCat
//
//  Created by Perris Davis on 9/7/17.
//  Copyright © 2017 I.am.GoodBad. All rights reserved.
//

import UIKit

class NetworkedImageView: UIImageView {
    
    var imageURLString: String?
    
    func loadImageUsingURLString(urlString: String) {
        
        imageURLString = urlString
        
        image = nil
        
        if let imageFromCache = ImageCache.shared.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
                
        RequestManager.shared.makeRequest(urlString: urlString) { (data, response, error) in
            guard
                let data = data,
                let imageToCache = UIImage(data: data)
            else {
                print(error?.localizedDescription ?? "NetworkedImageView didn't return data & response or error")
            return }
            
            if self.imageURLString == urlString {
                self.image = imageToCache
            }
            
            ImageCache.shared.setObject(imageToCache, forKey: NSString(string: urlString))
        }
    }
    
}
