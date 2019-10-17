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
    func setFavouriteStatus()
    func setWatchLaterStatus()
    func selectOverviewReviewSegment(request: DetailMovieModels.SelectOverviewReviewsSegmentedControl.Request)
}

protocol DetailMovieDataStore {
    var detailMovie: DetailMovie! { get }
    var videoCode: String! { get }
    var reviews: String! { get }
    var isAddedToFavourite: Bool { get }
    var isAddedToWatchLater: Bool { get }
}

class DetailMovieInteractor: DetailMovieBusinessLogic, DetailMovieDataStore {
    
    var presenter: DetailMoviePresentationLogic?
    var worker: DetailMovieWorker?
    
    var detailMovie: DetailMovie!
    var videoCode: String!
    var reviews: String!
    var isAddedToFavourite = false
    var isAddedToWatchLater = false
    
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
            self.reviews = reviewList?.getReviewAsString()
            
            self.isAddedToFavourite = self.worker?.isPresent(movie: self.detailMovie, in: .favoriteList) ?? false
            self.isAddedToWatchLater = self.worker?.isPresent(movie: self.detailMovie, in: .watchLaterList) ?? false
            
            let response = DetailMovieModels.ShowDetails.Response(detailMovie: self.detailMovie, videoCode: self.videoCode, reviews: self.reviews, isAddedToFavourite: self.isAddedToFavourite, isAddedToWatchLater: self.isAddedToWatchLater)
            self.presenter?.presentDetails(response: response)
        })
    }
    
    func setFavouriteStatus() {
        isAddedToFavourite.toggle()
        worker?.setStatus(for: detailMovie, in: .favoriteList, with: isAddedToFavourite)
        
        let response = DetailMovieModels.SetFavouriteStatus.Response(isAddedToFavourite: isAddedToFavourite)
        presenter?.presentFavouriteStatus(response: response)
    }
    
    func setWatchLaterStatus() {
        isAddedToWatchLater.toggle()
        worker?.setStatus(for: detailMovie, in: .watchLaterList, with: isAddedToWatchLater)
        
        let response = DetailMovieModels.SetWatchLaterStatus.Response(isAddedToWatchLater: isAddedToWatchLater)
        presenter?.presentWatchLaterStatus(response: response)
    }
    
    func selectOverviewReviewSegment(request: DetailMovieModels.SelectOverviewReviewsSegmentedControl.Request) {
        var overviewOrReviews = ""
        if request.selectedSegmentIndex == 0 {
            if let overview = detailMovie.overview {
                overviewOrReviews = overview
            }
        } else {
            overviewOrReviews = reviews
        }
        
        let response = DetailMovieModels.SelectOverviewReviewsSegmentedControl.Response(overviewReviews: overviewOrReviews)
        presenter?.presentOverviewReview(response: response)
    }
}
