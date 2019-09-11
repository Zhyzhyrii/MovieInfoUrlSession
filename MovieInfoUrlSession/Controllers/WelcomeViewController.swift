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
    private var isLoggedOut: Bool!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if let isLoggedOut = UserDefaults.standard.value(forKey: "isLoggedOut") as? Bool {
            self.isLoggedOut = isLoggedOut
        } else {
            isLoggedOut = false
        }
        
        if let _ = StorageManager.storageManager.getUser(), !isLoggedOut {
            performSegue(withIdentifier: "ShowCategories", sender: self)
        }
    }
    
    @IBAction func unwindToWelcomeVC(_ unwindSegue: UIStoryboardSegue) {
        UserDefaults.standard.setValue(true, forKey: "isLoggedOut")
    }
    
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
        if segue.identifier == "ShowSignInUpVC" {
            let destinationVC = segue.destination as! SignInUpViewController
            destinationVC.isSignInClicked = isSignInClicked
        }
    }    
}
