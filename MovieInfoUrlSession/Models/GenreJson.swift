//
//  GenreJson.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 9/29/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

struct GenreJson: Decodable {
    
    let genres: [Genre]?
    
    enum CodingKeys: CodingKey {
        case genres
    }
}
