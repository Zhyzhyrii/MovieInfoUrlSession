//
//  WatchLaterModels.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 11/4/19.
//  Copyright (c) 2019 Igor Zhyzhyrii. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum WatchLaterModels {
   
    // MARK: Use cases
    
    enum GetMovies {
        struct Request {
        }
        
        struct Response {
            var movies: [DetailMovie]
        }
        
        struct ViewModel {
            let displayedDetails: [DisplayedDetails]
            
            struct DisplayedDetails: DetailMovieInList {
                let movieTitle: String?
                let posterPath: String?
                let rate: String?
                
                let movieId: Int?
            }
        }
    }
}
