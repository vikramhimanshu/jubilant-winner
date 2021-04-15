//
//  WebService.swift
//  MyNewsReader
//
//  Created by Himanshu T on 15/4/21.
//

import Foundation

enum WebServiceError : Error {
    case jsonEndpoint
    case requestFailed(Error)
    case unknown
}

extension URLSession {
    
    func request(_ endpoint: XMLToJSONEndPoint, handler completionHandler: @escaping (Result<Data, WebServiceError>) -> Void) {
        guard let url = endpoint.url else {
            return completionHandler(.failure(WebServiceError.jsonEndpoint))
        }
        
        let task = self.dataTask(with: url) { data, response, error in
            if let err = error {
                completionHandler(.failure(.requestFailed(err)))
            }
            guard let reqData = data else {
                return completionHandler(.failure(.unknown))
            }
            completionHandler(.success(reqData))
        }
        task.resume()
    }
}


//This is a clean way to both manage multiple sources and multiple APIs from the same source.
fileprivate let abcRSSFeedUrlString = "http://www.abc.net.au/news/feed/51120/rss.xml"

//https://api.rss2json.com/v1/api.json?rss_url=http://www.abc.net.au/news/feed/51120/rss.xml
struct XMLToJSONEndPoint {
    let path: String = "/v1/api.json"
    let queryItems: [URLQueryItem]
}

extension XMLToJSONEndPoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.rss2json.com"
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}

extension XMLToJSONEndPoint {
    static func abcNewsFeed() -> XMLToJSONEndPoint {
        return XMLToJSONEndPoint(queryItems: [
            URLQueryItem(name: "rss_url", value: abcRSSFeedUrlString)
        ])
    }
}

