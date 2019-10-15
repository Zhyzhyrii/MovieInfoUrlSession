//
//  DetailMovieWorker.swift
//  MovieInfoUrlSession
//
//  Created by Игорь on 10/13/19.
//  Copyright (c) 2019 Igor Zhyzhyrii. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class DetailMovieWorker { //todo split into two workers? (network and work with lists)
    
    func getMovieDetailInfo(forMovieId movieId: Int, completionHandler: @escaping (DetailMovie?) -> Void) {
        APIMovieManager.fetchDetailMovie(movieId: movieId) { (detailMovie, result) in
            switch result {
            case .Success:
                guard let detailMovie = detailMovie else { return }
                completionHandler(detailMovie)
//                DispatchQueue.main.async {
//                    self.configureUI()
//                }
            case .Failure:
                print("Error")
                completionHandler(nil)
//                let alert = UIHelpers.showAlert(withTitle: "Ошибка",
//                                                message: "Данные не были получены из сети",
//                                                buttonTitle: "Вернуться назад",
//                                                handler: { action in
//                                                    self.navigationController?.popViewController(animated: true)
//                })
                
//                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
    
    func getTrailer(forMovieId movieId: Int, completionHandler: @escaping (String?) -> Void) {
        APIMovieManager.fetchMovieTrailer(movieId: movieId) { (trailers, result) in
            switch result {
            case .Success:
                guard let trailers = trailers, trailers.count > 0 else {
//                    let alert = UIHelpers.showAlert(withTitle: "Трейлер отсутствует",
//                                                    message: "Не удалось загрузить трейлер",
//                                                    buttonTitle: "Хорошо",
//                                                    handler: nil)
//                    self.present(alert, animated: true, completion: nil)
                    completionHandler(nil)
                    return }
                guard let videoCode = trailers[0].key else { return }
                completionHandler(videoCode)
//                DispatchQueue.main.async {
//                    guard let url = URL(string: "https://www.youtube.com/embed/\(videoCode)") else { return }
//                    self.trailerPlayer.load(URLRequest(url: url))
//                }
            case .Failure:
                print("Error")
                completionHandler(nil)
//                let alert = UIHelpers.showAlert(withTitle: "Ошибка",
//                                                message: "Данные не были получены из сети",
//                                                buttonTitle: "Вернуться назад",
//                                                handler: { action in                                        self.navigationController?.popViewController(animated: true)
//                })
//
//                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func getReviews(forMovieId movieId: Int, completionHandler: @escaping (ReviewList?) -> Void) {
        APIMovieManager.fetchMovieReviews(movieId: movieId) { (reviewlist, result) in
            switch result {
            case .Success:
                guard let reviewList = reviewlist else { return }
                completionHandler(reviewList)
            case .Failure:
                print("Error")
                completionHandler(nil)
//                let alert = UIHelpers.showAlert(withTitle: "Ошибка",
//                                                message: "Данные не были получены из сети",
//                                                buttonTitle: "Вернуться назад",
//                                                handler: { action in                                        self.navigationController?.popViewController(animated: true)
//                })
//
//                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func isPresent(movie: DetailMovie, in listType: ListType) -> Bool {
        return ListManager.listManager.isPresent(movie: movie, in: listType)
    }
    
    func setStatus(for movie: DetailMovie, in list: ListType, with status: Bool) {
        if !status {
            ListManager.listManager.remove(movie: movie, from: list)
        } else {
            ListManager.listManager.add(movie: movie, to: list)
        }
    }
    
}
