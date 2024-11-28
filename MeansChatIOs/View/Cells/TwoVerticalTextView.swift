//
//  TwoVerticalTextView.swift
//  MeansChatIO
//
//  Created by apple on 26/11/24.
//

import SwiftUI

struct TwoVerticalTextView: View {
    var title: String
    var subTitle: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.white))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                
                Text(subTitle)
                    .font(.system(size: 16))
                    .foregroundStyle(Color(.SubTitleColor))
            }
            Spacer()
        }
    }
}

#Preview {
    TwoVerticalTextView(title: "Login", subTitle: "Login in continue using the app")
        .background(Color(.BackgroundColor))
}
