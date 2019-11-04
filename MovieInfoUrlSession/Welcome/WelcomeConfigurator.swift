//
//  WelcomeConfigurator.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 10/29/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import Foundation

class WelcomeConfigurator {
    
    static let shared = WelcomeConfigurator()
    
    // MARK: Setup
    
    func configure(with view: WelcomeViewController) {
        let viewController = view
        let interactor = WelcomeInteractor()
        let presenter = WelcomePresenter()
        let router = WelcomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
}
