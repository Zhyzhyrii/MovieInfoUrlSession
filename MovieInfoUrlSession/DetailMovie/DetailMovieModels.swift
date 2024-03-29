//
//  DetailMovieModels.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 10/13/19.
//  Copyright (c) 2019 Igor Zhyzhyrii. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation

enum DetailMovieModels {
    
    // MARK: Use cases
    
    enum ShowDetails {
        
        struct Request {
        }
        
        struct Response {
            let detailMovie: DetailMovie?
            let isAddedToFavourite: Bool
            let isAddedToWatchLater: Bool
            let errorMessage: String?
        }
        
        struct ViewModel {
            let displayedDetails: DisplayedDetails?
            let errorMessage: String?
            
            struct DisplayedDetails {
                let movieTitle: String?
                let releaseGenre: String?
                let runTime: String?
                let voteAverage: String?
                let overView: String?
                let isAddedToFavourite: Bool
                let isAddedToWatchLater: Bool
            }
        }
    }
    
    enum ShowTrailer {
        
        struct Request {
        }
        
        struct Response {
            let videoCode: String?
            let errorMessage: String?
        }
        
        struct ViewModel {
            let trailerUrl: URL?
            let errorMessage: String?
        }
    }
    
    enum SetFavouriteStatus {
        
        struct Request {
        }
        
        struct Response {
            let isAddedToFavourite: Bool
        }
        
        struct ViewModel {
            let isAddedToFavourite: Bool
        }
        
    }
    
    enum SetWatchLaterStatus {
        
        struct Request {
        }
        
        struct Response {
            let isAddedToWatchLater: Bool
        }
        
        struct ViewModel {
            let isAddedToWatchLater: Bool
        }
        
    }
    
    enum SelectOverviewReviewsSegmentedControl {
        
        struct Request {
            let selectedSegmentIndex: Int
        }
        
        struct Response {
            let overviewReviews: String?
            let errorMessage: String?
        }
        
        struct ViewModel {
            let overviewReviews: String?
            let errorMessage: String?
        }
        
    }
    
}
