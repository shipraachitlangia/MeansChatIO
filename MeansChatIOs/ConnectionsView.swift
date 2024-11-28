//
//  ConnectionsView.swift
//  MeansChatIO
//
//  Created by apple on 27/11/24.
//

import SwiftUI

struct ConnectionsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isNoData: Bool = false
    @State private var isToPresentChat: Bool = false
    @State private var isToPresentContact: Bool = false

    var body: some View {
        VStack {
            HStack {
                Image(.Logo)
                    .resizable()
                    .frame(width: 50, height: 50)
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "square.and.arrow.down")
                        .resizable()
                        .rotationEffect(.degrees(-90))
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.white)

                    
                })
            }
            .padding()

            HStack {
                Text("Connections")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding()
            if isNoData {
                NoDataView()
            }
            else {
                List {
                    ForEach(1..<10) { indexCount in
                        ConnectionView(image: "", name: "Abhidnya Sonawane", lastMessage: "You: screenshot", date: "11:53 pm")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color(.BackgroundColor))
                        .onTapGesture {
                            isToPresentChat.toggle()
                        }
                    }
                }
                
                .listStyle(.plain)
                .background(Color(.BackgroundColor))
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    isToPresentContact.toggle()
                } label: {
                    VStack(alignment: .center) {
                        Spacer()
                        
                        Image(systemName: "plus")
                            .foregroundStyle(Color(.BackgroundColor))
                            .padding()
                        
                        Spacer()

                    }
                }
                .background(Color(.ThemeColor))
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            }
            .padding()
            
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(minHeight: 0, maxHeight: .infinity)
        .background(Color(.BackgroundColor))
        .fullScreenCover(isPresented: $isToPresentChat, content: {
            ChatMessageView()
        })
        .fullScreenCover(isPresented: $isToPresentContact, content: {
            ContactView()
        })
    }
}

#Preview {
    ConnectionsView()
}
