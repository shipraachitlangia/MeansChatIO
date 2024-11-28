//
//  TextFieldWithTitleView.swift
//  MeansChatIO
//
//  Created by apple on 26/11/24.
//

import SwiftUI

struct TextFieldWithTitleView: View {
    var title: String
    var placeholder: String
    @Binding var text: String
    var isPasswordTextField: Bool = false
    @State private var isPasswordVisible: Bool = true
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundStyle(Color(.TextFieldTitleColor))
            HStack {
                if isPasswordTextField && isPasswordVisible {
                    SecureField(
                        "",
                        text: $text,
                        prompt: Text(placeholder)
                            .foregroundColor(Color(.SubTitleColor))
                    )
                }
                else {
                    TextField(
                        "",
                        text: $text,
                        prompt: Text(placeholder)
                            .foregroundColor(Color(.SubTitleColor))
                    )
                }
                
                if isPasswordTextField {
                    Button(action: {
                        isPasswordVisible.toggle()
                    }, label: {
                       Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundStyle(Color(.SubTitleColor))
                    })
                }
                
            }
            .padding()
            .background(Color(.TextFieldBgColor))
            .cornerRadius(30)
            .shadow(color: Color(.SubTitleColor).opacity(0.1), radius: 5, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color(.SubTitleColor), lineWidth: 2)
            )
        }
        .padding(.horizontal, 20)  
    }
}

//#Preview {
//    @State var text: String = ""
//
//    TextFieldWithTitleView(title: "Email", placeholder: "Enter your email", text: $text)
//        .background(Color(.BackgroundColor))
//
//}
