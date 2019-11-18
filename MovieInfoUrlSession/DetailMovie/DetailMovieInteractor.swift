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
    func showTrailer(request: DetailMovieModels.ShowTrailer.Request)
    func setFavouriteStatus()
    func setWatchLaterStatus()
    func selectOverviewReviewSegment(request: DetailMovieModels.SelectOverviewReviewsSegmentedControl.Request)
}

protocol DetailMovieDataStore {
    var movieId: Int! { get set }
    var detailMovie: DetailMovie! { get }
    var videoCode: String! { get }
    var reviews: String! { get }
    var isAddedToFavourite: Bool { get }
    var isAddedToWatchLater: Bool { get }
}

class DetailMovieInteractor: DetailMovieBusinessLogic, DetailMovieDataStore {
    
    var presenter: DetailMoviePresentationLogic?
    var networkWorker: DetailMovieNetworkWorker?
    var dataBaseWorker: DetailMovieDBWorker?
    
    var movieId: Int!
    var detailMovie: DetailMovie!
    var videoCode: String!
    var reviews: String!
    var isAddedToFavourite = false
    var isAddedToWatchLater = false
    
    // MARK: Do something
    
    func showDetails(request: DetailMovieModels.ShowDetails.Request) {
        networkWorker = DetailMovieNetworkWorker()
        dataBaseWorker = DetailMovieDBWorker()
        
        networkWorker?.getMovieDetailInfo(forMovieId: movieId,
                                   success: { [weak self] (detailMovie) in
                                    
            guard let self = self else { return }
            self.detailMovie = detailMovie
            
            self.isAddedToFavourite = self.dataBaseWorker?.has(movie: self.detailMovie, status: .favourite) ?? false
            self.isAddedToWatchLater = self.dataBaseWorker?.has(movie: self.detailMovie, status: .watchLater) ?? false
            
            let response = DetailMovieModels.ShowDetails.Response(detailMovie: self.detailMovie, isAddedToFavourite: self.isAddedToFavourite, isAddedToWatchLater: self.isAddedToWatchLater, errorMessage: nil)
            self.presenter?.presentDetails(response: response)
        }, failure: { [weak self] (error) in
            let response = DetailMovieModels.ShowDetails.Response(detailMovie: nil, isAddedToFavourite: false, isAddedToWatchLater: false, errorMessage: error?.localizedDescription)
            self?.presenter?.presentDetails(response: response)
        })
        
    }
    
    func showTrailer(request: DetailMovieModels.ShowTrailer.Request) {
        networkWorker?.getTrailer(forMovieId: movieId,
                           success: { [weak self] (videoCode) in
            self?.videoCode = videoCode
            let response = DetailMovieModels.ShowTrailer.Response(videoCode: videoCode, errorMessage: nil)
            self?.presenter?.presentTrailer(response: response)
        },
                           failure: { [weak self] (error) in
            let response = DetailMovieModels.ShowTrailer.Response(videoCode: nil, errorMessage: error?.localizedDescription)
            self?.presenter?.presentTrailer(response: response)
        })
    }
    
    func setFavouriteStatus() {
        isAddedToFavourite.toggle()
        dataBaseWorker?.change(status: .favourite, for: detailMovie)
        
        let response = DetailMovieModels.SetFavouriteStatus.Response(isAddedToFavourite: isAddedToFavourite)
        presenter?.presentFavouriteStatus(response: response)
    }
    
    func setWatchLaterStatus() {
        isAddedToWatchLater.toggle()
        dataBaseWorker?.change(status: .watchLater, for: detailMovie)
        
        let response = DetailMovieModels.SetWatchLaterStatus.Response(isAddedToWatchLater: isAddedToWatchLater)
        presenter?.presentWatchLaterStatus(response: response)
    }
    
    func selectOverviewReviewSegment(request: DetailMovieModels.SelectOverviewReviewsSegmentedControl.Request) {
        if request.selectedSegmentIndex == 0 {
            if let overview = detailMovie.overview {
                let response = DetailMovieModels.SelectOverviewReviewsSegmentedControl.Response(overviewReviews: overview, errorMessage: nil)
                presenter?.presentOverviewReview(response: response)
            }
        } else {
            networkWorker?.getReviews(forMovieId: movieId,
                               success: { [weak self] (reviewList) in
                self?.reviews = reviewList?.getReviewAsString()
                let response = DetailMovieModels.SelectOverviewReviewsSegmentedControl.Response(overviewReviews: self?.reviews, errorMessage: nil)
                self?.presenter?.presentOverviewReview(response: response)
            },
                               failure: { [weak self] (error) in
                let response = DetailMovieModels.SelectOverviewReviewsSegmentedControl.Response(overviewReviews: nil, errorMessage: error?.localizedDescription)
                self?.presenter?.presentOverviewReview(response: response)
            })
        }
    }
}
