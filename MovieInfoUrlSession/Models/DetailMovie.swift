//
//  DetailMovie.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 9/1/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

struct DetailMovie: Decodable {
    
    //fields from json
    let id: Int?
    let title: String?
    let releaseDate: String?
    let runTime: Int?
    let voteAverage: Double?
    let overview: String?
    let posterPath: String?
    let genres: [Genre]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case id
        case releaseDate = "release_date"
        case runTime = "runtime"
        case voteAverage = "vote_average"
        case overview
        case genres = "genres"
        case posterPath = "poster_path"
    }
    
     func getGenresAsString() -> String? {
        guard let genres = genres else { return nil }
        var genresAsString = ""
        for index in genres.indices {
            guard let genreName = genres[index].genreName else { return nil }
            genresAsString += genreName.capitalized
            if index != genres.count - 1 {
                genresAsString += ", "
            }
        }
        return genresAsString
    }
}

extension DetailMovie: Equatable {
    
    static func == (lhs: DetailMovie, rhs: DetailMovie) -> Bool {
        return lhs.id == rhs.id
    }
    
}
