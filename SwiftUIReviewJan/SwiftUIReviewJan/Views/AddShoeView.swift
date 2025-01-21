//
//  AddShoeView.swift
//  SwiftUIReviewJan
//
//  Created by Brody on 1/21/25.
//

import SwiftUI
import SwiftData

struct AddShoeView: View {
    @State var shoeList: [Shoe]
    @Binding var showAddShoeSheet: Bool
    // -----------------------
    
    @Environment(\.modelContext) var modelContext

    @State var inputShoeName: String = ""
    @State var inputShoeTraction: String = ""
    @State var inputShoeCushion: String = ""
    @State var inputShoeStyle: String = ""
    
    @FocusState var textFieldFocus: textFieldFocusEnum?
    
    var canSubmitShoe: Bool {
        for shoe in shoeList{
            if shoe.name == inputShoeName{
                return false
            }
        }
        return !inputShoeName.isEmpty && !inputShoeStyle.isEmpty && !inputShoeTraction.isEmpty && !inputShoeCushion.isEmpty
    }
    
    var body: some View {
        ZStack{
                Form{
                    Text("Input Shoe View")
                        .font(.system(size: 34))
                    Section{
                        TextField("Input Shoe Name", text: $inputShoeName)
                        TextField("Input Shoe Traction", text: $inputShoeTraction)
                            .keyboardType(.numberPad)
                        TextField("Input Shoe Cushion", text: $inputShoeCushion)
                            .keyboardType(.numberPad)
                        TextField("Input Shoe Style", text: $inputShoeStyle)
                            .keyboardType(.numberPad)
                    }
                    Button(
                        action: {
                                addShoe()
                        },
                        label:{
                            Text("Submit Shoe")
                                .foregroundStyle(canSubmitShoe ? Color.blue: Color.gray.opacity(0.5))
                        }
                    )
                    .disabled(!canSubmitShoe)
                }
        }
    }
    func addShoe(){
        print("tapped")
        if canSubmitShoe{
            print("submutting shoe")
            modelContext.insert(Shoe(name: inputShoeName, traction: Int(inputShoeTraction)!, cushion: Int(inputShoeCushion)!, style: Int(inputShoeStyle)!))
            do {
                try modelContext.save()
                showAddShoeSheet = false
            }
            catch {print("Couldnt save shoe to SwiftData")}
        }
    }
}

#Preview {
    @Previewable @State var shoeList = [
        Shoe(name: "Kobe 8", traction: 8, cushion: 8, style: 9),
        Shoe(name: "Kd 7", traction: 9, cushion: 9, style: 10)
    ]
    
    AddShoeView(shoeList: shoeList, showAddShoeSheet: .constant(true))
        
}

