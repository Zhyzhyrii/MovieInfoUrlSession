//
//  Movie.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 8/29/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

struct MovieJson: Decodable {
    let posterPath: String?
    let id: Int?
    let backdropPath: String?
    let title: String?
    let voteAverage: Double?
    let overview: String?
    let releaseDate: String?
    let genresIds: [Int]?
    
    //custom fields
    var genreName = ""
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
        case backdropPath = "backdrop_path"
        case title
        case voteAverage = "vote_average"
        case overview
        case genresIds = "genre_ids"
        case releaseDate = "release_date"
    }
    
    static func getMovies(from movieList: MovieList) -> [MovieJson]? {
        guard let movies = movieList.results else { return nil }
        return movies
    }
}
