//
//  MovieType.swift
//  MovieInfoApp
//
//  Created by Игорь on 8/24/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import Foundation

enum MovieType {
    
    case topRated
    case popular
    case upComing
    case nowPlaying
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/movie"
    }
    
    var apiKey: String {
        return "?api_key=10c9d0f7d2e89b09263bafaaf8c69a6a"
    }
    
    var otherParameters: String {
        return "&language=ru&page=1"
    }
    
    var path: String {
        switch self {
        case .topRated:
            return "/top_rated"
        case .popular:
            return "/popular"
        case .upComing:
            return "/upcoming"
        case .nowPlaying:
            return "/now_playing"
        }
    }
    
    var request: URLRequest {
        guard let url = URL(string: baseURL + path + apiKey + otherParameters) else {
            fatalError("URL was not created")
        }
        return URLRequest(url: url)
    }
    
}
