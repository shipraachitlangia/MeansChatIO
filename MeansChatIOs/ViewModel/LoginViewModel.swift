//
//  LoginViewModel.swift
//  MeansChatIO
//
//  Created by apple on 27/11/24.
//

import Foundation
import FirebaseCore
import GoogleSignIn

class LoginViewModel {
/*
private func handleGoogleSignIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: UIApplication.shared.windows.first!.rootViewController!) { user, error in
            if let error = error {
                print("Google Sign-In failed: \(error)")
                return
            }

            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken else { return }

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: authentication.accessToken
            )

            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print("Firebase Sign-In failed: \(error)")
                    return
                }
                print("User signed in: \(result?.user.displayName ?? "No Name")")
            }
        }
    }
}
 */
     
}
