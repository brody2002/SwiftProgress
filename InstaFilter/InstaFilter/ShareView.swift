//
//  ShareView.swift
//  InstaFilter
//
//  Created by Brody on 10/22/24.
//


import StoreKit
import SwiftUI

struct ShareView: View {
    @Environment(\.requestReview) var requestReview
    let example = Image(.example)
    var body: some View {
        example
        ShareLink(item: example, preview: SharePreview("Doggo", image: example)){
            Label("Click to share", systemImage: "globe")
        }
        Spacer().frame(height:100)
        Button("Leave Review?"){
            requestReview()
        }
    }
}

#Preview {
    ShareView()
}
