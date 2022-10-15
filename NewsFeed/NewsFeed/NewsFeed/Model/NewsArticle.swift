//
//  NewsArticle.swift
//  NewsFeed
//
//  Created by Azharuddin 1 on 26/07/22.
//

import Foundation
struct NewsModel: Codable {
    let status: String
    let totalResults: Int
    let articles: [NewsArticle]
}

// MARK: - Article
struct NewsArticle: Codable {
    let uuid = UUID().uuidString
//    let source: Source
    let author, title, articleDescription: String?
    let url: String?
    let urlToImage: String?
//    let publishedAt: Date
//    let content: String

    enum CodingKeys: String, CodingKey {
        case author, title
        case articleDescription = "description"
        case url, urlToImage
//        case publishedAt, content
    }
}

// MARK: - Source
struct Source: Codable {
    let id, name: String
}
