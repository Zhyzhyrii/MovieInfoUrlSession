//
//  WelcomeViewController.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 8/30/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private var isSignInClicked = false
    
    @IBAction func signInUpButton(_ sender: UIButton) {
    
        switch sender.tag {
        case 0:
            isSignInClicked = true
            performSegue(withIdentifier: "ShowSignInUpVC", sender: self)
        case 1:
            isSignInClicked = false
            performSegue(withIdentifier: "ShowSignInUpVC", sender: self)
        default:
            print("Another button was clicked")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SignInUpViewController
        destinationVC.isSignInClicked = isSignInClicked
    }
}
