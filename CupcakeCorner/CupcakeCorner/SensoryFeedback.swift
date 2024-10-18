//
//  SensoryFeedback.swift
//  CupcakeCorner
//
//  Created by Brody on 10/18/24.
//

import SwiftUI

struct hapticView: View {
    @State private var alignmentTrigger = false
    @State private var decreaseTrigger = false
    @State private var errorTrigger = false
    @State private var impactTrigger = false
    @State private var increaseTrigger = false
    @State private var levelChangeTrigger = false
    @State private var pathCompleteTrigger = false
    @State private var selectionTrigger = false
    @State private var startTrigger = false
    @State private var stopTrigger = false
    @State private var successTrigger = false
    @State private var warningTrigger = false

    var body: some View {
        ScrollView {
            Text("TEST VIEW HAPTIC VIEW")
                .font(.headline)
                .padding()
            
            Button("TAP ME: alignment") {
                alignmentTrigger.toggle()
            }.sensoryFeedback(.alignment, trigger: alignmentTrigger)
            
            Button("TAP ME: decrease") {
                decreaseTrigger.toggle()
            }.sensoryFeedback(.decrease, trigger: decreaseTrigger)
            
            Button("TAP ME: error") {
                errorTrigger.toggle()
            }.sensoryFeedback(.error, trigger: errorTrigger)
            
            Button("TAP ME: impact") {
                impactTrigger.toggle()
            }.sensoryFeedback(.impact, trigger: impactTrigger)
            
            Button("TAP ME: increase") {
                increaseTrigger.toggle()
            }.sensoryFeedback(.increase, trigger: increaseTrigger)
            
            Button("TAP ME: levelChange") {
                levelChangeTrigger.toggle()
            }.sensoryFeedback(.levelChange, trigger: levelChangeTrigger)
            
            Button("TAP ME: pathComplete") {
                pathCompleteTrigger.toggle()
            }.sensoryFeedback(.pathComplete, trigger: pathCompleteTrigger)
            
            Button("TAP ME: selection") {
                selectionTrigger.toggle()
            }.sensoryFeedback(.selection, trigger: selectionTrigger)
            
            Button("TAP ME: start") {
                startTrigger.toggle()
            }.sensoryFeedback(.start, trigger: startTrigger)
            
            Button("TAP ME: stop") {
                stopTrigger.toggle()
            }.sensoryFeedback(.stop, trigger: stopTrigger)
            
            Button("TAP ME: success") {
                successTrigger.toggle()
            }.sensoryFeedback(.success, trigger: successTrigger)
            
            Button("TAP ME: warning") {
                warningTrigger.toggle()
            }.sensoryFeedback(.warning, trigger: warningTrigger)
        }
        .padding()
    }
}

#Preview {
    hapticView()
}

