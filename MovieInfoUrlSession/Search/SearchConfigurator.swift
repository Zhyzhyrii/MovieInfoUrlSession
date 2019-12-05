//
//  SearchConfigurator.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 02.12.2019.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

class SearchConfigurator {
    
    static let shared = SearchConfigurator()
    
    func configure(with view: SearchViewController) {
        let viewController = view
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
}
