//
//  ArticleModel.swift
//  KPSTest
//
//  Created by Horia Turica on 22.09.2021.
//


import Foundation
import UIKit

struct ArticleApiModel: Codable {
    var source: ArticleSource
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}

struct Article: Identifiable {
    let id = UUID()
    var source: ArticleSource
    var author: String?
    var title: String?
    var description: String?
    var url: URL?
    var image: UIImage?
    var publishedAt: Date?
    var content: String?
}

