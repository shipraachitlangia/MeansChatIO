//
//  LoginView.swift
//  MeansChatIO
//
//  Created by apple on 26/11/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isToPresentRegister: Bool = false
    @State private var isToPresentConnection: Bool = false
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                
                LogoView()
                    .padding()
                
                TwoVerticalTextView(title: "Login", subTitle: "Login in continue using the app")
                    .padding()
                
                TextFieldWithTitleView(title: "Email", placeholder: "Enter your email", text: $email)
                    .padding(.bottom, 16)
                
                TextFieldWithTitleView(title: "Password", placeholder: "Enter your password", text: $password, isPasswordTextField: true)
                
                HStack {
                    Spacer()
                    
                    PlainTextButtonView(title: "Forget Password?") {
                        
                    }
                }
                .padding()
                
                ThemeButtonView(title: "Login") {
                    viewModel.signIn(email: email, password: password) { isSignIn in
                        if isSignIn {
                            isToPresentConnection.toggle()
                        }
                    }
                }
                .padding()
                
                DividerWithTextView(title: "Or Login with")
                    .padding()
                
                GoogleButtonView() {
                    viewModel.signInWithGoogle(){isSignIn in
                        if isSignIn {
                            isToPresentConnection.toggle()
                        }
                    }
                }
                .padding()
                            
                            
                TextWithButtonView(textTitle: "Don't have an account?", buttonTitle: "Register") {
                    isToPresentRegister.toggle()
                }
                
                Spacer()
                
            }
        }
        
        .frame(minWidth: 0, maxWidth: .infinity)
        .scrollIndicators(.hidden)
        .background(Color(.BackgroundColor))
        .fullScreenCover(isPresented: $isToPresentRegister, content: {
            RegisterView(isPresentRegister: $isToPresentRegister)
        })
        .fullScreenCover(isPresented: $isToPresentConnection, content: {
            ConnectionsView(isPresentRegister: $isToPresentRegister)
        })
        .alert(isPresented: $viewModel.isError) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage ?? "Something went wrong"),
                dismissButton: .default(Text("OK"))
            )
        }
        .environmentObject(viewModel)

    }
}

#Preview {
    LoginView()
}
