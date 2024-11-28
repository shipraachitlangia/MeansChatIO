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
                    isToPresentConnection.toggle()
                }
                .padding()
                
                DividerWithTextView(title: "Or Login with")
                    .padding()
                
                GoogleButtonView() {
                    
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
            RegisterView()
        })
        .fullScreenCover(isPresented: $isToPresentConnection, content: {
            ConnectionsView()
        })
    }
}

#Preview {
    LoginView()
}
