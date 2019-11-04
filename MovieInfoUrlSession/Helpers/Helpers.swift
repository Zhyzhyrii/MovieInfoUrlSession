//
//  UIHelpers.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 8/29/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import UIKit

class UIHelpers {
    
    static func showAlert(withTitle title: String, message: String, viewController: UIViewController, buttonTitle: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = createAlert(withTitle: title, message: message, buttonTitle: buttonTitle, handler: handler)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func verifyStringIsNotEmpty(_ string: String?) -> String? {
        guard let data = string, !(data.isEmpty) else { return nil }
        
        return data
    }
    
    static func verifyStringDoesNotContainDigits(_ string: String?) -> String? {
        
        guard let data = verifyStringIsNotEmpty(string) else { return nil }
        
        if let _ = Double(data) { return nil }
        
        return data
    }
    
    private static func createAlert(withTitle title: String, message: String, buttonTitle: String, handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: buttonTitle, style: .default, handler: handler)
        alertController.addAction(okAction)
        return alertController
    }
    
}
