//
//  ConnectionView.swift
//  MeansChatIO
//
//  Created by apple on 27/11/24.
//

import SwiftUI

struct ConnectionView: View {
    var image: String
    var name: String
    var lastMessage: String
    var date: String
    
    var body: some View {
        VStack {
            HStack {
                Image(.logo)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: .leading) {
                    Text(name)
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    
                    HStack {
                        Text(lastMessage)
                            .foregroundStyle(Color(.SubTitleColor) )
                        
                        Spacer()
                        
                        Text(date)
                            .foregroundStyle(Color(.SubTitleColor) )
                    }
                }
                
                Spacer()
            }
            
            Divider()
                .background(Color(.SubTitleColor))
                .frame(height: 5)
        }    }
}

#Preview {
    ConnectionView(image: "", name: "Abhidnya Sonawane", lastMessage: "You: screenshot", date: "11:53 pm")
        .background(Color(.BackgroundColor))
}
