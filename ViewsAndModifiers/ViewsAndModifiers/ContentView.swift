//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by yunus oktay on 14.08.2023.
//

import SwiftUI

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct ContentView: View {
   
    var body: some View {
        VStack {
            Color.blue
                .frame(width: 300, height: 300)
                .watermarked(with: "Hacking with Swift")
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
