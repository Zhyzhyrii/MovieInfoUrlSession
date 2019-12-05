//
//  SearchPresenter.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 28.11.2019.
//  Copyright (c) 2019 Igor Zhyzhyrii. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SearchPresentationLogic {
    func presentMovies(response: SearchModels.Search.Response)
}

class SearchPresenter: SearchPresentationLogic {
    
    weak var viewController: SearchDisplayLogic?
    
    // MARK: Present movies
    
    func presentMovies(response: SearchModels.Search.Response) {
        if let errorMessage = response.errorMessage {
            let viewModel = SearchModels.Search.ViewModel(displayedDetails: nil, errorMessage: errorMessage)
            viewController?.displaySearchError(viewModel: viewModel)
        } else {
            guard let movies = response.movies else {
                let viewModel = SearchModels.Search.ViewModel(displayedDetails: nil, errorMessage: nil)
                viewController?.displaySearchError(viewModel: viewModel)
                return
            }
            let displayedMoviesDetails = prepareDisplayedMovies(movies)
            let viewModel = SearchModels.Search.ViewModel(displayedDetails: displayedMoviesDetails, errorMessage: nil)
            viewController?.displaySearchSuccess(viewModel: viewModel)
        }
    }
    
    private func prepareDisplayedMovies(_ movies: [MovieJson]) -> [DisplayedDetails] { // need to come up with the better idea to use the same method from ListWorker
        var displayedMoviesDetails: [DisplayedDetails] = []
        movies.forEach { (detailMovie) in
            let movieTitle = "Название: \(detailMovie.title ?? "")"
            
            var displayedVoteAverage = "---"
            if let voteAverage = detailMovie.voteAverage {
                displayedVoteAverage = "\(voteAverage)"
            }
            let rate = "Рейтинг: \(displayedVoteAverage)"
            
            let displayedMovieDetails = DisplayedDetails(movieTitle: movieTitle, posterPath: detailMovie.posterPath, rate: rate, movieId: detailMovie.id)
            displayedMoviesDetails.append(displayedMovieDetails)
        }
        return displayedMoviesDetails
    }
}