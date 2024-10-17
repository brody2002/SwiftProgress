//
//  testView.swift
//  InfWorld
//
//  Created by Brody on 10/16/24.
//

import SwiftUI

struct TestView: View{
    private let keyboardRow1: [String] = ["Q","W","E","R","T","Y","U","I","O","P"]
    private let keyboardRow2: [String] = ["A","S","D","F","G","H","J","K","L"]
    private let keyboardRow3: [String] = ["Z","X","C","V","B","N","M"]

    let squareSize: CGFloat = 34 // Adjust this value as needed

    var body: some View{
        VStack{
            HStack(spacing: 5){
                ForEach(keyboardRow1, id: \.self ) { char in
                    WordSquares(inputChar: char, inputColor: AppColors.keyboard, inputSize: squareSize)
                        .frame(width: squareSize, height: squareSize) // Set the fixed size here
                }
            }
            
            HStack{
                Spacer()
                    .frame(height: 100)
                ForEach(keyboardRow2, id: \.self ) { char in
                    WordSquares(inputChar: char, inputColor: AppColors.keyboard, inputSize: squareSize)
                        .frame(width: squareSize, height: squareSize)
                }
                Spacer()
                    .frame(height: 100)
            }
            HStack{
                Spacer(minLength: 50)
                ForEach(keyboardRow3, id: \.self ) { char in
                    WordSquares(inputChar: char, inputColor: AppColors.keyboard, inputSize: squareSize)
                        .frame(width: squareSize, height: squareSize)
                }
                Spacer(minLength: 50)
            }
        }.padding(.horizontal)
    }
}

struct WordSquares : View {
    @State var inputChar: String
    @State var inputColor: Color
    @State var inputSize: CGFloat
    
    var body: some View {
        Text(inputChar)
            .frame(width: inputSize, height: inputSize * 2.0) // Set frame size here
            .foregroundStyle(.white)
            .font(.system(size: inputSize * 0.6))
            .background(inputColor)
            .cornerRadius(3)
    }
}
#Preview {
    TestView()
        .padding(.horizontal)
}
