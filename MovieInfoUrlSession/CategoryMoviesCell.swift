//
//  CategoryMoviesCollectionCell.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 9/18/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//
import UIKit

class CategoryMoviesCollectionCell: UICollectionViewCell {
    
    var movies: [MovieJson] = []
    
    
    @IBOutlet var moviesCollection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moviesCollection.dataSource = self
    }
    
}

extension CategoryMoviesCollectionCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath)
        
        return cell
    }
}

