//
//  MissionIcon.swift
//  GPSwiftDemo
//
//  
//

import SwiftUI

struct MissionIcon: View {
    var url: String
    var width: CGFloat
    var height: CGFloat
    
    //Async image view with height and width parameter
    var body: some View {
        AsyncImage(url: URL(string: url), content: { image in image
                .resizable()
                .aspectRatio(contentMode: .fit)
        }, placeholder: {
            Image("space.placeholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
        }).frame(width: width, height: height)
    }
}
