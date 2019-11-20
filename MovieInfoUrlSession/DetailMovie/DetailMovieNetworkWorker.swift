//
//  DetailMovieNetworkWorker.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 10/13/19.
//  Copyright (c) 2019 Igor Zhyzhyrii. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

typealias getReviewResponseSuccess = (ReviewList?) -> Void
typealias getReviewResponseFailure = (Error?) -> Void

typealias getTrailerSuccess = (String?) -> Void
typealias getTrailerFailure = (Error?) -> Void

typealias getMovieDetailInfoSuccess = (DetailMovie?) -> Void
typealias getMovieDetailInfoError = (Error?) -> Void

class DetailMovieNetworkWorker {
    
    func getMovieDetailInfo(forMovieId movieId: Int, success: @escaping getMovieDetailInfoSuccess, failure: @escaping getTrailerFailure) {
        APIMovieManager.fetchDetailMovie(movieId: movieId) { (detailMovie, result, error) in
            switch result {
            case .success:
                guard let detailMovie = detailMovie else { return }
                success(detailMovie)
            case .failure:
                failure(error)
            }
        }
    }
    
    func getTrailer(forMovieId movieId: Int, success: @escaping getTrailerSuccess, failure: @escaping getTrailerFailure) {
        APIMovieManager.fetchMovieTrailer(movieId: movieId) { (trailers, result, error) in
            switch result {
            case .success:
                guard let trailers = trailers, trailers.count > 0 else {
                    failure(error)
                    return }
                guard let videoCode = trailers[0].key else { return }
                success(videoCode)
            case .failure:
                failure(error)
            }
        }
    }
    
    func getReviews(forMovieId movieId: Int, success: @escaping getReviewResponseSuccess, failure: @escaping getReviewResponseFailure) {
        APIMovieManager.fetchMovieReviews(movieId: movieId) { (reviewlist, result, error) in
            switch result {
            case .success:
                guard let reviewList = reviewlist else { return }
                success(reviewList)
            case .failure:
                failure(error)
            }
        }
    }
}