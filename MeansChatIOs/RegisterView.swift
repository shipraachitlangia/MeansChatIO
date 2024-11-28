//
//  RegisterView.swift
//  MeansChatIO
//
//  Created by apple on 27/11/24.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isToPresentConnection: Bool = false

    var body: some View {
        ScrollView() {
            VStack {
 
                HStack {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .padding()
                            .foregroundStyle(.white)
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color(.SubTitleColor), lineWidth: 1)
                            )
                    })
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                LogoView()
                    .padding(.bottom, 16)
                
                TwoVerticalTextView(title: "Register", subTitle: "Enter your Personal Information")
                    .padding()
                
                TextFieldWithTitleView(title: "Username", placeholder: "Enter your name", text: $username)
                    .padding(.bottom, 16)
                
                TextFieldWithTitleView(title: "Email", placeholder: "Enter your email", text: $email)
                    .padding(.bottom, 16)
                
                TextFieldWithTitleView(title: "Password", placeholder: "Enter your password", text: $password, isPasswordTextField: true)
                    .padding(.bottom, 16)
                
                TextFieldWithTitleView(title: "Confirm Password", placeholder: "Enter your confirm password", text: $confirmPassword, isPasswordTextField: true)
                
                ThemeButtonView(title: "Register") {
                    isToPresentConnection.toggle()
                }
                .padding()
                
                TextWithButtonView(textTitle: "Already have an account? ", buttonTitle: "Login") {
                    dismiss()
                }
                
                Spacer()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .scrollIndicators(.hidden)
        .background(Color(.BackgroundColor))
        .fullScreenCover(isPresented: $isToPresentConnection, content: {
            ConnectionsView()
        })

    }
}

#Preview {
    RegisterView()
}
