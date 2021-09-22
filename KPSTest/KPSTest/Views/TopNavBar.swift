//
//  TopNavBar.swift
//  KPSTest
//
//  Created by Horia Turica on 21.09.2021.
//
import SwiftUI

struct TopNavBar: View {
    
    @Binding var searchQuery: String
    @State var showSearch: Bool = false
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "text.justify")
                .foregroundColor(.black)
                .font(.system(size: 16))
            ZStack {
                VStack {
                    TextField("Search", text: $searchQuery)
                        .font(.custom("LibreFranklin-Light", size: 16))
                        .accentColor(Color("SecondaryColor"))
                    Divider()
                        .background(Color("SecondaryColor"))
                }
                .scaleEffect(showSearch ? 1 : 0)
                Text("Front page")
                    .font(.custom("Merriweather-BlackItalic", size: 24))
                    .scaleEffect(showSearch ? 0 : 1)
                    .multilineTextAlignment(.center)
            }
            Button {
                withAnimation {
                    showSearch.toggle()
                }
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
                    .font(.system(size: 16))
            }
        }
        .padding()
        .background(Color.white
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
        )
    }
}

struct TopNavBar_Previews: PreviewProvider {
    static var previews: some View {
        TopNavBar(searchQuery: .constant("lol"))
            .previewLayout(.sizeThatFits)
    }
}
