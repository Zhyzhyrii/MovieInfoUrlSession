//
//  DetailMovieInteractor.swift
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

protocol DetailMovieBusinessLogic {
    func showDetails(request: DetailMovieModels.ShowDetails.Request)
}

protocol DetailMovieDataStore {
    var detailMovie: DetailMovie! { get }
    var videoCode: String! { get }
    var reviewList: ReviewList! { get }
}

class DetailMovieInteractor: DetailMovieBusinessLogic, DetailMovieDataStore {
    
    var presenter: DetailMoviePresentationLogic?
    var worker: DetailMovieWorker?
    
    var detailMovie: DetailMovie!
    var videoCode: String!
    var reviewList: ReviewList!
    
    // MARK: Do something
    
    func showDetails(request: DetailMovieModels.ShowDetails.Request) {

        worker = DetailMovieWorker()
        
        worker?.getMovieDetailInfo(forMovieId: request.detailMovieId, completionHandler: { (detailMovie) in
            self.detailMovie = detailMovie
        })
        
        worker?.getTrailer(forMovieId: request.detailMovieId, completionHandler: { (videoCode) in
            self.videoCode = videoCode
        })
        
        worker?.getReviews(forMovieId: request.detailMovieId, completionHandler: { (reviewList) in
            self.reviewList = reviewList
            
            let response = DetailMovieModels.ShowDetails.Response(detailMovie: self.detailMovie, videoCode: self.videoCode, reviewList: self.reviewList)
            self.presenter?.presentDetails(response: response)
        })
    }
}
