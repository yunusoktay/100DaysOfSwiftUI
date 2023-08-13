//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by yunus oktay on 6.08.2023.
//

import SwiftUI


struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var roundNumber = 8
    @State private var roundSequence: Int = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
            
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(  .heavy))
                            .foregroundStyle(.secondary)
    
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(   .semibold))
                            
                    }
            
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                           
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
            
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle (cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented:     $showingScore) {
            if roundSequence == roundNumber {
                Button("Continue", action:  restartGame)
            } else {
                Button("Continue", action:  askQuestion)
            }
            
        } message: {
            Text("Your score is \(userScore)")
        }
            
    }
    
    func flagTapped(_ number: Int) {
        
        roundSequence += 1
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[correctAnswer])"
            userScore -= 1
        }
        
        if roundSequence == roundNumber {
            scoreTitle = "Game Over!"
        }

        showingScore = true
    }
    
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restartGame() {
        roundSequence = 0
        userScore = 0
        askQuestion()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
