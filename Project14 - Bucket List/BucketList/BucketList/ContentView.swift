//
//  ContentView.swift
//  BucketList
//
//  Created by Rinalds Domanovs on 02/04/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var isUnlocked = false

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showError = false

    var body: some View {
        ZStack {
            if isUnlocked {
                LoggedInView()
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .alert(isPresented: $showError) {
            Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, authenticationError) in

                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                        self.errorTitle = "Authentication Error"
                        self.errorMessage = "Failed to authenticate, please try again"
                        self.showError = true
                    }
                }
            }
        } else {
            // no biometrics
            self.errorTitle = "No Biometris"
            self.errorMessage = "Sorry, you don't have any biometris."
            self.showError = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
