//
//  CategoriesPresenter.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 10/21/19.
//  Copyright (c) 2019 Igor Zhyzhyrii. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CategoriesPresentationLogic {
    func presentMovies(response: CategoriesModels.FetchMovies.Response)
}

class CategoriesPresenter: CategoriesPresentationLogic {
    
    weak var viewController: CategoriesDisplayLogic?
    
    // MARK: Present movies
    
    func presentMovies(response: CategoriesModels.FetchMovies.Response) {
       
        if let errorMessage = response.errorMessage {
            let viewModel = CategoriesModels.FetchMovies.ViewModel(displayedDetails: nil, errorMessage: errorMessage)
            viewController?.displayMoviesError(viewModel: viewModel)
        } else if let allMovies = response.movies {
            var displayedMoviesTypesDetails: [MovieType: [CategoriesModels.FetchMovies.ViewModel.DisplayedDetails]] = [:]
            allMovies.forEach { (moviesOfType) in
                var displayedMoviesDetails: [CategoriesModels.FetchMovies.ViewModel.DisplayedDetails] = []
                moviesOfType.value.forEach({ (movie) in
                    let displayedMovieDetails = CategoriesModels.FetchMovies.ViewModel.DisplayedDetails(movieTitle: movie.title, posterPath: movie.posterPath)
                    displayedMoviesDetails.append(displayedMovieDetails)
                })
                displayedMoviesTypesDetails[moviesOfType.key] = displayedMoviesDetails
            }
            let viewModel = CategoriesModels.FetchMovies.ViewModel(displayedDetails: displayedMoviesTypesDetails, errorMessage: nil)
            viewController?.displayMovies(viewModel: viewModel)
        }
        
    }
}
