//
//  EndPoint.swift
//  MovieInfoApp
//
//  Created by Игорь on 8/23/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import Foundation

protocol EndPoint {
    var baseURL: URL { get }
    var path: String { get }
    var request: URLRequest { get }
}
