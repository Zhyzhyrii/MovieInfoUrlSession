//
//  SignInUpRouter.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 10/30/19.
//  Copyright (c) 2019 Igor Zhyzhyrii. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol SignInUpRoutingLogic {
    func routeToCategoriesTable(segue: UIStoryboardSegue?)
}

protocol SignInUpDataPassing {
    var dataStore: SignInUpDataStore? { get }
}

class SignInUpRouter: NSObject, SignInUpRoutingLogic, SignInUpDataPassing {
    
    weak var viewController: SignInUpViewController?
    var dataStore: SignInUpDataStore?
    
    // MARK: Routing
    
    //I am going to use this method once I create profile page for storing user name, surname on this page
    
    func routeToCategoriesTable(segue: UIStoryboardSegue?) {
//      if let segue = segue {
//        let destinationVC = segue.destination as! CategoriesTableViewController
//        var destinationDS = destinationVC.router!.dataStore!
//        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//      } else {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let destinationVC = storyboard.instantiateViewController(withIdentifier: "CategoriesTableViewController") as! CategoriesTableViewController
//        var destinationDS = destinationVC.router!.dataStore!
//        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//        navigateToSomewhere(source: viewController!, destination: destinationVC)
//      }
    }
    
    // MARK: Navigation
    
//    func navigateToSomewhere(source: SignInUpViewController, destination: CategoriesTableViewController) {
//      source.show(destination, sender: nil)
//    }
    
    // MARK: Passing data
    
//    func passDataToSomewhere(source: SignInUpDataStore, destination: inout CategoriesTableDataStore) {
//      destination.name = source.name
//    }
}