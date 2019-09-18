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
    private var detailMovie: DetailMovie!
    private var reviewList: ReviewList!
    
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
        titleLabel.text = detailMovie.title ?? ""
        releaseGenreLabel.text = (detailMovie.releaseDate ?? "") + ", " + (detailMovie.getGenresAsString() ?? "")
        if let runTime = detailMovie.runTime {
            runTimeLabel.text = String(runTime) + " мин"
        } else {
            runTimeLabel.text = ""
        }
        voteAverageLabel.text = "\(detailMovie.voteAverage ?? 0)"
        overviewReviewTextView.text = detailMovie.overview ?? ""
        
        let isMoviePresenInFavorite = ListManager.listManager.isPresent(movie: detailMovie, in: .favoriteList)
        updateAddToFavoriteUISection(if: isMoviePresenInFavorite)
    }
    
    private func getMovieDetailedInfo() {
        APIMovieManager.fetchDetailMovie(movieId: movieId) { (detailMovie, result) in
            switch result {
            case .Success:
                guard let detailMovie = detailMovie else { return }
                self.detailMovie = detailMovie
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
    
    private func updateAddToFavoriteUISection(if isPresentInFavorite: Bool) {
        if !isPresentInFavorite {
            addtoFavoriteButton.setImage(UIImage(named: "heart"), for: .normal)
            addtoFavoriteButton.setTitle(" Добавить в избранное", for: .normal)
        } else {
            addtoFavoriteButton.setImage(UIImage(named: "heartColored"), for: .normal)
            addtoFavoriteButton.setTitle(" В избранном", for: .normal)
        }
    }
    
    @IBAction func addToFavoritePressed() {
        if ListManager.listManager.isPresent(movie: detailMovie, in: .favoriteList) {
            addtoFavoriteButton.setImage(UIImage(named: "heart"), for: .normal)
            addtoFavoriteButton.setTitle(" Добавить в избранное", for: .normal)
            detailMovie.isAddedToFavorite = false
            ListManager.listManager.remove(movie: detailMovie, from: .favoriteList)
        } else {
            addtoFavoriteButton.setImage(UIImage(named: "heartColored"), for: .normal)
            addtoFavoriteButton.setTitle(" В избранном", for: .normal)
            detailMovie.isAddedToFavorite = true
            ListManager.listManager.add(movie: detailMovie, to: .favoriteList)
        }
    }
    
    @IBAction func watchLaterPressed() {
        if ListManager.listManager.isPresent(movie: detailMovie, in: .watchLaterList) {
            watchLaterButton.setImage(UIImage(named: "bookmark"), for: .normal)
            watchLaterButton.setTitle(" Смотреть позже", for: .normal)
            detailMovie.isAddedToWatchLater = false
            ListManager.listManager.remove(movie: detailMovie, from: .watchLaterList)
        } else {
            watchLaterButton.setImage(UIImage(named: "bookmarkSelected"), for: .normal)
            watchLaterButton.setTitle(" Посмотрю позже", for: .normal)
            detailMovie.isAddedToWatchLater = true
            ListManager.listManager.add(movie: detailMovie, to: .watchLaterList)
        }
    }
    
    @IBAction func overviewReviewPressed() {
    }
    
    @IBAction func segmentedValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            overviewReviewTextView.text = detailMovie.overview
        } else {
            overviewReviewTextView.text = reviewList.getReviewAsString()
        }
    }
}
