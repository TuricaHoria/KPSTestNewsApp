//
//  NetworkManager.swift
//  KPSTest
//
//  Created by Horia Turica on 22.09.2021.
//

import Foundation
import Combine
import UIKit

enum NetworkManager {
    private static let baseURL = "https://newsapi.org/v2"
    private static let topHeadlinesURL = "\(baseURL)/top-headlines"
    private static let country="us"
    private static let apiKey="f71af7261c434b5d8be60816ed910d8b"
    private static let endpointURL = URL(string: "\(topHeadlinesURL)?country=\(country)&apiKey=\(apiKey)")!
    
    private static let decoder = JSONDecoder()

    private static let articlesListQueue = DispatchQueue(label: "ArticlesList", qos: .default, attributes: .concurrent)
    private static let articlesImageQueue = DispatchQueue(label: "ArticlesImage", qos: .default, attributes: .concurrent)
    
    private static var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return df
    }
    
    private static func fetchArticlesListApiModel() -> AnyPublisher<ArticlesListApiModel, Error> {
        print(endpointURL)
      return URLSession.shared.dataTaskPublisher(for: endpointURL)
        .subscribe(on: articlesListQueue)
        .map(\.data)
        .decode(type: ArticlesListApiModel.self, decoder: decoder)
        .print("Rolo")
        .catch { _ in Empty() }
        .eraseToAnyPublisher()
    }
    
    
    
    private static func toArticlesList(articlesListApiModel: ArticlesListApiModel) -> AnyPublisher<ArticlesList, Error> {
            articlesListApiModel.articles.publisher
                .setFailureType(to: Error.self)
                .flatMap {
                    toArticle(articleApiModel: $0)
                }
                .collect()
                .map {articles in
                    ArticlesList(status: articlesListApiModel.status, totalResults: articlesListApiModel.totalResults, articles: articles)
                }
                .eraseToAnyPublisher()
        }
    
    private static func toArticle(articleApiModel: ArticleApiModel) -> AnyPublisher<Article, Error> {
        let publishedAt: Date? = dateFormatter.date(from: articleApiModel.publishedAt ?? "")
        let articleUrl: URL? = URL(string: articleApiModel.url ?? "")
        guard let imageAddress = articleApiModel.urlToImage, let url = URL(string: imageAddress) else {
            return Just(Article(source: articleApiModel.source, author: articleApiModel.author, title: articleApiModel.title, description: articleApiModel.description, url: articleUrl, image: nil, publishedAt: publishedAt, content: articleApiModel.content))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: articlesImageQueue)
            .mapError { $0 as Error }
            .map(\.data)
            .map { UIImage(data: $0) }
            .map { Article(source: articleApiModel.source, author: articleApiModel.author, title: articleApiModel.title, description: articleApiModel.description, url: articleUrl, image: $0, publishedAt: publishedAt, content: articleApiModel.content) }
            .eraseToAnyPublisher()
    }
    
    static func getArticlesList() -> AnyPublisher<ArticlesList, Error> {
        fetchArticlesListApiModel()
            .flatMap { articlesListApiModel -> AnyPublisher<ArticlesList, Error> in
                toArticlesList(articlesListApiModel: articlesListApiModel)
            }
            .eraseToAnyPublisher()
    }
}
