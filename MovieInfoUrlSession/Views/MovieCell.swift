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
    
    func configure(with movie: MovieJson) {
        titleLabel.text = "Название: \(movie.title ?? "")"
        voteAverageLabel.text = "Рейтинг: \(movie.voteAverage ?? 0)"
        posterImageView.fetchImage(with: movie.posterPath)
    }
    
    func configure(with movie: FavouriteModels.GetMovies.ViewModel.DisplayedDetails) {
        titleLabel.text = movie.movieTitle
        voteAverageLabel.text = movie.rate
        posterImageView.fetchImage(with: movie.posterPath)
    }
}
