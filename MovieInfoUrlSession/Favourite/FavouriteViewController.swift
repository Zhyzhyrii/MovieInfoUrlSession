//
//  FavouriteViewController.swift
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

protocol FavouriteDisplayLogic: class {
    func displayMovies(viewModel: FavouriteModels.GetMovies.ViewModel)
}

class FavouriteViewController: UITableViewController, FavouriteDisplayLogic {
    
    var interactor: FavouriteBusinessLogic?
    var router: (NSObjectProtocol & FavouriteRoutingLogic & FavouriteDataPassing)?
    
    private var movies: [FavouriteModels.GetMovies.ViewModel.DisplayedDetails]!
    
    // MARK: Object lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        FavouriteConfigurator.shared.configure(with: self)
    }
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let request = FavouriteModels.GetMovies.Request()
        interactor?.getMovies(request: request)
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    func displayMovies(viewModel: FavouriteModels.GetMovies.ViewModel) {
        movies = viewModel.displayedDetails
        tableView.reloadData()
    }
    
}

// MARK: - Extension

extension FavouriteViewController {
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        
        return cell
    }
    
}
