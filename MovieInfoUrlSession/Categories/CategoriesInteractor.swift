//
//  CategoriesInteractor.swift
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

protocol CategoriesBusinessLogic {
    func fetchMovies(request: CategoriesModels.FetchMovies.Request)
    func selectMovie(request: CategoriesModels.SelectMovie.Request)
}

protocol CategoriesDataStore {
    var selectedMovieId: Int! { get }
    var movies: [MovieType: [MovieJson]]! { get set }
}

class CategoriesInteractor: CategoriesBusinessLogic, CategoriesDataStore {
    
    var presenter: CategoriesPresentationLogic?
    var worker: CategoriesWorker?
    
    var movies: [MovieType : [MovieJson]]! = [:]
    var selectedMovieId: Int!
    
    // MARK: Fetch movies
    
    func fetchMovies(request: CategoriesModels.FetchMovies.Request) {
        worker = CategoriesWorker()
        
        for movieType in MovieType.allCases {
            worker?.fetchMovies(from: movieType, success: { [weak self] (movies) in
                self?.movies[movieType] = movies
                let response = CategoriesModels.FetchMovies.Response(movies: self?.movies, errorMessage: nil)
                self?.presenter?.presentMovies(response: response)
            }, failure: { [weak self] (error) in
                let response = CategoriesModels.FetchMovies.Response(movies: nil, errorMessage: error.localizedDescription)
                self?.presenter?.presentMovies(response: response)
            })
        }
    }
    
    func selectMovie(request: CategoriesModels.SelectMovie.Request) {
        selectedMovieId = request.movieId
    }
}
