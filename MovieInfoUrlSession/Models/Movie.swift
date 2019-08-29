//
//  Movie.swift
//  MovieInfoApp
//
//  Created by Игорь on 8/23/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

struct Movie {
    let id: Int?
    let title: String?
    let voteAverage: Double?
    let posterPath: String?
    let backDropPath: String?
    let overview: String?
    
    init(dictMovie: [String: Any]) {
        id = dictMovie["id"] as? Int
        title = dictMovie["title"] as? String
        voteAverage = dictMovie["vote_average"] as? Double
        posterPath = dictMovie["poster_path"] as? String
        backDropPath = dictMovie["backdrop_path"] as? String
        overview = dictMovie["overview"] as? String
    }
    
    static func getMovies(from jsonData: Any) -> [Movie] {
        guard let jsonData = jsonData as? [String: Any] else { return [] }
        guard let jsonResults = jsonData["results"] as? Array<[String: Any]> else { return [] }
        
        return jsonResults.compactMap{ Movie(dictMovie: $0)}
    }
}
