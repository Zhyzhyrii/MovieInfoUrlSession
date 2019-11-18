//
//  RealmMovieManager.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 11/18/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

import RealmSwift

class RealmMovieManager {
    
    static func getMovies(status: Status) -> Results<DetailMovie> {
        let predicate: NSPredicate
        let realm = try! Realm()
        switch status {
        case .favourite:
            predicate = NSPredicate(format: "isFavourite = true")
        case .watchLater:
            predicate = NSPredicate(format: "isWatchedLater = true")
        }
        
        return realm.objects(DetailMovie.self).filter(predicate)
    }
    
    static func getMovies() -> Results<DetailMovie> {
        let realm = try! Realm()
        return realm.objects(DetailMovie.self)
    }
    
}
