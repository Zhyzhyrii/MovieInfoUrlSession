//
//  MoviesListViewController.swift
//  MovieInfoApp
//
//  Created by Игорь on 8/27/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import UIKit

class MoviesListViewController: UITableViewController {
    
    var movieType: MovieType!
    
    private var selectedMovie: Movie!
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIMovieManager.fetchMovies(from: movieType) { (movies, result) in
            switch result {
            case .Success:
                guard let movies = movies else { return }
                self.movies = movies
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .Failure:
                let alert = UIHelpers.showAlert(withTitle: "Ошибка",
                                                message: "Данные не были получены из сети",
                                                buttonTitle: "Вернуться назад",
                                                handler: { action in self.navigationController?.popViewController(animated: true)
                })
                
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovie = movies[indexPath.row]
        performSegue(withIdentifier: "GoToDetailViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetailViewController" {
            let destinationVC = segue.destination as! DetailMovieInfoViewController
            destinationVC.movie = selectedMovie
        }
    }
}
