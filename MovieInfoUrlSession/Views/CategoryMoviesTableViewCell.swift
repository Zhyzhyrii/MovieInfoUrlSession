//
//  CategoryMoviesTableViewCell.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 9/23/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import UIKit

class  CategoryMoviesTableViewCell: UITableViewCell {
    
    @IBOutlet var moviesCollection: UICollectionView!
    
    var movies: [CategoriesModels.FetchMovies.ViewModel.DisplayedDetails] = Array()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moviesCollection.dataSource = self
    }
    
}

extension CategoryMoviesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionCell
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
       
        return cell
    }
}
