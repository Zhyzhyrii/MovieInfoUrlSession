//
//  CategoriesConfigurator.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 10/21/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

class CategoriesConfigurator {
    
    static let shared = CategoriesConfigurator()
    
    func configure(with view: CategoriesTableViewController) {
        let viewController = view
        let interactor = CategoriesInteractor()
        let presenter = CategoriesPresenter()
        let router = CategoriesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
