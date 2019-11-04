//
//  CategoriesModels.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 10/21/19.
//  Copyright (c) 2019 Igor Zhyzhyrii. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum CategoriesModels {
    
    // MARK: Use cases
    
    enum FetchMovies {
        struct Request {
        }
        
        struct Response {
            var movies: [MovieType : [MovieJson]]?
            let errorMessage: String?
        }
        
        struct ViewModel {
            let displayedDetails: [MovieType : [DisplayedDetails]]?
            let errorMessage: String?
            
            struct DisplayedDetails {
                let movieTitle: String?
                let posterPath: String?
                
                let movieId: Int?
            }
        }
    }
    
    enum SelectMovie {
        struct Request {
            let movieId: Int!
        }
    }
}
