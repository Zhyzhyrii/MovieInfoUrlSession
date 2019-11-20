//
//  FavouritePresenter.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 11/4/19.
//  Copyright (c) 2019 Igor Zhyzhyrii. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol FavouritePresentationLogic {
    func presentMovies(response: FavouriteModels.GetMovies.Response)
}

class FavouritePresenter: FavouritePresentationLogic {
    
    weak var viewController: FavouriteDisplayLogic?
    
    // MARK: Present movies
    
    func presentMovies(response: FavouriteModels.GetMovies.Response) {
        let movies = response.movies
        var displayedMoviesDetails: [FavouriteModels.GetMovies.ViewModel.DisplayedDetails] = []
        movies.forEach { (detailMovie) in
            let movieTitle = "Название: \(detailMovie.title ?? "")"
            
            var displayedVoteAverage = "---"
            if let voteAverage = detailMovie.voteAverage.value {
                displayedVoteAverage = "\(voteAverage)"
            }
            let rate = "Рейтинг: \(displayedVoteAverage)"
            
            let displayedMovieDetails = FavouriteModels.GetMovies.ViewModel.DisplayedDetails(movieTitle: movieTitle, posterPath: detailMovie.posterPath, rate: rate, movieId: detailMovie.id.value)
            displayedMoviesDetails.append(displayedMovieDetails)
        }
        
        let viewModel = FavouriteModels.GetMovies.ViewModel(displayedDetails: displayedMoviesDetails)
        viewController?.displayMovies(viewModel: viewModel)
    }
}