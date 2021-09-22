//
//  BackView.swift
//  KPSTest
//
//  Created by Horia Turica on 21.09.2021.
//

import SwiftUI

struct BackView: View {
    var action: () -> Void
    
    var body: some View {
        Group {
        Button {
            action()
        } label: {
            Image("baseline_arrow_back_black_36pt")
                .resizable()
                .scaledToFit()
                .padding()
                .frame(width: 60, height: 60, alignment: .center)
                
                .foregroundColor(.black)
        }
        }
            .background(Color.white)
            .clipShape(CutSquare())
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
    }
}

struct BackView_Previews: PreviewProvider {
    static var previews: some View {
        BackView {
            return
        }
    }
}
