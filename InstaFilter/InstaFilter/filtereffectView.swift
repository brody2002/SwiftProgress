//
//  filtereffectView.swift
//  InstaFilter
//
//  Created by Brody on 10/22/24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct filtereffectView: View {
    @State var image: Image?
    
    var body: some View {
        VStack{
            VStack {
                        image?
                            .resizable()
                            .scaledToFit()
                    }
                    .onAppear(perform: loadImage)
        }
    }
    
    func loadImage(){
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        
        currentFilter.inputImage = beginImage
        let amount = 1.0
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey) }
        
        
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
                
        let uiImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: uiImage)
        
    }
}

#Preview {
    filtereffectView()
}
