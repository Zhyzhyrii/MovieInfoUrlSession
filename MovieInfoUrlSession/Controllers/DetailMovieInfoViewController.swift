//
//  DetailMovieInfoViewController.swift
//  MovieInfoApp
//
//  Created by Игорь on 8/28/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import UIKit

class DetailMovieInfoViewController: UIViewController {
    
    var movie: Movie!
    
    @IBOutlet var backImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var voteAverageLabel: UILabel!
    @IBOutlet var overviewLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = movie.title ?? ""
        voteAverageLabel.text = "\(movie.voteAverage ?? 0)"
        overviewLabel.text = movie.overview ?? ""
        displayBackImage(for: movie)
    }
    
    private func displayBackImage(for movie: Movie) {
        
        guard let backImagePath = movie.backdropPath else { return }
        guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(backImagePath)") else { return }
        guard let imageData = try? Data(contentsOf: imageUrl) else { return }
        
        backImageView.image = UIImage(data: imageData)
    }
}
