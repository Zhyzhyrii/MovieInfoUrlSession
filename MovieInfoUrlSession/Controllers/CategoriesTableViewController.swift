//
//  CategoriesTableViewController.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 9/18/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    private var selectedMovieId: Int!
    
    private let movieCategories = MovieType.allCases
    private let reuseIdentifier = "CategoryCell"
    
    var movies: [MovieJson] = Array()
    var fetchedData: [MovieType: [MovieJson]] = [:]
    var genreJson: GenreJson!
    var genresDictionary: [Int: String] = [:]
    var category: MovieType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        APIMovieManager.fetchMovies(from: .topRated) { (movies, result) in
            switch result {
            case .Success:
                guard let movies = movies else { return }
                self.fetchedData[.topRated] = movies
                DispatchQueue.main.async { //todo remove this main queue (try)
                    self.tableView.reloadData()
                }
            case .Failure:
                let alert = UIHelpers.showAlert(withTitle: "Ошибка",
                                                message: "Данные не были получены из сети",
                                                buttonTitle: "Вернуться назад",
                                                handler: { action in
                                                    self.navigationController?.popViewController(animated: true)
                })
                
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
        APIMovieManager.fetchMovies(from: .popular) { (movies, result) in
            switch result {
            case .Success:
                guard let movies = movies else { return }
                self.fetchedData[.popular] = movies
                DispatchQueue.main.async { //todo remove this main queue (try)
                    self.tableView.reloadData()
                }
            case .Failure:
                let alert = UIHelpers.showAlert(withTitle: "Ошибка",
                                                message: "Данные не были получены из сети",
                                                buttonTitle: "Вернуться назад",
                                                handler: { action in
                                                    self.navigationController?.popViewController(animated: true)
                })
                
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
        APIMovieManager.fetchMovies(from: .upComing) { (movies, result) in
            switch result {
            case .Success:
                guard let movies = movies else { return }
                self.fetchedData[.upComing] = movies
                DispatchQueue.main.async { //todo remove this main queue (try)
                    self.tableView.reloadData()
                }
            case .Failure:
                let alert = UIHelpers.showAlert(withTitle: "Ошибка",
                                                message: "Данные не были получены из сети",
                                                buttonTitle: "Вернуться назад",
                                                handler: { action in
                                                    self.navigationController?.popViewController(animated: true)
                })
                
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
        APIMovieManager.fetchMovies(from: .nowPlaying) { (movies, result) in
            switch result {
            case .Success:
                guard let movies = movies else { return }
                self.fetchedData[.nowPlaying] = movies
                DispatchQueue.main.async { //todo remove this main queue (try)
                    self.tableView.reloadData()
                }
            case .Failure:
                let alert = UIHelpers.showAlert(withTitle: "Ошибка",
                                                message: "Данные не были получены из сети",
                                                buttonTitle: "Вернуться назад",
                                                handler: { action in
                                                    self.navigationController?.popViewController(animated: true)
                })
                
                self.present(alert, animated: true, completion: nil)
                
            }
        }
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
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetailViewController" {
            let destinationVC = segue.destination as! DetailMovieViewController
            destinationVC.movieId = selectedMovieId
        }
    }
}

// MARK: - Extension

extension CategoriesTableViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let tableViewcell = collectionView.superview?.superview as? CategoryMoviesTableViewCell {
            guard let tableViewIndexPath = tableView.indexPath(for: tableViewcell) else { fatalError() }
            
            if let movies = fetchedData[movieCategories[tableViewIndexPath.section]] {
                selectedMovieId = movies[indexPath.row].id
            }
        }
        performSegue(withIdentifier: "GoToDetailViewController", sender: nil)
    }
}
