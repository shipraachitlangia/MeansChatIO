//
//  TextWithButtonView.swift
//  MeansChatIO
//
//  Created by apple on 27/11/24.
//

import SwiftUI

struct TextWithButtonView: View {
    var textTitle: String
    var buttonTitle: String
    @State var action: (() -> Void)?
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(textTitle)
                .foregroundStyle(.white)
            
            Button(action: {
                action?()
            }, label: {
                Text(buttonTitle)
                    .foregroundStyle(Color(.ThemeColor))
            })
            
            Spacer()
            
        }
    }
}

#Preview {
    TextWithButtonView(textTitle: "Don't have an account?", buttonTitle: "Register")
}
