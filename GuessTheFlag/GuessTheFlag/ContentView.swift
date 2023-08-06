//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by yunus oktay on 6.08.2023.
//

import SwiftUI


struct ContentView: View {
    
    @State private var showingAlert = false
    
    var body: some View {
        Button("Show Alert") {
            showingAlert = true
        }
        .alert("Important message", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
            
        } message: {
            Text("Please read this.")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
