//
//  Genre.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 9/1/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import RealmSwift

class Genre: Object, Decodable {
    
    @objc dynamic var genreName: String?
    let id = RealmOptional<Int>()
    
    enum CodingKeys: String, CodingKey {
        case id
        case genreName = "name"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id.value = try container.decodeIfPresent(Int.self, forKey: .id)
        genreName = try container.decodeIfPresent(String.self, forKey: .genreName)
    }
    
}
