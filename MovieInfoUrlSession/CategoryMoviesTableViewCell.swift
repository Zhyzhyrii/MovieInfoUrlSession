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
    
    var movies: [MovieJson] = Array()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moviesCollection.dataSource = self
    }
    
}

extension CategoryMoviesTableViewCell: UICollectionViewDataSource { //try to move to VC as extension
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionCell
        cell.configure(with: movies[indexPath.row])
       
        return cell
    }
}
