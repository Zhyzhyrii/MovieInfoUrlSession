//
//  GenresStorage.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 9/29/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

class GenresStorage {
    
    static let genresStorage = GenresStorage()
    
    var genresDictionary: [Int: String] = fetchGenres()
    
    func getGenreName(idGenre: Int) -> String {
        if let genreName = genresDictionary[idGenre] {
            return genreName
        } else {
            return ""
        }
    }
    
    private static func fetchGenres() -> [Int: String] {
        var genresDictionary = [Int: String]()
        APIMovieManager.fetchGenres { (genreJson, result) in
            switch result {
            case .Success:
                guard let genreJson = genreJson else { return }
                guard let genresArray = genreJson.genres else { return }
                genresDictionary = self.transformGenreArrayToDictionary(genresArray)
            case .Failure: break
            }
        }
        return genresDictionary
    }
    
    private static func transformGenreArrayToDictionary(_ genres: Array<Genre>) -> [Int: String] {
        var dic = [Int: String]()
        genres.forEach {
            if let id = $0.id, let genreName = $0.genreName {
                dic[id] = genreName
            }
        }
        return dic
    }
}
