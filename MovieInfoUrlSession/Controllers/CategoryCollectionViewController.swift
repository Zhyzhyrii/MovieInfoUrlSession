//
//  CategoryCollectionViewController.swift
//  MovieInfoApp
//
//  Created by Игорь on 8/22/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import UIKit

enum UserAction: String, CaseIterable {
    case topRatedMovies = "Get top rated movies"
    case popularMovies = "Get popular movies"
    case upcomingMovies = "Get upcoming movies"
    case nowPlayingMovies = "Get now playing movies"
}

class CategoryCollectionViewController: UICollectionViewController {
    
    private var userAction: UserAction!
    
    private let userActions = UserAction.allCases
    private let reuseIdentifier = "CategoryCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let moviesListVC = segue.destination as! MoviesListViewController
            switch userAction! {
            case .topRatedMovies:
                moviesListVC.movieType = .topRated
            case .popularMovies:
                moviesListVC.movieType = .popular
            case .upcomingMovies:
                moviesListVC.movieType = .upComing
            case .nowPlayingMovies:
                moviesListVC.movieType = .nowPlaying
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return userActions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCell
        cell.userActionLabel.text = userActions[indexPath.item].rawValue
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userAction = userActions[indexPath.item]
        performSegue(withIdentifier: "ShowMovies", sender: nil)
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        print("pressed")
        dismiss(animated: true, completion: nil)
    }
}
