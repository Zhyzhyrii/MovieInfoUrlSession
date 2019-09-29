//
//  MovieType.swift
//  MovieInfoApp
//
//  Created by Игорь on 8/24/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import Foundation

enum MovieType: String, CaseIterable {
    
    case topRated = "Топ-фильмы"
    case popular = "Популярные фильмы"
    case nowPlaying = "Сейчас в прокате"
    case upComing = "Скоро в прокате"
    
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
        guard let url = URL(string: BaseApiData.baseURL + path + BaseApiData.apiKey + otherParameters) else {
            fatalError("URL was not created")
        }
        return URLRequest(url: url)
    }
}
