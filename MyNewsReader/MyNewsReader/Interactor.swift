//
//  Interactor.swift
//  MyNewsReader
//
//  Created by Himanshu T on 14/4/21.
//

import Foundation

protocol FeedInteractor {
    func willNeedArticles()
    func didPullToRefresh()
}

class Interactor {
    
    var network: URLSession
    
    init() {
        network = URLSession.shared
    }
    
    func getArticles(handler completionHandler: @escaping (Result<[NewsItem], Error>) -> Void) {
        network.request(.abcNewsFeed()) { result in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let feed:RssRoot = try JSONDecoder().decode(RssRoot.self, from: data)
                    completionHandler(.success(feed.items))
                } catch let err {
                    completionHandler(.failure(err))
                }
            }
        }
    }
}
