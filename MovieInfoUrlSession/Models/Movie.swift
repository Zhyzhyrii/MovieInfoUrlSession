//
//  Movie.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 9/2/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

struct Movie: Encodable, Decodable {
    let id: Int?
    let title: String?
    let voteAverage: Double?
    let overview: String?
    var isAddedToFavorite = false
    var isAddedToWatchLater = false
    
    init(from detailMovieJson: DetailMovieJson) {
        id = detailMovieJson.id
        title = detailMovieJson.title
        voteAverage = detailMovieJson.voteAverage
        overview = detailMovieJson.overview
    }
    
    
}
