//
//  Movie.swift
//  MovieInfoApp
//
//  Created by Игорь on 8/23/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

struct MovieList: Decodable {
    let page, totalResults, totalPages: Int?
    let results: [MovieJson]?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
