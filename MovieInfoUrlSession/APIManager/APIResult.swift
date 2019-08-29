//
//  APIResult.swift
//  MovieInfoApp
//
//  Created by Игорь on 8/24/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

enum APIResult<T> {
    case Success(T)
    case Failure(Error)
}
