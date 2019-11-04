//
//  SignInUpConfigurator.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 10/30/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

class SignInUpConfigurator {
    
    static let shared = SignInUpConfigurator()
    
    func configure(with view: SignInUpViewController) {
        let viewController = view
        let interactor = SignInUpInteractor()
        let presenter = SignInUpPresenter()
        let router = SignInUpRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
}
