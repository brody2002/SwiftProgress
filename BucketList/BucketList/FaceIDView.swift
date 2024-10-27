//
//  FaceIDView.swift
//  BucketList
//
//  Created by Brody on 10/23/24.
//
import LocalAuthentication
import SwiftUI

struct FaceIDView: View {
    
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
                    
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    
    
    func authenticate() {
        // LA -> Local Authentication
        let context = LAContext()
        // NS -> NeXStep a library made in Objective-C from Apple
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
}

#Preview {
    FaceIDView()
}
