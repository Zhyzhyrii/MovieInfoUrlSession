//
//  CategoriesRouter.swift
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

@objc protocol CategoriesRoutingLogic {
    func routeToDetailMovie(segue: UIStoryboardSegue?)
}

protocol CategoriesDataPassing {
    var dataStore: CategoriesDataStore? { get }
}

class CategoriesRouter: NSObject, CategoriesRoutingLogic, CategoriesDataPassing {
    
    weak var viewController: CategoriesTableViewController?
    var dataStore: CategoriesDataStore?
    
    // MARK: Routing
    
    func routeToDetailMovie(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! DetailMovieViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToDetailMovie(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "DetailMovieViewController") as! DetailMovieViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToDetailMovie(source: dataStore!, destination: &destinationDS)
            navigateToDetailMovie(source: viewController!, destination: destinationVC)
        }
    }
    
    // MARK: Navigation
    
    func navigateToDetailMovie(source: CategoriesTableViewController, destination: DetailMovieViewController) {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToDetailMovie(source: CategoriesDataStore, destination: inout DetailMovieDataStore) {
        destination.movieId = source.selectedMovieId
    }
}
