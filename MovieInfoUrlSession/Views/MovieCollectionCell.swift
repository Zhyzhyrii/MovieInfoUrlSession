//
//  MovieCollectionCell.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 9/19/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {
    
    @IBOutlet var posterImageView: ImageView!
    @IBOutlet var titleLabel: UILabel!
//    @IBOutlet var yearGenreLabel: UILabel!

    func configure(with movie: CategoriesModels.FetchMovies.ViewModel.DisplayedDetails) {
        titleLabel.text = movie.movieTitle ?? ""
//        yearGenreLabel.text = "\(movie.releaseDate ?? ""), \(movie.genreName)"
        posterImageView.fetchImage(with: movie.posterPath)
    }
}
