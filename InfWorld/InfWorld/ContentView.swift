//
//  ContentView.swift
//  InfWorld
//
//  Created by Brody on 10/16/24.
//

import SwiftUI

struct ColorStringPair: Hashable {
    let text: String
    let color: Color
}

//Global
private var validWordsSet: Set<String> = []

func loadDictionary() {
    if let dictionaryURL = Bundle.main.url(forResource: "ValidWords", withExtension: "txt") {
        if let dictionaryWords = try? String(contentsOf: dictionaryURL) {
            let wordArray = dictionaryWords.components(separatedBy: "\n")
            validWordsSet = Set(wordArray.map { $0.uppercased() })
        }
    }
}


class GridViewClass: ObservableObject{
    
    var answerWord: String
    var inputWord: String = ""
    var attempt: Int = 1
    var inputList: [ColorStringPair] = []
    var showWinScreen: Bool = false
    var showLoseScreen: Bool = false
    
    var row1 = Array(repeating: ColorStringPair(text: "?", color: .gray), count: 5)
    var row2 = Array(repeating: ColorStringPair(text: "?", color: .gray), count: 5)
    var row3 = Array(repeating: ColorStringPair(text: "?", color: .gray), count: 5)
    var row4 = Array(repeating: ColorStringPair(text: "?", color: .gray), count: 5)
    var row5 = Array(repeating: ColorStringPair(text: "?", color: .gray), count: 5)
    
    
    init(){
        loadDictionary()
        print("set of words: \(validWordsSet)")
        self.answerWord = validWordsSet.randomElement()?.uppercased() ?? "power"
        print("ANSWERWORD: \(self.answerWord)")
    }
    
    func wordChecker(){
        inputList = []
        var inputColor: Color = Color.gray
        
        for (index, letter) in inputWord.enumerated() {
            print("comparing letter -> \(Array(answerWord)[index]) with -> \(Array(inputWord)[index]) ")
            //Check if letter is the same as the slot for the answer word {}
            if Array(answerWord)[index] == Array(inputWord)[index]{ inputColor = Color.green }
            else if answerWord.contains(Array(inputWord)[index]){ inputColor = Color.orange }
            else { inputColor = Color.gray }
            
            inputList.append(ColorStringPair(text: "\(letter)", color: inputColor))
            print("inputWord: \(inputWord) ==?  answerWord: \(answerWord)")
            if inputWord == answerWord {
                print("enter")
                showWinScreen = true
            }
        }
    }
    
    func swapRows(){
        
        objectWillChange.send()
        
        switch attempt {
            
        case 1:
            row1 = inputList
            print("row1 was swapped into \(row1)")
            attempt += 1
            
        case 2:
            row2 = inputList
            print("row2 was swapped into \(row2)")
            attempt += 1
            
        case 3:
            row3 = inputList
            print("row3 was swapped into \(row3)")
            attempt += 1
            
        case 4:
            row4 = inputList
            print("row4 was swapped into \(row4)")
            attempt += 1
            
        case 5:
            row5 = inputList
            print("row5 was swapped into \(row5)")
            if inputWord != answerWord {
                showLoseScreen = true
            }
                
        default:
            fatalError("Not on Valid Attempt Number! No Row Replaced")
        }
    }
    
    func resetGame() {
        withAnimation{
            
            row1 = Array(repeating: ColorStringPair(text: "?", color: .gray), count: 5)
            row2 = Array(repeating: ColorStringPair(text: "?", color: .gray), count: 5)
            row3 = Array(repeating: ColorStringPair(text: "?", color: .gray), count: 5)
            row4 = Array(repeating: ColorStringPair(text: "?", color: .gray), count: 5)
            row5 = Array(repeating: ColorStringPair(text: "?", color: .gray), count: 5)
            
            inputWord = ""
            attempt = 1
            showWinScreen = false
            
            answerWord = validWordsSet.randomElement()?.uppercased() ?? "POWER"
            print("New answer word: \(answerWord)")
            
            objectWillChange.send()
        }
            
    }
}

struct GridView: View {
    
