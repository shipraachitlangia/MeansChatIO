//
//  GoogleButtonView.swift
//  MeansChatIOs
//
//  Created by apple on 27/11/24.
//

import SwiftUI

struct GoogleButtonView: View {
    @State var action:(()->Void)?
    var body: some View {
        Button(action: {
//                            signInHelper.signIn()
            action?()
        }) {
            HStack {
                Spacer()
                
                Image(.GoogleLogo)
                    .resizable()
                    .frame(width: 30, height: 30)
                
                Spacer()

            }
            .padding()
            .background(.white)
            .cornerRadius(30)
        }    }
}

#Preview {
    GoogleButtonView()
        .padding()
        .background(Color(.BackgroundColor))
}
