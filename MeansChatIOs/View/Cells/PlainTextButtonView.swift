//
//  PlainTextButtonView.swift
//  MeansChatIO
//
//  Created by apple on 27/11/24.
//

import SwiftUI

struct PlainTextButtonView: View {
    var title: String
    @State var action: (() -> Void)?
    
    var body: some View {
        Button(action: {
            action?()
        }, label: {
            Text(title)
                .foregroundStyle(Color(.SubTitleColor))
            
        })    }
}

#Preview {
    PlainTextButtonView(title: "Forget Password?")
}
