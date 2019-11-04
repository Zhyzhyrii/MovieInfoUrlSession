//
//  WatchLaterConfigurator.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 11/4/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

class WatchLaterConfigurator {
    
    static let shared = WatchLaterConfigurator()
    
    func configure(with view: WatchLaterViewController) {
        let viewController = view
        let interactor = WatchLaterInteractor()
        let presenter = WatchLaterPresenter()
        let router = WatchLaterRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
}
