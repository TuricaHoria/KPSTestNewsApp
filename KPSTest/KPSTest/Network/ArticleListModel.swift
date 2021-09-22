//
//  ArticleListModel.swift
//  KPSTest
//
//  Created by Horia Turica on 22.09.2021.
//

import Foundation

struct ArticlesListApiModel: Codable {
    var status: String
    var totalResults: UInt
    var articles: [ArticleApiModel]
}

struct ArticlesList {
    var status: String
    var totalResults: UInt
    var articles: [Article]
}
