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
}

protocol WatchLaterDataStore {
    var movies: Results<DetailMovie>! { get }
    var selectedMovieId: Int! { get }
}

class WatchLaterInteractor: WatchLaterBusinessLogic, WatchLaterDataStore {
    
    var presenter: WatchLaterPresentationLogic?
    var worker: WatchLaterDBWorker?
    
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
}
