//
//  NoDataView.swift
//  MeansChatIO
//
//  Created by apple on 27/11/24.
//

import SwiftUI

struct NoDataView: View {
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "message")
                .resizable()
                .scaledToFit()
                .rotationEffect(.degrees(-180))
                .frame(width: 100, height: 100)
                .scaleEffect(x: 1, y: -1)
                .foregroundStyle(.white)
            
            Text("No channels available")
                .font(.system(size: 20))
                .padding(2)
                .foregroundStyle(Color(.SubTitleColor))
            
            Spacer()

        }
    }
}

#Preview {
    NoDataView()
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color(.BackgroundColor))
}
