//
//  SmallHeader.swift
//  KPSTest
//
//  Created by Horia Turica on 21.09.2021.
//

import SwiftUI

struct CutSquare: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width = rect.width
            let height = rect.height
            
            path.addLines( [
                CGPoint(x: 0, y: 0),
                CGPoint(x: width * 0, y: height),
                CGPoint(x: width - 15, y: height),
                CGPoint(x: width, y: height - 15),
                CGPoint(x: width, y: height * 0),
            ])
            path.closeSubpath()
        }
    }
}

struct SmallHeader: View {
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Image(systemName: "text.justify")
                    .foregroundColor(.black)
                    .font(.system(size: 16))
                Spacer()
                Image("icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40, alignment: .center)
                Spacer()
            }
        }
        
        .frame(width: 100, height: 62, alignment: .center)
        .background(Color.white)
        .clipShape(CutSquare())
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
    }
}

struct SmallHeader_Previews: PreviewProvider {
    static var previews: some View {
        SmallHeader()
            .previewLayout(.sizeThatFits)
    }
}
