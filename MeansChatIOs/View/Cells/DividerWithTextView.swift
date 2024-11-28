//
//  DividerWithTextView.swift
//  MeansChatIO
//
//  Created by apple on 27/11/24.
//

import SwiftUI

struct DividerWithTextView: View {
    var title: String
    
    var body: some View {
        HStack {
            CustomDivider()
            
            Text(title)
                .foregroundStyle(Color(.white))

            CustomDivider()

        }
    }
}

struct CustomDivider: View {
    var body: some View {
        VStack {
            Divider()
                .background(Color(.white))
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 5)
        }
    }
}

#Preview {
    DividerWithTextView(title: "Or Login with")
        .padding()
        .background(Color(.BackgroundColor))
}
