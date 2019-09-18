//
//  APIMovieManager.swift
//  MovieInfoApp
//
//  Created by Игорь on 8/24/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import Foundation

final class APIMovieManager {
    
    let apiKey = "10c9d0f7d2e89b09263bafaaf8c69a6a"
    
    static func fetchMovies(from movieType: MovieType, completionHandler: @escaping ([MovieJson]?, APIResult) -> Void) {
        
        URLSession.shared.dataTask(with: movieType.request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completionHandler(nil, .Failure)
                return
            }
            
            do {
                let movieList = try JSONDecoder().decode(MovieList.self, from: data)
                let movies = MovieJson.getMovies(from: movieList)
                
                guard movies != nil else {
                    completionHandler(nil, .Failure)
                    return
                }
                
                completionHandler(movies, .Success)
            } catch let error {
                completionHandler(nil, .Failure)
                print(error)
            }
            
            }.resume()
    }
    
    static func fetchMovieTrailer(movieId: Int, completionHandler: @escaping ([Trailer]?, APIResult) -> Void) {
        
        guard let url = URL(string: BaseApiData.baseURL + "/\(movieId)/videos" + BaseApiData.apiKey + "&language=ru") else { return }
        let urlrequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlrequest) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completionHandler(nil, .Failure)
                return
            }
            
            do {
                let trailerList = try JSONDecoder().decode(TrailerList.self, from: data)
                let trailers = Trailer.getTrailers(from: trailerList)
                
                guard trailers != nil else {
                    completionHandler(nil, .Failure)
                    return
                }
                
                completionHandler(trailers, .Success)
            } catch let error {
                completionHandler(nil, .Failure)
                print(error)
            }
            }.resume()
    }
    
    static func fetchMovieReviews(movieId: Int, completionHandler: @escaping (ReviewList?, APIResult) -> Void) {
        
        guard let url = URL(string: BaseApiData.baseURL + "/\(movieId)/reviews" + BaseApiData.apiKey + "&language=en-US") else { return }
        let urlrequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlrequest) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completionHandler(nil, .Failure)
                return
            }
            
            do {
                let reviewList = try JSONDecoder().decode(ReviewList.self, from: data)
                completionHandler(reviewList, .Success)
            } catch let error {
                completionHandler(nil, .Failure)
                print(error)
            }
            }.resume()
    }
    
    static func fetchDetailMovie(movieId: Int, completionHandler: @escaping (DetailMovie?, APIResult) -> Void) {
        
        guard let url = URL(string: BaseApiData.baseURL + "/\(movieId)" + BaseApiData.apiKey + "&language=ru") else { return }
        let urlrequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlrequest) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completionHandler(nil, .Failure)
                return
            }
            do {
                let detailMovie = try JSONDecoder().decode(DetailMovie.self, from: data)
                completionHandler(detailMovie, .Success)
            } catch let error {
                completionHandler(nil, .Failure)
                print(error)
            }
            }.resume()
    }
}
