//
//  APIMovieManager.swift
//  MovieInfoApp
//
//  Created by Игорь on 8/24/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import Foundation

final class APIMovieManager: APIManager {
    
    var sessionConfiguration: URLSessionConfiguration
    var session: URLSession
    let apiKey: String
    
    init(sessionConfiguration: URLSessionConfiguration, apiKey: String) {
        self.sessionConfiguration = sessionConfiguration
        self.apiKey = apiKey
    }
    
    convenience init(apiKey: String) {
        self.init(sessionConfiguration: .default, apiKey: apiKey)
    }
    
    func fetchTopRatedMovies(completionHandler: @escaping (APIResult<Movie>)) {
        let request = MovieType.topRated(apiKey: self.apiKey)
        fetch(request: request, parse: <#T##([String : AnyObject]) -> T?#>, completionHandler: <#T##(APIResult<T>) -> Void#>)
    }
    
    
}
