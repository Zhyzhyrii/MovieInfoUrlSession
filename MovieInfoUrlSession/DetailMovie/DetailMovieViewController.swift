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
    func displayTrailer(viewModel: DetailMovieModels.ShowTrailer.ViewModel)
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
    
    var movieId: Int!
    var interactor: DetailMovieBusinessLogic?
    var router: (NSObjectProtocol & DetailMovieRoutingLogic & DetailMovieDataPassing)?
    
    // MARK: Object lifecycle
    
    //initiate before starting lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
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
    
    @IBAction func addToFavoritePressed() {
        interactor?.setFavouriteStatus()
    }
    
    @IBAction func watchLaterPressed() {
        interactor?.setWatchLaterStatus()
    }
    
    @IBAction func segmentedValueChanged(_ sender: UISegmentedControl) {
        let request = DetailMovieModels.SelectOverviewReviewsSegmentedControl.Request(selectedSegmentIndex: sender.selectedSegmentIndex, movieId: movieId)
        interactor?.selectOverviewReviewSegment(request: request)
    }
    
    // MARK: Do show details
    
    private func showDetails() {
        let request = DetailMovieModels.ShowDetails.Request(detailMovieId: movieId)
        interactor?.showDetails(request: request)
    }
    
    private func showTrailer() {
        let request = DetailMovieModels.ShowTrailer.Request(detailMovieId: movieId)
        interactor?.showTrailer(request: request)
    }
    
    // MARK: Setup
    
    private func setup() { //move to configurator
        let viewController = self
        let interactor = DetailMovieInteractor()
        let presenter = DetailMoviePresenter()
        let router = DetailMovieRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension DetailMovieViewController: DetailMovieDisplayLogic {
    func displayMovieDetails(viewModel: DetailMovieModels.ShowDetails.ViewModel) { // add ui error message
        DispatchQueue.main.async {
            self.titleLabel.text = viewModel.displayedDetails.movieTitle
            self.releaseGenreLabel.text = viewModel.displayedDetails.releaseGenre
            self.runTimeLabel.text = viewModel.displayedDetails.runTime
            self.voteAverageLabel.text = viewModel.displayedDetails.voteAverage
            
            self.overviewReviewTextView.text = viewModel.displayedDetails.overView
            
            self.updateAddToFavoriteUISection(if: viewModel.displayedDetails.isAddedToFavourite)
            self.updateAddToWatchLaterUISection(if: viewModel.displayedDetails.isAddedToWatchLater)
        }
    }
    
    func displayTrailer(viewModel: DetailMovieModels.ShowTrailer.ViewModel) {
        guard let urlTrailer = viewModel.trailerUrl else { return } //add ui message trailer is missing
        DispatchQueue.main.async {
            self.trailerPlayer.load(URLRequest(url: urlTrailer))
        }
    }
    
    func displayFavouriteStatus(viewModel: DetailMovieModels.SetFavouriteStatus.ViewModel) {
        updateAddToFavoriteUISection(if: viewModel.isAddedToFavourite)
    }
    
    func displayWatchLaterStatus(viewModel: DetailMovieModels.SetWatchLaterStatus.ViewModel) {
        updateAddToWatchLaterUISection(if: viewModel.isAddedToWatchLater)
    }
    
    func displayOverviewReviews(viewModel: DetailMovieModels.SelectOverviewReviewsSegmentedControl.ViewModel) { //display error message
        DispatchQueue.main.async {
            self.overviewReviewTextView.text = viewModel.overviewReviews
        }
    }
    
    func displayeOverViewReviewsError(viewModel: DetailMovieModels.SelectOverviewReviewsSegmentedControl.ViewModel) {
        let alert = UIHelpers.showAlert(withTitle: "Ошибка",
                                        message: "Данные не были получены из сети",
                                        buttonTitle: "OK",
                                        handler: { action in
                                            self.overviewReviewSegmentedControl.selectedSegmentIndex = 0
        })
        
        self.present(alert, animated: true, completion: nil)
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