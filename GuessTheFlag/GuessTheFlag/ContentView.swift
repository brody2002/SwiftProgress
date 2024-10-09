//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Brody on 10/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score: Int = 0
    @State private var rounds: Int = 0
    @State private var isGameOver: Bool = false
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(.gray),location:0.3),
                .init(color: Color(red: 0.2, green: 0.43, blue: 0.83),location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700).ignoresSafeArea()
            
            VStack(spacing: 30){
                VStack(){
                    Text("Tap the flag of")
                        .foregroundStyle(.white).bold()
                        .font(.system(size: 15))
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white).bold()
                        .font(.system(size: 35).weight(.semibold))
                        .padding(.bottom,30)

                }
                ForEach(0..<3) { number in
                    Button {
                        //flag was tapped
                        if rounds < 9{
                            flagTapped(number)

                        }
                        else{ //different alert}
                            gameOver()
                        }
                            
                    }label:{
                        Image(countries[number])
                            .clipShape(.capsule)
                            .shadow(radius: 3)
                    }
                }
                
                
                Text("Score: \(score)/\(rounds)")
                    .foregroundStyle(.white)
                    .font(.system(size: 30))
                    .padding(.top, 20)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 20))
            .environment(\.colorScheme, .dark)
            .padding()
            
            
            
            
                
                
            
            
            
        }.alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: {
                askQuestion()
                
                
            })
            
        }.alert("End of Test", isPresented: $isGameOver){
            Button("Restart?", action: {
            
                countries.shuffle()
                correctAnswer = Int.random(in: 0...2)
            })
            
        }
        
        
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        rounds += 1
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
        
    func gameOver() {
        isGameOver = true
        rounds = 0
        score = 0
        
    }
}

#Preview {
    ContentView()
}
