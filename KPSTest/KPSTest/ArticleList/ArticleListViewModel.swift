//
//  ArticleListViewModel.swift
//  KPSTest
//
//  Created by Horia Turica on 22.09.2021.
//

import Foundation
import UIKit
import Combine
import SwiftUI

let baseURL="https://newsapi.org/v2"
let topHeadlinesEndpoint="\(baseURL)/top-headlines"
let countryParam="country=us"
let apiKey="f71af7261c434b5d8be60816ed910d8b"
let apiKeyParam="apiKey=\(apiKey)"
let topHeadlinesFullAddress="\(topHeadlinesEndpoint)?\(countryParam)&\(apiKeyParam)"

class ArticlesListViewModel: ObservableObject {
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published private(set) var articlesList: ArticlesList = ArticlesList(status: "loading", totalResults: 0, articles: [])
    @Published var searchQuery: String = ""
    
    var articles: [Article] {
        if !searchQuery.isEmpty {
            return articlesList.articles.filter { article in
                guard let title = article.title else { return false }
                return title.lowercased().contains(searchQuery.lowercased())
            }
        }
        return articlesList.articles
    }
    
    func fetchArticles() {
        NetworkManager.getArticlesList()
            .receive(on: RunLoop.main)
            .sink { (result) in
                switch result {
                case .finished:
                    print("Success")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { articlesList in
                print(articlesList)
                self.articlesList = articlesList
            }
            .store(in: &subscriptions)
    }
}
