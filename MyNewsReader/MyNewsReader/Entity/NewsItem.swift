//
//  NewsItem.swift
//  MyNewsReader
//
//  Created by Himanshu T on 14/4/21.
//

import Foundation

struct NewsItem : Codable {
    let title: String
    let pubDate: String
    let link: URL
    let guid: URL
    let author: String
    let thumbnail: URL
    let description: String
    let content: String
    let enclosure: Enclosure
    let categories: [String]
}

struct Enclosure : Codable {
    let link: URL
    let type: String
    let thumbnail: URL
}
