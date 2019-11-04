//
//  DetailMovieViewController.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 10/13/19.
//  Copyright (c) 2019 Igor Zhyzhyrii. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import WebKit

protocol DetailMovieDisplayLogic: class {
    func displayMovieDetails(viewModel: DetailMovieModels.ShowDetails.ViewModel)
    func displayMovieDetailsError(viewModel: DetailMovieModels.ShowDetails.ViewModel)
    
    func displayTrailer(viewModel: DetailMovieModels.ShowTrailer.ViewModel)
    func displayTrailerError(viewModel: DetailMovieModels.ShowTrailer.ViewModel)
    
    func displayFavouriteStatus(viewModel: DetailMovieModels.SetFavouriteStatus.ViewModel)
    func displayWatchLaterStatus(viewModel: DetailMovieModels.SetWatchLaterStatus.ViewModel)
    
    func displayOverviewReviews(viewModel: DetailMovieModels.SelectOverviewReviewsSegmentedControl.ViewModel)
    func displayeOverViewReviewsError(viewModel: DetailMovieModels.SelectOverviewReviewsSegmentedControl.ViewModel)
}

class DetailMovieViewController: UIViewController {
    
    @IBOutlet var trailerPlayer: WKWebView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseGenreLabel: UILabel!
    @IBOutlet var runTimeLabel: UILabel!
    @IBOutlet var addtoFavoriteButton: UIButton!
    @IBOutlet var watchLaterButton: UIButton!
    @IBOutlet var overviewReviewSegmentedControl: UISegmentedControl!
    @IBOutlet var overviewReviewTextView: UITextView!
    @IBOutlet var voteAverageLabel: UILabel!
    
    var interactor: DetailMovieBusinessLogic?
    var router: (NSObjectProtocol & DetailMovieRoutingLogic & DetailMovieDataPassing)?
    
    // MARK: Object lifecycle
    
    //initiate before starting lifecycle for router
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        DetailMovieConfigurator.shared.configure(with: self)
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showDetails()
        showTrailer()
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: Show details
    
    private func showDetails() {
        let request = DetailMovieModels.ShowDetails.Request()
        interactor?.showDetails(request: request)
    }
    
    private func showTrailer() {
        let request = DetailMovieModels.ShowTrailer.Request()
        interactor?.showTrailer(request: request)
    }
    
    @IBAction func addToFavoritePressed() {
        interactor?.setFavouriteStatus()
    }
    
    @IBAction func watchLaterPressed() {
        interactor?.setWatchLaterStatus()
    }
    
    @IBAction func segmentedValueChanged(_ sender: UISegmentedControl) {
        let request = DetailMovieModels.SelectOverviewReviewsSegmentedControl.Request(selectedSegmentIndex: sender.selectedSegmentIndex)
        interactor?.selectOverviewReviewSegment(request: request)
    }
}

extension DetailMovieViewController: DetailMovieDisplayLogic {
    func displayMovieDetails(viewModel: DetailMovieModels.ShowDetails.ViewModel) {
        guard let displayedDetails = viewModel.displayedDetails else { return }
        DispatchQueue.main.async {
            self.titleLabel.text = displayedDetails.movieTitle
            self.releaseGenreLabel.text = displayedDetails.releaseGenre
            self.runTimeLabel.text = displayedDetails.runTime
            self.voteAverageLabel.text = displayedDetails.voteAverage
            
            self.overviewReviewTextView.text = displayedDetails.overView
            
            self.updateAddToFavoriteUISection(if: displayedDetails.isAddedToFavourite)
            self.updateAddToWatchLaterUISection(if: displayedDetails.isAddedToWatchLater)
        }
    }
    
    func displayMovieDetailsError(viewModel: DetailMovieModels.ShowDetails.ViewModel) {
        Helpers.showAlert(withTitle: "Ошибка",
                            message: "Данные о фильме не были получены из сети",
                            viewController: self,
                            buttonTitle: "Вернуться назад",
                            handler: { action in
                                self.navigationController?.popViewController(animated: true)})
    }
    
    func displayTrailer(viewModel: DetailMovieModels.ShowTrailer.ViewModel) {
        guard let urlTrailer = viewModel.trailerUrl else { return }
        DispatchQueue.main.async {
            self.trailerPlayer.load(URLRequest(url: urlTrailer))
        }
    }
    
    func displayTrailerError(viewModel: DetailMovieModels.ShowTrailer.ViewModel) {
        Helpers.showAlert(withTitle: "Ошибка",
                            message: "Данные о трейлере не были получены из сети",
                            viewController: self,
                            buttonTitle: "OK",
                            handler: nil)
    }
    
    func displayFavouriteStatus(viewModel: DetailMovieModels.SetFavouriteStatus.ViewModel) {
        updateAddToFavoriteUISection(if: viewModel.isAddedToFavourite)
    }
    
    func displayWatchLaterStatus(viewModel: DetailMovieModels.SetWatchLaterStatus.ViewModel) {
        updateAddToWatchLaterUISection(if: viewModel.isAddedToWatchLater)
    }
    
    func displayOverviewReviews(viewModel: DetailMovieModels.SelectOverviewReviewsSegmentedControl.ViewModel) {
        DispatchQueue.main.async {
            self.overviewReviewTextView.text = viewModel.overviewReviews
        }
    }
    
    func displayeOverViewReviewsError(viewModel: DetailMovieModels.SelectOverviewReviewsSegmentedControl.ViewModel) {
        Helpers.showAlert(withTitle: "Ошибка",
                            message: "Данные не были получены из сети",
                            viewController: self,
                            buttonTitle: "OK",
                            handler: { action in
                                self.overviewReviewSegmentedControl.selectedSegmentIndex = 0
        })
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
    
    private func updateAddToWatchLaterUISection(if isPresentInWatchLater: Bool) {
        if !isPresentInWatchLater {
            watchLaterButton.setImage(UIImage(named: "bookmark"), for: .normal)
            watchLaterButton.setTitle(" Смотреть позже", for: .normal)
        } else {
            watchLaterButton.setImage(UIImage(named: "bookmarkSelected"), for: .normal)
            watchLaterButton.setTitle(" Посмотрю позже", for: .normal)
        }
    }
}
