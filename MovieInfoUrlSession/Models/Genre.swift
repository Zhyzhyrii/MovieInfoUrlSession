//
//  Genre.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 9/1/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

struct Genre: Decodable {
    
    let genreName: String?
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case genreName = "name"
    }
}