    let rows: Int
    let columns: Int
    
    
    @ObservedObject var gridViewClass: GridViewClass

    var body: some View {
        VStack {
            // Row 1
            HStack {
                ForEach(gridViewClass.row1, id: \.self) { tuple in
                    WordSquare(inputChar: "\(tuple.text)",  inputColor: tuple.color, inputHeight: 1.0, inputWidth: 1.0)
                }
            }
            // Row 2
            HStack {
                ForEach(gridViewClass.row2, id: \.self) { tuple in
                    WordSquare(inputChar: "\(tuple.text)",  inputColor: tuple.color, inputHeight: 1.0, inputWidth: 1.0)
                }
            }
            // Row 3
            HStack {
                ForEach(gridViewClass.row3, id: \.self) { tuple in
                    WordSquare(inputChar: "\(tuple.text)",  inputColor: tuple.color, inputHeight: 1.0, inputWidth: 1.0)
                }
            }
            // Row 4
            HStack {
                ForEach(gridViewClass.row4, id: \.self) { tuple in
                    WordSquare(inputChar: "\(tuple.text)",  inputColor: tuple.color, inputHeight: 1.0, inputWidth: 1.0)
                }
            }
            // Row 5
            HStack {
                ForEach(gridViewClass.row5, id: \.self) { tuple in
                    WordSquare(inputChar: "\(tuple.text)",  inputColor: tuple.color, inputHeight: 1.0, inputWidth: 1.0)
                }
            }
        }
    }
}
struct WordSquare : View {
    @State var inputChar: String
    @State var inputColor: Color
    @State var inputHeight: CGFloat
    @State var inputWidth: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let sizeH = geometry.size.height * inputHeight
            let sizeW = geometry.size.width * inputWidth

            Text(inputChar)
                .frame(width: sizeW, height: sizeH)
                .foregroundStyle(.white)
                .font(.system(size: sizeH * 0.6))
                .background(inputColor)
                .cornerRadius(3)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                
        }
        //Keeps the squares within frame
        .aspectRatio(1, contentMode: .fit)
        
            
    }
}


struct HeaderBar: View{
    @Binding var restartID: UUID
    @Binding var showWinScreen: Bool
    @Binding var showLoseScreen: Bool
    @Binding var isKeyboardVisible: Bool
    @Binding var inputWord: String
    @Binding var answerWord: String
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    
    
    @ObservedObject var gridViewClass: GridViewClass
    
    var body: some View{
        ZStack{
            Color.blue.ignoresSafeArea()
            VStack{
                Spacer()
                if !isKeyboardVisible{
                    VStack{
                        Spacer(minLength: 40)
                        HStack{
                            Text("Brody Wordle")
                                .bold()
                                .foregroundStyle(Color.white)
                                .font(.largeTitle)
                        }
                        Spacer(minLength: 20)
                    }
                }
                
                HStack{
                    if !showWinScreen && !showLoseScreen{
                        TextField("Enter Word: ", text: $inputWord)
                            .textCase(.uppercase)
                            .multilineTextAlignment(.leading)
                            .textCase(.uppercase)
                            .padding(.horizontal)
                            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                                withAnimation {
                                    isKeyboardVisible = true
                                }
                            }
                            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                                withAnimation {
                                    isKeyboardVisible = false
                                }
                            }
                            .onChange(of: inputWord) { newValue in
                                    inputWord = newValue.uppercased()
                                }
                        Button("Enter: "){
                            inputGuess()
                            
                        }
                            .frame(width: 100, height: 20)
                            .padding()
                            .foregroundStyle(Color.blue)
                            .background(Color.white)
                            .cornerRadius(30)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                        
                            .alert(errorTitle, isPresented: $showingError) {
                                Button("OK") {}
                            } message: {
                                Text(errorMessage)
                            }
                            .allowsHitTesting(isKeyboardVisible ? false : true)
                            .opacity(isKeyboardVisible ? 0.0 : 1.0)
                        Spacer()
                        Spacer()
                    }
                    if showWinScreen || showLoseScreen{
                        Button("Restart: "){
                            gridViewClass.resetGame()
                            showWinScreen = false
                            showLoseScreen = false
                            
                            
                        }
                            .frame(width: 100, height: 20)
                            .padding()
                            .foregroundStyle(Color.blue)
                            .background(Color.white)
                            .cornerRadius(30)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                            
                    }
                    
                        
                }
                Spacer()
                
            }
        }
        .frame(width: .infinity, height: isKeyboardVisible ? 60 : 70)
        
            
    }
    
    
    
    
    func spellCheck(word: String) -> Bool {
        let wordLower = word.uppercased()
        
        if !validWordsSet.contains(wordLower){
            return false
        }
        print("wordlower: \(wordLower)")
        return true
    }
    
    func charCheck(word: String) ->Bool{
        if word.count == 5 {
            return true
        } else{
            return false
        }
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    
    
    func inputGuess() {
        // Updates word
        
        guard spellCheck(word: inputWord) else {
            wordError(title: "Word not recognized", message: "Word doesn't exist!")
            return
        }
        guard charCheck(word: inputWord) else{
            wordError(title: "Word not long enough", message: "The word must be 5 characters!")
            return
        }
        
        
        
        
        gridViewClass.inputWord = inputWord.uppercased()
        
        gridViewClass.wordChecker()
        gridViewClass.swapRows()
        inputWord = ""
    }
    
    
}

