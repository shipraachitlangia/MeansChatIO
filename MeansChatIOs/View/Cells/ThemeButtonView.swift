//
//  ThemeButtonView.swift
//  MeansChatIO
//
//  Created by apple on 27/11/24.
//

import SwiftUI

struct ThemeButtonView: View {
    var title: String
    @State var action: (() -> Void)?
    var body: some View {
        Button(action: {
            action?()
        }, label: {
            HStack {
                Spacer()
                
                Text(title)
                    .font(.custom( "Fira Code" ,size: 20))
                    .foregroundStyle(Color(.ButtonTitleColor))
                    .padding()
                
                Spacer()

            }
        })
        .background(Color(.ThemeColor))
        .cornerRadius(30)   
    }
}

#Preview {
    ThemeButtonView(title: "Login")
}
