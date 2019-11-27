//
//  WatchLaterInteractor.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 11/18/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import RealmSwift

protocol WatchLaterBusinessLogic {
    func getMovies(request: WatchLaterModels.GetMovies.Request)
    func selectMovie(request: WatchLaterModels.SelectMovie.Request)
    func removeMovie(request: WatchLaterModels.RemoveMovie.Request)
}

protocol WatchLaterDataStore {
    var movies: Results<DetailMovie>! { get }
    var selectedMovieId: Int! { get }
}

class WatchLaterInteractor: WatchLaterBusinessLogic, WatchLaterDataStore {
    
    var presenter: WatchLaterPresentationLogic?
    var worker: WatchLaterDBWorker?
    var dataBaseWorker: DetailMovieDBWorker?
    
    var movies: Results<DetailMovie>!
    var selectedMovieId: Int!
    
    // MARK: Get movies
    
    func getMovies(request: WatchLaterModels.GetMovies.Request) {
        worker = WatchLaterDBWorker()
        
        movies = worker?.getWatchedLaterMovies()
        
        let response = WatchLaterModels.GetMovies.Response(movies: movies)
        presenter?.presentMovies(response: response)
    }
    
    // MARK: Select movies
    
    func selectMovie(request: WatchLaterModels.SelectMovie.Request) {
        selectedMovieId = request.movieId
    }
    
    //MARK: - Remove movie from list
    
    func removeMovie(request: WatchLaterModels.RemoveMovie.Request) {
        dataBaseWorker = DetailMovieDBWorker()
        if let movieId = request.removedMovie.movieId {
            dataBaseWorker?.change(status: .watchLater, for: movieId)
            
            let response = WatchLaterModels.GetMovies.Response(movies: movies)
            presenter?.presentMovies(response: response)
        }
    }
}
