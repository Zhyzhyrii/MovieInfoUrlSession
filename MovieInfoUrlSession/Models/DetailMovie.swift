//
//  DetailMovie.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 9/1/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import RealmSwift

class DetailMovie: Object, Decodable {
    
    //fields from json
    let id = RealmOptional<Int>()
    @objc dynamic var title: String?
    @objc dynamic var releaseDate: String?
    let runTime = RealmOptional<Int>()
    let voteAverage = RealmOptional<Double>()
    @objc dynamic var overview: String?
    @objc dynamic var posterPath: String?
    var genresList = List<Genre>()
    
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
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id.value = try container.decodeIfPresent(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        runTime.value = try container.decodeIfPresent(Int.self, forKey: .runTime)
        voteAverage.value = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        let genres = try container.decodeIfPresent([Genre].self, forKey: .genres) ?? [Genre()]
        genresList.append(objectsIn: genres)
    }
    
    func getGenresAsString() -> String? {
        guard genresList.isEmpty == false else { return nil }
        var genresAsString = ""
        for index in genresList.indices {
            guard let genreName = genresList[index].genreName else { return nil }
            genresAsString += genreName.capitalized
            if index != genresList.count - 1 {
                genresAsString += ", "
            }
        }
        return genresAsString
    }
}
