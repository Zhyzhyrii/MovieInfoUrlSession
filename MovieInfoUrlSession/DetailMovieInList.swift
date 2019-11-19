//
//  MoviesList.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 11/4/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import RealmSwift

protocol DetailMovieInList {
    var movieTitle: String? { get }
    var posterPath: String? { get }
    var rate: String? { get }
    
    var movieId: Int? { get }
}
