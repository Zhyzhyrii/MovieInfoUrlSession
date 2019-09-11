//
//  DetailMovie.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 9/1/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

struct DetailMovieJson: Decodable {
    let id: Int?
    let title: String?
    let releaseDate: String?
    let runTime: Int?
    let voteAverage: Double?
    let overview: String?
    let genres: [Genre]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case id
        case releaseDate = "release_date"
        case runTime = "runtime"
        case voteAverage = "vote_average"
        case overview
        case genres = "genres"
    }
    
     func getGenresAsString() -> String? {
        guard let genres = genres else { return nil }
        var genresAsString = ""
        for index in genres.indices {
            genresAsString += genres[index].genreName.capitalized
            if index != genres.count - 1 {
                genresAsString += ", "
            }
        }
        return genresAsString
    }
}
