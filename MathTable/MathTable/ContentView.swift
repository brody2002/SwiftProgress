//
//  ContentView.swift
//  MathTable
//
//  Created by Brody on 10/13/24.
//

import SwiftUI

struct ContentView: View {

    @State private var num1: Int = Int.random(in: 0...12)
    @State private var num2: Int = Int.random(in: 0...12)
    @State private var userAnswer: String = ""
    @State private var feedback: String = ""
    @State private var showNextQuestionButton: Bool = false // Controls button visibility
    @FocusState private var isTextFieldFocused: Bool // Manages keyboard focus

    var correctAnswer: Int {
        num1 * num2
    }

    var body: some View {
        VStack {
            Spacer()

            // Display the question
            HStack {
                Text("\(num1)")
                    .frame(width: 120, height: 60)
                    .background(Color.blue)
                    .foregroundStyle(Color.white)
                    .cornerRadius(20)

                Text("X")
                    .padding()
                    .foregroundStyle(Color.blue)
                    .font(.system(size: 20).bold())

                Text("\(num2)")
                    .frame(width: 120, height: 60)
                    .background(Color.blue)
                    .foregroundStyle(Color.white)
                    .cornerRadius(20)
            }
            .padding()

            Spacer()

            // User input field
            TextField("Enter your answer", text: $userAnswer)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .frame(width: 120, height: 60)
                .background(Color.blue)
                .foregroundStyle(Color.white)
                .cornerRadius(20)
                .padding()
                .focused($isTextFieldFocused)

            // Submit button to check the answer
            Button("Submit") {
                checkAnswer()
                isTextFieldFocused = false // Dismiss the keyboard
            }
            .padding()
            .foregroundStyle(Color.white)
            .background(Color.orange)
            .cornerRadius(10)

            // Display feedback
            Text(feedback)
                .font(.headline)
                .padding()

            // "Next Question" button if the answer is correct
            if showNextQuestionButton {
                Button("Next Question") {
                    generateNewQuestion()
                    isTextFieldFocused = false // Ensure the keyboard is dismissed
                }
                .padding()
                .foregroundStyle(Color.white)
                .background(Color.green)
                .cornerRadius(10)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.1))
        .onTapGesture {
            isTextFieldFocused = false // Dismiss the keyboard on tap outside
        }
    }

    // Function to check if the user's answer is correct
    private func checkAnswer() {
        if let userValue = Int(userAnswer), userValue == correctAnswer {
            feedback = "Correct!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                showNextQuestionButton = true // Show the Next Question button
            }
        } else {
            feedback = "Try again!"
        }
    }

    // Function to generate a new question
    private func generateNewQuestion() {
        num1 = Int.random(in: 0...12)
        num2 = Int.random(in: 0...12)
        userAnswer = ""
        feedback = ""
        showNextQuestionButton = false // Hide the button for the next round
    }
}

#Preview {
    ContentView()
}

