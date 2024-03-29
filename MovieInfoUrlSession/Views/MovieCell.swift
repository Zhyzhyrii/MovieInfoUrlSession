//
//  MovieCell.swift
//  MovieInfoApp
//
//  Created by Игорь on 8/28/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet var posterImageView: ImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var voteAverageLabel: UILabel!
    
    func configure(with movie: DetailMovieInList) {
        titleLabel.text = movie.movieTitle
        voteAverageLabel.text = movie.rate
        posterImageView.fetchImage(with: movie.posterPath)
    }
}
