//
//  Review.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 9/1/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

struct Review: Decodable {
    let content: String
    
    static func getReviews(from reviewList: ReviewList) -> [Review]? {
        guard let reviews = reviewList.results else { return nil }
        return reviews
    }
}
