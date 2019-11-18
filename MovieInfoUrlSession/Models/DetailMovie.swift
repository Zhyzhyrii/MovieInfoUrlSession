//
//  DetailMovie.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 9/1/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import RealmSwift
import Realm

class DetailMovie: Object, Decodable {
    
    // MARK: - REFACTOR perhaps not optionals, genres
    
    //fields from json
    var id = RealmOptional<Int>()
    @objc dynamic var title: String? = nil
    @objc dynamic var releaseDate: String? = nil
    var runTime = RealmOptional<Int>()
    var voteAverage = RealmOptional<Double>()
    @objc dynamic var overview: String? = nil
    @objc dynamic var posterPath: String? = nil
    var genres: [Genre]? = nil
    
    //custom fields
    @objc dynamic var isFavourite = false
    @objc dynamic var isWatchedLater = false
    
    enum CodingKeys: String, CodingKey {
        case title, id, overview
        case releaseDate = "release_date"
        case runTime = "runtime"
        case voteAverage = "vote_average"
        case genres = "genres"
        case posterPath = "poster_path"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: RealmOptional<Int>, title: String, releaseDate: String, runTime: RealmOptional<Int>, voteAverage: RealmOptional<Double>, overview: String, posterPath: String) {
        self.init()
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.runTime = runTime
        self.voteAverage = voteAverage
        self.overview = overview
        self.posterPath = posterPath
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(RealmOptional<Int>.self, forKey: .id)
        let title = try container.decode(String.self, forKey: .title)
        let releaseDate = try container.decode(String.self, forKey: .releaseDate)
        let runTime = try container.decode(RealmOptional<Int>.self, forKey: .runTime)
        let voteAverage = try container.decode(RealmOptional<Double>.self, forKey: .voteAverage)
        let overview = try container.decode(String.self, forKey: .overview)
        let posterPath = try container.decode(String.self, forKey: .posterPath)
        self.init(id: id, title: title, releaseDate: releaseDate, runTime: runTime, voteAverage: voteAverage, overview: overview, posterPath: posterPath)
    }
    
    
//    required init() {
//        super.init()
//    }
//
//    required init(value: Any, schema: RLMSchema) {
//        super.init(value: value, schema: schema)
//    }
//
//    required init(realm: RLMRealm, schema: RLMObjectSchema) {
//        super.init(realm: realm, schema: schema)
//    }
    
    func getGenresAsString() -> String? {
        guard let genres = genres else { return nil }
        var genresAsString = ""
        for index in genres.indices {
            guard let genreName = genres[index].genreName else { return nil }
            genresAsString += genreName.capitalized
            if index != genres.count - 1 {
                genresAsString += ", "
            }
        }
        return genresAsString
    }
}
