//
//  TrailerList.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 9/1/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

struct TrailerList: Decodable {
    let id: Int?
    let results: [Trailer]?
}
