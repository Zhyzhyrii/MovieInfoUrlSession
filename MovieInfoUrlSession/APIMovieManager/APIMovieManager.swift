//
//  APIMovieManager.swift
//  MovieInfoApp
//
//  Created by Игорь on 8/24/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import Foundation

final class APIMovieManager {
    
    static func fetchMovies(from movieType: MovieType, completionHandler: @escaping ([MovieJson]?, APIResult, Error?) -> Void) {
        
        let url = movieType.requestString
        APIManager.fetchGenericJSONData(urlString: url) { (movieList: MovieList?, result, error) in
            
            guard let movieList = movieList else {
                completionHandler(nil, .failure, error)
                return
            }
            
            guard let movies = MovieJson.getMovies(from: movieList) else {
                completionHandler(nil, .failure, nil)
                return
            }
            
            completionHandler(movies, .success, nil)
            
        }

    }
    
    static func fetchMovieTrailer(movieId: Int, completionHandler: @escaping ([Trailer]?, APIResult, Error?) -> Void) {
        
        let url = BaseApiData.baseMovieURL + "/\(movieId)/videos" + BaseApiData.apiKey + "&language=ru"
        APIManager.fetchGenericJSONData(urlString: url) { (trailerList: TrailerList?, result, error) in
            
            guard let trailerList = trailerList else {
                completionHandler(nil, .failure, error)
                return
            }
            
            guard let trailers = Trailer.getTrailers(from: trailerList) else {
                completionHandler(nil, .failure, nil)
                return
            }
            
            completionHandler(trailers, .success, nil)
        }
    }
    
    static func fetchMovieReviews(movieId: Int, completionHandler: @escaping (ReviewList?, APIResult, Error?) -> Void) {
        
        let url = BaseApiData.baseMovieURL + "/\(movieId)/reviews" + BaseApiData.apiKey + "&language=en-US"
        APIManager.fetchGenericJSONData(urlString: url) { (reviewList: ReviewList?, result, error) in
            completionHandler(reviewList, result, error)
        }

    }
    
    static func fetchDetailMovie(movieId: Int, completionHandler: @escaping (DetailMovie?, APIResult, Error?) -> Void) {
        
        let url = BaseApiData.baseMovieURL + "/\(movieId)" + BaseApiData.apiKey + "&language=ru"
        APIManager.fetchGenericJSONData(urlString: url) { (detailMovie: DetailMovie?, result, error) in
            completionHandler(detailMovie, result, error)
        }
    }
    
    static func fetchGenres(completionHandler: @escaping (GenreJson?, APIResult) -> Void) {
        
        let url = BaseApiData.baseURL + "/genre/movie/list" + BaseApiData.apiKey + "&language=ru"
        APIManager.fetchGenericJSONData(urlString: url) { (genre: GenreJson?, result, _) in
            completionHandler(genre, result)
        }
        
    }
}
