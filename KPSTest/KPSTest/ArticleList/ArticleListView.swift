//
//  ArticleListView.swift
//  KPSTest
//
//  Created by Horia Turica on 22.09.2021.
//

import SwiftUI

struct ArticlesListView: View {
    
    @StateObject private var articlesListViewModel = ArticlesListViewModel()
    @State private var showSmallHeader: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                if articlesListViewModel.articles.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "newspaper")
                            .font(.system(size: 24, weight: .bold))
                        ProgressView("Fetching articles...")
                            .foregroundColor(.black)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                } else {
                List(articlesListViewModel.articles.indices, id: \.self) { index in
                    let article = articlesListViewModel.articles[index]
                    ZStack {
                        NavigationLink(destination:
                                        ArticleView(article: article)
                        ) {
                            EmptyView()
                        }
                        .opacity(0.0)
                        .buttonStyle(PlainButtonStyle())
                        
                        if index == 0 {
                            FirstArticleRowView(article: article, didScroll: $showSmallHeader)
                        } else {
                            ArticleRowView(article: article)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .padding(.top, showSmallHeader ? 0 : 62)
                }
//                .padding(.top, 62)
                if showSmallHeader {
                    SmallHeader()
                } else {
                    TopNavBar(searchQuery: $articlesListViewModel.searchQuery)
                }
            }
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            
        }
        .onAppear(perform: {
            articlesListViewModel.fetchArticles()
        })
        
    }
}

struct ArticlesListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ArticlesListView()
            
            ArticlesListView()
                .colorScheme(.dark)
        }
    }
}
