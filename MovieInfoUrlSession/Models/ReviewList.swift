//
//  ReviewList.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 9/1/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

struct ReviewList: Decodable {
    let id: Int?
    let page: Int?
    let results: [Review]?
    
    enum CodingKeys: String, CodingKey {
        case id, page, results
    }
    
    func getReviewAsString() -> String? {
        guard let reviews = results, reviews.isEmpty == false else { return nil }
        var reviewsAsString = ""
        for index in reviews.indices {
            reviewsAsString += "\(index + 1). \(reviews[index].content)\n\n"
        }
        return reviewsAsString
    }
}
