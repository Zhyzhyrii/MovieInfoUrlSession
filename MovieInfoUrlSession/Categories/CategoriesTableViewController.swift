//
//  CategoriesViewController.swift
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

protocol CategoriesDisplayLogic: class {
    func displayMovies(viewModel: CategoriesModels.FetchMovies.ViewModel)
    func displayMoviesError(viewModel: CategoriesModels.FetchMovies.ViewModel)
}

class CategoriesTableViewController: UITableViewController {
    
    var interactor: CategoriesBusinessLogic?
    var router: (NSObjectProtocol & CategoriesRoutingLogic & CategoriesDataPassing)?
    
    var fetchedData: [MovieType: [CategoriesModels.FetchMovies.ViewModel.DisplayedDetails]] = [:]
    
    private let movieCategories = MovieType.allCases
    private let reuseIdentifier = "CategoryCell"
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CategoriesConfigurator.shared.configure(with: self)
        
        fetchMovies()
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
    
    // MARK: Present movies
    
    func fetchMovies() {
        let request = CategoriesModels.FetchMovies.Request()
        interactor?.fetchMovies(request: request)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return movieCategories[section].rawValue
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! CategoryMoviesTableViewCell
        
        cell.moviesCollection.delegate = self
        
        if let movies = fetchedData[movieCategories[indexPath.section]] {
            cell.movies = movies
        }
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Futura", size: 23)!
        header.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
}

// MARK: - Extension

extension CategoriesTableViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let tableViewcell = collectionView.superview?.superview as? CategoryMoviesTableViewCell {
            guard let tableViewIndexPath = tableView.indexPath(for: tableViewcell) else { fatalError() }
            
            if let movies = fetchedData[movieCategories[tableViewIndexPath.section]] {
                let request = CategoriesModels.SelectMovie.Request(movieId: movies[indexPath.row].movieId)
              interactor?.selectMovie(request: request)
                performSegue(withIdentifier: "DetailMovie", sender: nil)
            }
        }
    }
}

extension CategoriesTableViewController: CategoriesDisplayLogic {
    
    func displayMovies(viewModel: CategoriesModels.FetchMovies.ViewModel) {
        guard let movies = viewModel.displayedDetails else { return }
        fetchedData = movies
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func displayMoviesError(viewModel: CategoriesModels.FetchMovies.ViewModel) {
        Helpers.showAlert(withTitle: "Ошибка",
                                        message: "Данные о фильмах не были получены из сети",
                                        viewController: self,
                                        buttonTitle: "OK",
                                        handler: nil)
    }
}
