//
//  LoginView.swift
//  MeansChatIO
//
//  Created by apple on 26/11/24.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            HStack { Spacer()}
            VStack {
                Image(.Logo)
                    .resizable()
                    .frame(width: 100, height:  100)
            }
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .overlay(
                Circle()
                    .stroke(Color(.ThemeColor), lineWidth: 1) // Adds a circular border
            )
            Spacer()
            
        }
        .background(Color(.BackgroundColor))
    }
}

#Preview {
    LoginView()
}
