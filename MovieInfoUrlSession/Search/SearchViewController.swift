//
//  SearchViewController.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 28.11.2019.
//  Copyright (c) 2019 Igor Zhyzhyrii. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SearchDisplayLogic: class {
    func displaySearchSuccess(viewModel: SearchModels.Search.ViewModel)
    func displaySearchError(viewModel: SearchModels.Search.ViewModel)
}

class SearchViewController: UITableViewController, UISearchBarDelegate, SearchDisplayLogic {
    
    @IBOutlet var searchBar: UISearchBar!
    
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    
    var movies: [DisplayedDetails] = []
    
    // MARK: Object lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        SearchConfigurator.shared.configure(with: self)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let request = SearchModels.Search.Request(queryString: searchText)
        interactor?.searchMovie(request: request)
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
    
    // MARK: Search movies
    
    func displaySearchSuccess(viewModel: SearchModels.Search.ViewModel) {
        guard let movies = viewModel.displayedDetails else { return }
        self.movies = movies
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func displaySearchError(viewModel: SearchModels.Search.ViewModel) {
        Helpers.showAlert(withTitle: "Ошибка",
                          message: "Поиск не дал результатов",
                          viewController: self,
                          buttonTitle: "OK",
                          handler: nil)
    }
    
    private func setUpTextField() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30)))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        
        searchBar.searchTextField.inputAccessoryView = toolbar
    }
    
    @objc private func doneButtonAction() {
        view.endEditing(true)
    }
}

extension SearchViewController {
    
    //MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        
        return cell
    }
    
    //MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = movies[indexPath.row].movieId
        let request = SearchModels.SelectMovie.Request(movieId: movieId)
        interactor?.selectMovie(request: request)
        performSegue(withIdentifier: "DetailMovie", sender: nil)
    }
    
}