//
//  UIHelpers.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 8/29/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import UIKit

class UIHelpers {
    
    static func showAlert(withTitle title: String, message: String, buttonTitle: String, handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: buttonTitle, style: .default, handler: handler)
        alertController.addAction(okAction)
        return alertController
    }
    
}
