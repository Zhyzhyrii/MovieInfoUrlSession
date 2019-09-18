//
//  ListManager.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 9/12/19.
//  Copyright © 2019 Igor Zhyzhyrii. All rights reserved.
//

enum ListType {
    
    case favoriteList
    case watchLaterList
    
}

class ListManager {
    
    static let listManager = ListManager()
    
    private var favoriteMovies = [DetailMovie]()
    private var watchLaterMovies = [DetailMovie]()
    
    func add(movie: DetailMovie, to listType: ListType) {
        
        switch listType {
        case .favoriteList:
            favoriteMovies.append(movie)
        case .watchLaterList:
            watchLaterMovies.append(movie)
        }
    }
    
    func remove(movie: DetailMovie, from listType: ListType) {
        
        switch listType {
        case .favoriteList:
            if let index = favoriteMovies.firstIndex(of: movie) {
                favoriteMovies.remove(at: index)
            }
        case .watchLaterList:
            if let index = watchLaterMovies.firstIndex(of: movie) {
                watchLaterMovies.remove(at: index)
            }
        }
    }
    
    func getMovies(from listType: ListType) -> [DetailMovie] {
        switch listType {
        case .favoriteList:
            return favoriteMovies
        case .watchLaterList:
            return watchLaterMovies
        }
    }
    
    func isPresent(movie: DetailMovie, in listType: ListType) -> Bool {
        
        switch listType {
        case .favoriteList:
            return favoriteMovies.contains(movie) ? true : false
        case .watchLaterList:
            return watchLaterMovies.contains(movie) ? true : false
        }
        
    }
}
