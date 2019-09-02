//
//  DetailMovieViewController.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 9/1/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import UIKit
import WebKit

class DetailMovieViewController: UIViewController {
    
    var movieId: Int!
    private var movieJson: DetailMovieJson!
    private var movie: Movie!
    private var reviewList: ReviewList!
    private var addedToFavorite = false
    private var addedToWatchLater = false
    
    @IBOutlet var trailerPlayer: WKWebView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseGenreLabel: UILabel!
    @IBOutlet var runTimeLabel: UILabel!
    @IBOutlet var addtoFavoriteButton: UIButton!
    @IBOutlet var watchLaterButton: UIButton!
    @IBOutlet var overviewReviewSegmentedControl: UISegmentedControl!
    @IBOutlet var overviewReviewTextView: UITextView!
    @IBOutlet var voteAverageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMovieDetailedInfo()
        getTrailer()
        getReviews()
    }
    
    private func configureUI() {
        titleLabel.text = movieJson.title ?? ""
        releaseGenreLabel.text = (movieJson.releaseDate ?? "") + ", " + (movieJson.getGenresAsString() ?? "")
        if let runTime = movieJson.runTime {
            runTimeLabel.text = String(runTime) + " мин"
        } else {
            runTimeLabel.text = ""
        }
        voteAverageLabel.text = "\(movieJson.voteAverage ?? 0)"
        overviewReviewTextView.text = movieJson.overview ?? ""
    }
    
    private func getMovieDetailedInfo() {
        APIMovieManager.fetchDetailMovie(movieId: movieId) { (detailMovie, result) in
            switch result {
            case .Success:
                guard let detailMovie = detailMovie else { return }
                self.movieJson = detailMovie
                self.movie = Movie(from: self.movieJson)
                DispatchQueue.main.async {
                    self.configureUI()
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
    
    private func getTrailer() {
        APIMovieManager.fetchMovieTrailer(movieId: movieId) { (trailers, result) in
            switch result {
            case .Success:
                guard let trailers = trailers, trailers.count > 0 else {
                    let alert = UIHelpers.showAlert(withTitle: "Трейлер отсутствует",
                                                    message: "Не удалось загрузить трейлер",
                                                    buttonTitle: "Хорошо",
                                                    handler: nil)
                    self.present(alert, animated: true, completion: nil)
                    return }
                guard let videoCode = trailers[0].key else { return }
                DispatchQueue.main.async {
                    guard let url = URL(string: "https://www.youtube.com/embed/\(videoCode)") else { return }
                    self.trailerPlayer.load(URLRequest(url: url))
                }
            case .Failure:
                let alert = UIHelpers.showAlert(withTitle: "Ошибка",
                                                message: "Данные не были получены из сети",
                                                buttonTitle: "Вернуться назад",
                                                handler: { action in                                        self.navigationController?.popViewController(animated: true)
                })
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func getReviews() {
        APIMovieManager.fetchMovieReviews(movieId: movieId) { (reviewlist, result) in
            switch result {
            case .Success:
                guard let reviewList = reviewlist else { return }
                self.reviewList = reviewList
            case .Failure:
                let alert = UIHelpers.showAlert(withTitle: "Ошибка",
                                                message: "Данные не были получены из сети",
                                                buttonTitle: "Вернуться назад",
                                                handler: { action in                                        self.navigationController?.popViewController(animated: true)
                })
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func addToFavoritePressed() {
        if addedToFavorite {
            addtoFavoriteButton.setImage(UIImage(named: "heart"), for: .normal)
            addtoFavoriteButton.setTitle(" Добавить в избранное", for: .normal)
            movie.isAddedToFavorite = false
        } else {
            addtoFavoriteButton.setImage(UIImage(named: "heartColored"), for: .normal)
            addtoFavoriteButton.setTitle(" В избранном", for: .normal)
            movie.isAddedToFavorite = true
        }
        addedToFavorite = !addedToFavorite
    }
    
    @IBAction func watchLaterPressed() {
        if addedToWatchLater {
            watchLaterButton.setImage(UIImage(named: "bookmark"), for: .normal)
            watchLaterButton.setTitle(" Смотреть позже", for: .normal)
            movie.isAddedToWatchLater = false
        } else {
            watchLaterButton.setImage(UIImage(named: "bookmarkSelected"), for: .normal)
            watchLaterButton.setTitle(" Посмотрю позже", for: .normal)
            movie.isAddedToWatchLater = true
        }
        addedToWatchLater = !addedToWatchLater
    }
    
    @IBAction func overviewReviewPressed() {
    }
    
    @IBAction func segmentedValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            overviewReviewTextView.text = movieJson.overview
        } else {
            overviewReviewTextView.text = reviewList.getReviewAsString()
        }
    }
}
