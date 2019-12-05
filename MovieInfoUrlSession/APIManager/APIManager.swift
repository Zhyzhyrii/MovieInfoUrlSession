//
//  APIManager.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 11/5/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//
import Foundation

final class APIManager {
    
    static func fetchGenericJSONData<T: Decodable>(urlString: String, completionHandler: @escaping (T?, APIResult, Error?) -> Void) {
        
        guard let urlString = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else { return }
        guard let url = URL(string: urlString) else {
            return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(nil, .failure, error)
                return
            }
            
            let decoded = self.decodeJSON(type: T.self, from: data)
            
            guard decoded != nil else {
                completionHandler(nil, .failure, nil)
                return
            }
            
            completionHandler(decoded, .success, nil)
            
            }.resume()
    }
    
    private static func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch {
            return nil
        }
    }
    
}
