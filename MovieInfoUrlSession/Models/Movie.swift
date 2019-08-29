//
//  Movie.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 8/29/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

struct Movie: Decodable {
    let posterPath: String?
    let id: Int?
    let backdropPath: String?
    let title: String?
    let voteAverage: Double?
    let overview: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
        case backdropPath = "backdrop_path"
        case title
        case voteAverage = "vote_average"
        case overview
    }
    
    static func getMovies(from movieList: MovieList) -> [Movie]? {
        guard let movies = movieList.results else { return nil }
        return movies
    }
}
