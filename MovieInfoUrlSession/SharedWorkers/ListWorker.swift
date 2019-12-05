//
//  ListWorker.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 27.11.2019.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import RealmSwift

class ListWorker {
    
    func prepareDisplayedMovies(_ movies: Results<DetailMovie>) -> [DisplayedDetails] {
        var displayedMoviesDetails: [DisplayedDetails] = []
        movies.forEach { (detailMovie) in
            let movieTitle = "Название: \(detailMovie.title ?? "")"
            
            var displayedVoteAverage = "---"
            if let voteAverage = detailMovie.voteAverage.value {
                displayedVoteAverage = "\(voteAverage)"
            }
            let rate = "Рейтинг: \(displayedVoteAverage)"
            
            let displayedMovieDetails = DisplayedDetails(movieTitle: movieTitle, posterPath: detailMovie.posterPath, rate: rate, movieId: detailMovie.id.value)
            displayedMoviesDetails.append(displayedMovieDetails)
        }
        return displayedMoviesDetails
    }
    
}
