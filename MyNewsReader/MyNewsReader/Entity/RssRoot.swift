//
//  RssRoot.swift
//  MyNewsReader
//
//  Created by Himanshu T on 14/4/21.
//

import Foundation

struct RssRoot : Codable {
    let status: String
    let feed: RSSFeed
    let items: [NewsItem]
}

struct RSSFeed : Codable {
    let url : URL
    let title: String
    let link: URL
    let author: String
    let description: String
    let image: URL
}
