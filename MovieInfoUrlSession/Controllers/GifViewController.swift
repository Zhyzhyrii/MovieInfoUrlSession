//
//  GifViewController.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 8/29/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import UIKit
import WebKit

class GifViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    
    let filePath = Bundle.main.path(forResource: "launch", ofType: "gif")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gif = NSData(contentsOfFile: filePath!)
        webView.load(gif! as Data, mimeType: "image/gif", characterEncodingName: String(), baseURL: NSURL() as URL)
        loadNextVC()
    }
    
    func loadNextVC() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.performSegue(withIdentifier: "GoToMainFunctionality", sender: self)
        }
    }
}
