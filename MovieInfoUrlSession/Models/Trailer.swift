//
//  Trailer.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 9/1/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

struct Trailer: Decodable {
    let key: String?
    
    enum CodingKeys: String, CodingKey {
        case key
    }
    
    static func getTrailers(from trailerList: TrailerList) -> [Trailer]? {
        guard let trailer = trailerList.results else { return nil }
        return trailer
    }
}
