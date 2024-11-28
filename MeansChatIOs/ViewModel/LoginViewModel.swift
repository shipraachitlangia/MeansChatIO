//
//  LoginViewModel.swift
//  MeansChatIO
//
//  Created by apple on 27/11/24.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn


class LoginViewModel: ObservableObject {
    @Published var user: User? // The currently authenticated user
    @Published var isAuthenticated = false // Track authentication status
    @Published var isError = false
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published private var isGoogleSignIn = false
    
    init() {
        self.user = Auth.auth().currentUser
        self.isAuthenticated = self.user != nil
    }
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            self?.isLoading = false
            if let error = error {
                self?.errorMessage = error.localizedDescription
                self?.isError = true
                return
            }
            self?.user = result?.user
            self?.isAuthenticated = true
            self?.isGoogleSignIn = false
            completion(self?.isAuthenticated ?? false)
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Bool) -> Void) {
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            self?.isLoading = false
            if let error = error {
                
                self?.errorMessage = error.localizedDescription
                self?.isError = true
                
                return
            }
            self?.user = result?.user
            self?.isAuthenticated = true
            self?.isGoogleSignIn = false
            completion(self?.isAuthenticated ?? false)
            
        }
    }
    
    private func signOutWithAuth() {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.isAuthenticated = false
            self.isError = false
            self.isLoading = false
        } catch {
            self.isError = true
            self.isLoading = false
            self.errorMessage = error.localizedDescription
        }
    }
    
    func handleAuthError(_ error: NSError) -> String {
        if let errorCode = AuthErrorCode(rawValue: error.code) {
            switch errorCode {
            case .invalidEmail:
                return "Invalid email address."
            case .wrongPassword:
                return "Incorrect password."
            case .emailAlreadyInUse:
                return "This email is already in use."
            case .weakPassword:
                return "Your password is too weak."
            default:
                return "Authentication error: \(error.localizedDescription)"
            }
        }
        return "Unknown error occurred."
    }
    
    func signInWithGoogle(completion: @escaping (Bool) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("Missing client ID.")
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        isLoading = true
        
        // Use a UIViewController to present the Google Sign-In screen
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = scene.windows.first(where: { $0.isKeyWindow })?.rootViewController  {
            
            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }
                
                guard let user = result?.user,
                      let idToken = user.idToken?.tokenString else {
                    self?.errorMessage = "Google Sign-In failed."
                    return
                }
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                               accessToken: user.accessToken.tokenString)
                
                // Sign in to Firebase with Google credential
                Auth.auth().signIn(with: credential) { result, error in
                    if let error = error {
                        self?.errorMessage = error.localizedDescription
                        return
                    }
                    
                    self?.user = result?.user
                    self?.isAuthenticated = true
                    self?.isGoogleSignIn = true
                    DispatchQueue.main.async {
                        completion(self?.isAuthenticated ?? false)
                    }
                }
            }
        }
    }
    
    private func signOutWithGoogle() {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            self.user = nil
            self.isAuthenticated = false
            self.isError = false
            self.isLoading = false
        } catch {
            self.isError = true
            self.isLoading = false
            self.errorMessage = error.localizedDescription
        }
    }
    
    func signOut() {
        guard isGoogleSignIn else {
            signOutWithAuth()
            return
        }
        signOutWithGoogle()
        
    }
}

     