struct AppColors {
    static let keyboard = Color(red: 165/255, green: 165/255, blue: 165/255)
}

struct VisualKeyboard: View{
    private let keyboardRow1: [String] = ["Q","W","E","R","T","Y","U","I","O","P"]
    private let keyboardRow2: [String] = ["A","S","D","F","G","H","J","K","L"]
    private let keyboardRow3: [String] = ["Z","X","C","V","B","N","M"]

    let squareSize: CGFloat = 30 // Adjust this value as needed

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



struct ContentView: View {
    
    @State var attempt: Int = 1
    @State var inputWord: String = ""
    @State var isKeyboardVisible: Bool = false
    @StateObject var gridViewClass = GridViewClass()
    @State var answerWord: String = ""
    @State var showWinScreen: Bool = false
    @State var showLoseScreen:Bool = false
    
    @State private var restartID = UUID() 
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.white.ignoresSafeArea()
                VStack{
                    HeaderBar(restartID: $restartID, showWinScreen: $showWinScreen, showLoseScreen: $showLoseScreen, isKeyboardVisible: $isKeyboardVisible, inputWord: $inputWord, answerWord: $answerWord, gridViewClass: gridViewClass)
                    Spacer(minLength: 10)
                    .opacity(isKeyboardVisible ? 0.0 : 1.0)
                    GridView(rows: 5, columns: 5, gridViewClass: gridViewClass)
                        .padding(.horizontal)
                    Spacer()
                    VisualKeyboard()
                        .padding(.horizontal)
                    Spacer()
                        .frame(height: 20)
                    
                }
                if showWinScreen{
                    Text("YOU WON THE GAME!")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 50))
                        .frame(width: 350, height: 240)
                        .background(Color.blue)
                        .cornerRadius(30)
                        .bold()
                        .foregroundStyle(.white)
                        .padding()
                }
                if showLoseScreen{
                    Text("YOU LOST!\nThe Word was\n\(answerWord)")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 50))
                        .frame(width: 350, height: 240)
                        .background(Color.red)
                        .cornerRadius(30)
                        .bold()
                        .foregroundStyle(.white)
                        .padding()
                }
            }
            .onAppear{
                answerWord = gridViewClass.answerWord
                print("from contentView, answerWord: \(answerWord)")
            }
            .onChange(of: gridViewClass.showWinScreen) { showScreen in
                print("update in winscreeen from class object")
                withAnimation{
                    showWinScreen = showScreen
                }
                
            }
            .onChange(of: gridViewClass.showLoseScreen){ showScreen in
                withAnimation{
                    showLoseScreen = showScreen
                }
            }
            //restart game on change? i think...
            .id(restartID)
        }
    }
    
    
}



#Preview {

    ContentView()

}

