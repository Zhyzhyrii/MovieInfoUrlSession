//
//  DetailMovieWorker.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 10/13/19.
//  Copyright (c) 2019 Igor Zhyzhyrii. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

typealias getReviewResponseSuccess = (ReviewList?) -> Void
typealias getReviewResponseFailure = (Error?) -> Void

typealias getTrailerSuccess = (String?) -> Void
typealias getTrailerFailure = (Error?) -> Void

class DetailMovieWorker { //todo split into two workers? (network and work with lists)
    
    func getMovieDetailInfo(forMovieId movieId: Int, completionHandler: @escaping (DetailMovie?) -> Void) {
        APIMovieManager.fetchDetailMovie(movieId: movieId) { (detailMovie, result) in
            switch result {
            case .Success:
                guard let detailMovie = detailMovie else { return }
                completionHandler(detailMovie)
                //                DispatchQueue.main.async {
                //                    self.configureUI()
            //                }
            case .Failure:
                print("Error")
                completionHandler(nil)
                //                let alert = UIHelpers.showAlert(withTitle: "Ошибка",
                //                                                message: "Данные не были получены из сети",
                //                                                buttonTitle: "Вернуться назад",
                //                                                handler: { action in
                //                                                    self.navigationController?.popViewController(animated: true)
                //                })
                
                //                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
    
    func getTrailer(forMovieId movieId: Int, success: @escaping getTrailerSuccess, failure: @escaping getTrailerFailure) {
        APIMovieManager.fetchMovieTrailer(movieId: movieId) { (trailers, result, error) in
            switch result {
            case .Success:
                guard let trailers = trailers, trailers.count > 0 else {
                    failure(error)
                    return }
                guard let videoCode = trailers[0].key else { return }
                success(videoCode)
            case .Failure:
                failure(error)
            }
        }
    }
    
    func getReviews(forMovieId movieId: Int, success: @escaping getReviewResponseSuccess, failure: @escaping getReviewResponseFailure) {
        APIMovieManager.fetchMovieReviews(movieId: movieId) { (reviewlist, result, error) in
            switch result {
            case .Success:
                guard let reviewList = reviewlist else { return }
                success(reviewList)
            case .Failure:
                failure(error)
            }
        }
    }
    
    func isPresent(movie: DetailMovie, in listType: ListType) -> Bool {
        return ListManager.listManager.isPresent(movie: movie, in: listType)
    }
    
    func setStatus(for movie: DetailMovie, in list: ListType, with status: Bool) {
        if !status {
            ListManager.listManager.remove(movie: movie, from: list)
        } else {
            ListManager.listManager.add(movie: movie, to: list)
        }
    }
    
}
