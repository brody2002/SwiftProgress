import SwiftUI

struct MainView: View {
    @State private var newWord: String = ""
    @State private var rootWord: String = ""
    @State private var usedWords: [String] = []
    @State private var possibleWords: [String] = []
    @State private var validWordsSet: Set<String> = [] // Load dictionary words during `onAppear`
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var showPossibleWords = false
    @State private var isKeyboardVisible: Bool = false
    @State private var isGiveUpPressed: Bool = false
    @State private var restartID = UUID() // Add this to track restarts

    var body: some View {
        NavigationStack {
            withAnimation{
                ZStack {
                    Color(red: 48/255, green: 48/255, blue: 48/255).ignoresSafeArea()
                    VStack {
                        Text("Word: \(rootWord)")
                            .bold()
                            .font(.system(size: 40))
                            .foregroundStyle(Color.white)
                        
                        List {
                            Section {
                                TextField("Enter your word: ", text: $newWord)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
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
                            }
                            
                            Section {
                                ForEach(usedWords, id: \.self) { word in
                                    HStack {
                                        Image(systemName: "\(word.count).circle")
                                        Text("\(word)")
                                    }
                                }
                            }
                            if showPossibleWords {
                                Section(header: Text("Possible Words")) {
                                    ForEach(possibleWords, id: \.self) { word in
                                        Text(word)
                                    }
                                }
                            }
                        }
                        .frame(maxHeight: 1000) // Set a maximum height for the list to prevent it from pushing other content down
                        .onSubmit {
                            addNewWord()
                        }
                        .onAppear {
                            loadDictionary() // Load dictionary words here
                            startGame()
                            possibleWords = calculatePossibleWords()
                        }
                        .alert(errorTitle, isPresented: $showingError) {
                            Button("OK") { }
                        } message: {
                            Text(errorMessage)
                        }
                        .cornerRadius(30)
                        
                        // Add the "Give up?" button below the list
                        if !isKeyboardVisible {
                            Button(action: {
                                withAnimation {
                                    if isGiveUpPressed {
                                        // Restart the view by updating the restartID
                                        isGiveUpPressed = false
                                        showPossibleWords = false
                                        restartID = UUID()
                                        
                                    } else {
                                        showPossibleWords = true
                                        isGiveUpPressed = true
                                    }
                                }
                            }) {
                                Text(isGiveUpPressed ? "Restart Game" : "Show Answers?")
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 40)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            .cornerRadius(30)
                            .padding(.top, 10)
                        }
                    }
                    .padding()
                    .id(restartID) // Add this to force re-render when restartID changes
                }
            }
            
        }
    }

    // Remaining functions stay the same
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }

        // Extra validation
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }

        withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
            usedWords.insert(answer, at: 0)
            newWord = ""
        }
    }

    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL, encoding: .utf8) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "random"
            }
        }
    }

    func calculatePossibleWords() -> [String] {
        var wordsList: [String] = []

        for word in validWordsSet {
            if word.count >= 3 && word.count <= rootWord.count {
                if canFormWord(from: rootWord, word: word) {
                    wordsList.append(word)
                }
            }
        }
        
        wordsList.sort()
        return wordsList
    }

    func canFormWord(from root: String, word: String) -> Bool {
        var tempRoot = root

        for letter in word {
            if let index = tempRoot.firstIndex(of: letter) {
                tempRoot.remove(at: index)
            } else {
                return false
            }
        }

        return true
    }

    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }

    func loadDictionary() {
        if let dictionaryURL = Bundle.main.url(forResource: "ValidWords", withExtension: "txt") {
            if let dictionaryWords = try? String(contentsOf: dictionaryURL) {
                let wordArray = dictionaryWords.components(separatedBy: "\n")
                validWordsSet = Set(wordArray.map { $0.lowercased() })
            }
        }
    }
}


    #Preview {
        MainView()
    }
