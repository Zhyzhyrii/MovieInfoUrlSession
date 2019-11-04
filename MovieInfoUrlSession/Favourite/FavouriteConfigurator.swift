//
//  FavouriteConfigurator.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 11/4/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

class FavouriteConfigurator {
    
    static let shared = FavouriteConfigurator()
    
    func configure(with view: FavouriteViewController) {
        let viewController = view
        let interactor = FavouriteInteractor()
        let presenter = FavouritePresenter()
        let router = FavouriteRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
}
