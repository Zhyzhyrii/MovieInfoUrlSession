//
//  DetailMovieConfigurator.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 10/21/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

class DetailMovieConfigurator {
    
    static let shared = DetailMovieConfigurator()
    
    func configure(with view: DetailMovieViewController) {
        let viewController = view
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
