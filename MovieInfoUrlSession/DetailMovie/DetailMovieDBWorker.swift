//
//  DetailMovieDBWorker.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 11/14/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import RealmSwift

class DetailMovieDBWorker {
    
    func change(status: Status, for movie: DetailMovie) {
        
        guard let movieId = movie.id.value else { fatalError() }
        let movies = RealmMovieManager.getMovies().filter("id = %@", movieId)
        
        if let movie = movies.first {
            RealmManager.updateObject {
                changeValue(status: status, for: movie)
            }
        } else {
            changeValue(status: status, for: movie)
            RealmManager.addObject(object: movie)
        }
    }
    
    func has(movie: DetailMovie, status: Status) -> Bool {
        let movies = RealmMovieManager.getMovies(status: status)
        return movies.map({ (detailMovie) -> Int? in
            detailMovie.id.value
        }).contains(movie.id.value)
    }
    
    private func changeValue(status: Status, for movie: DetailMovie) {
        switch status {
        case .favourite:
            movie.isFavourite.toggle()
        case .watchLater:
            movie.isWatchedLater.toggle()
        }
    }
    
}
