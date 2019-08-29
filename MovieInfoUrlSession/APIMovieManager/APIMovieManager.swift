//
//  APIMovieManager.swift
//  MovieInfoApp
//
//  Created by Игорь on 8/24/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import Foundation

final class APIMovieManager {
    
    let apiKey = "10c9d0f7d2e89b09263bafaaf8c69a6a"
    
    static func fetchMovies(from movieType: MovieType, completionHandler: @escaping ([Movie]?, APIResult) -> Void) {
        
        URLSession.shared.dataTask(with: movieType.request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completionHandler(nil, .Failure)
                return
            }
            
            do {
                let movieList = try JSONDecoder().decode(MovieList.self, from: data)
                let movies = Movie.getMovies(from: movieList)
               
                guard movies != nil else {
                    completionHandler(nil, .Failure)
                    return
                }
                
                completionHandler(movies, .Success)
            } catch let error {
                completionHandler(nil, .Failure)
                print(error)
            }
            
        }.resume()
    }
}
