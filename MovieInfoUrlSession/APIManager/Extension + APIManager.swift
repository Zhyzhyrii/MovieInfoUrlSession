//
//  Extension + APIManager.swift
//  MovieInfoApp
//
//  Created by Игорь on 8/24/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import Foundation

extension APIManager {
    func JSONTaskWith(request: URLRequest, completionHandler: @escaping JSONCompletionHandler) -> JSONTask {
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                
                let userInfo = [
                    NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")
                ]
                let error = NSError(domain: NetworkErrorDomain, code: 100, userInfo: userInfo)
                
                completionHandler(nil, nil, error)
                return
            }
            
            if data == nil {
                if let error = error {
                    completionHandler(nil, httpResponse, error)
                }
            } else {
                switch httpResponse.statusCode {
                case 200:
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                        completionHandler(json, httpResponse, nil)
                    } catch let error as NSError {
                        completionHandler(nil, httpResponse, error)
                    }
                default:
                    print("We have got response status \(httpResponse.statusCode)")
                }
            }
        }
        
        return dataTask
    }
    
    func fetch<T>(request: URLRequest, parse: @escaping ([String: AnyObject]) -> T?, completionHandler: @escaping (APIResult<T>) -> Void) {
        
        let dataTask = JSONTaskWith(request: request) { (json, response, error) in
            DispatchQueue.main.async {
                guard let jsonData = json else {
                    if let error = error {
                        completionHandler(.Failure(error))
                    }
                    return
                }
                if let value = parse(jsonData) {
                    completionHandler(.Success(value))
                } else {
                    let error = NSError(domain: NetworkErrorDomain, code: 200, userInfo: nil)
                    completionHandler(.Failure(error))
                }
            }
        }
        dataTask.resume()
    }
}
