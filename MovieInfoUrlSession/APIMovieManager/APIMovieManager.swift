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
    
    //MARK: - TODO - Need to make one method with generic
    
    static func fetchMovies(from movieType: MovieType, completionHandler: @escaping ([MovieJson]?, APIResult, Error?) -> Void) {
        
        URLSession.shared.dataTask(with: movieType.request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completionHandler(nil, .failure, error)
                return
            }
            
            do {
                let movieList = try JSONDecoder().decode(MovieList.self, from: data)
                let movies = MovieJson.getMovies(from: movieList)
                
                guard movies != nil else {
                    completionHandler(nil, .failure, error)
                    return
                }
                
                completionHandler(movies, .success, nil)
            } catch let error {
                completionHandler(nil, .failure, nil)
                print(error)
            }
            
            }.resume()
    }
    
    static func fetchMovieTrailer(movieId: Int, completionHandler: @escaping ([Trailer]?, APIResult, Error?) -> Void) {
        
        guard let url = URL(string: BaseApiData.baseMovieURL + "/\(movieId)/videos" + BaseApiData.apiKey + "&language=ru") else { return }
        let urlrequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlrequest) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completionHandler(nil, .failure, error)
                return
            }
            
            do {
                let trailerList = try JSONDecoder().decode(TrailerList.self, from: data)
                let trailers = Trailer.getTrailers(from: trailerList)
                
                guard trailers != nil else {
                    completionHandler(nil, .failure, error)
                    return
                }
                
                completionHandler(trailers, .success, nil)
            } catch let error {
                completionHandler(nil, .failure, error)
                print(error)
            }
            }.resume()
    }
    
    static func fetchMovieReviews(movieId: Int, completionHandler: @escaping (ReviewList?, APIResult, Error?) -> Void) {
        
        guard let url = URL(string: BaseApiData.baseMovieURL + "/\(movieId)/reviews" + BaseApiData.apiKey + "&language=en-US") else { return }
        let urlrequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlrequest) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completionHandler(nil, .failure, error)
                return
            }
            
            do {
                let reviewList = try JSONDecoder().decode(ReviewList.self, from: data)
                completionHandler(reviewList, .success, nil)
            } catch let error {
                completionHandler(nil, .failure, error)
                print(error)
            }
            }.resume()
    }
    
    static func fetchDetailMovie(movieId: Int, completionHandler: @escaping (DetailMovie?, APIResult, Error?) -> Void) {
        
        guard let url = URL(string: BaseApiData.baseMovieURL + "/\(movieId)" + BaseApiData.apiKey + "&language=ru") else { return }
        let urlrequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlrequest) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completionHandler(nil, .failure, error)
                return
            }
            do {
                let detailMovie = try JSONDecoder().decode(DetailMovie.self, from: data)
                completionHandler(detailMovie, .success, nil)
            } catch let error {
                completionHandler(nil, .failure, nil)
                print(error)
            }
            }.resume()
    }
    
    static func fetchGenres(completionHandler: @escaping (GenreJson?, APIResult) -> Void) {
        
        guard let url = URL(string: BaseApiData.baseURL + "/genre/movie/list" + BaseApiData.apiKey + "&language=ru") else { return }
        let urlrequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlrequest) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completionHandler(nil, .failure)
                return
            }
            do {
                let genresJson = try JSONDecoder().decode(GenreJson.self, from: data)
                completionHandler(genresJson, .success)
            } catch let error {
                completionHandler(nil, .failure)
                print(error)
            }
            }.resume()
    }
}
