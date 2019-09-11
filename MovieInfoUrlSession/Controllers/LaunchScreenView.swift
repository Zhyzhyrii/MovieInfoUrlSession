//
//  LaunchScreenView.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 8/29/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import UIKit
import SwiftyGif

class LaunchScreenView: UIView {
    
    let logoGifImageView = try! UIImageView(gifImage: UIImage(gifName: "launch.gif"), loopCount: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit() {
//        backgroundColor = UIColor(white: 246.0 / 255.0, alpha: 1)
        addSubview(logoGifImageView)
        logoGifImageView.translatesAutoresizingMaskIntoConstraints = false
        logoGifImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoGifImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        logoGifImageView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        logoGifImageView.heightAnchor.constraint(equalToConstant: 108).isActive = true
    }
    
}
