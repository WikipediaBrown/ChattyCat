//
//  RequestManager.swift
//  ChattyCat
//
//  Created by Perris Davis on 9/7/17.
//  Copyright © 2017 I.am.GoodBad. All rights reserved.
//

import Foundation
//import Stripe
import Firebase

final class RequestManager {
    
    static let shared = RequestManager()
    
    enum RequestMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum HeaderValue: String {
        case applicationJSON = "application/json"
    }
    
    enum HeaderField: String {
        case accept = "Accept"
        case contentType = "Content-Type"
    }
    
    let defaultSession = URLSession(configuration: .default)
    
    func makeAuthenticatedRequest(urlString: String, requestMethod: RequestMethod = .get, body: JSONDictionary? = nil,  cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy, timeoutInterval: TimeInterval = TimeInterval.defaultInterval, completion: @escaping (_ data: Data?, _ HTTPStatusCode: URLResponse?, _ error: Error?) -> Void) {
        
        Auth.auth().currentUser?.getIDTokenForcingRefresh(true, completion: { (token, error) in
            
            guard
                let token = token,
                error == nil
            else {
                completion(nil, nil, error)
                return
            }
            
            self.makeRequest(urlString: urlString, requestMethod: requestMethod, body: body,  cachePolicy: cachePolicy, timeoutInterval: timeoutInterval, token: token, completion: { (data, response, error) in
                completion(data, response, error)
            })
            
        })
        
    }
    
    func makeRequest(urlString: String, requestMethod: RequestMethod = .get, body: JSONDictionary? = nil,  cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy, timeoutInterval: TimeInterval = TimeInterval.defaultInterval, token: String? = nil, completion: @escaping (_ data: Data?, _ HTTPStatusCode: URLResponse?, _ error: Error?) -> Void) {
        
        guard
            let url = URL(string: urlString)
        else {
            completion(nil, nil, ChattyCatErrors.errorCreatingURL)
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        request.httpMethod = requestMethod.rawValue
        request.addValue(HeaderValue.applicationJSON.rawValue, forHTTPHeaderField: HeaderField.contentType.rawValue)
        request.addValue(HeaderValue.applicationJSON.rawValue, forHTTPHeaderField: HeaderField.accept.rawValue)
        
        if let token = token {
            
            request.addValue(token, forHTTPHeaderField: "Authorization")
            
        }
        
        if let body = body, request.httpMethod == "POST" {
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            
        }
        
        defaultSession.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                completion(data, response, error)
            }
            
        }.resume()
        
    }

}
