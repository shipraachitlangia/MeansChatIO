//
//  ConnectionsView.swift
//  MeansChatIO
//
//  Created by apple on 27/11/24.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

struct ConnectionsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isNoData: Bool = false
    @State private var isToPresentChat: Bool = false
    @State private var isToPresentContact: Bool = false
    @EnvironmentObject var loginViewModel: LoginViewModel
    @StateObject private var viewModel: ChatChannelListViewModel
    @StateObject private var channelHeaderLoader = ChannelHeaderLoader()
   // @Binding var isPresentRegister: Bool

    public init(
        channelListController: ChatChannelListController? = nil
    ) {
        let channelListVM = ViewModelsFactory.makeChannelListViewModel(
            channelListController: channelListController,
            selectedChannelId: nil
        )
        _viewModel = StateObject(
            wrappedValue: channelListVM
        )
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(.Logo)
                        .resizable()
                        .frame(width: 50, height: 50)
                    
                    Spacer()
                    
                    Button(action: {
                        loginViewModel.signOut()
                        //  isPresentRegister.toggle()
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
                    ChannelList(
                        factory: DefaultViewFactory.shared,
                        channels: viewModel.channels,
                        selectedChannel: $viewModel.selectedChannel,
                        swipedChannelId: $viewModel.swipedChannelId,
                        onItemTap: { channel in
                            viewModel.selectedChannel = channel.channelSelectionInfo
                        },
                        onItemAppear: { index in
                            viewModel.checkForChannels(index: index)
                        },
                        channelDestination: DefaultViewFactory.shared.makeChannelDestination()
                    )
                    
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
            .navigationBarBackButtonHidden()
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(minHeight: 0, maxHeight: .infinity)
            .background(Color(.BackgroundColor))
            //        .fullScreenCover(isPresented: $isToPresentChat, content: {
            //            ChatMessageView()
            //        })
            .fullScreenCover(isPresented: $isToPresentContact, content: {
                ContactView()
            })
        }
    }
    class CustomViewFactory: ViewFactory {
        @Injected(\.chatClient) var chatClient: ChatClient
        
        static let shared = CustomViewFactory()
        
        func makeChannelDestination() -> (ChannelSelectionInfo) -> ChatMessageView {
            { channelInfo in
                ChatMessageView(channelId: channelInfo.channel.cid)
            }
        }
    }
}

//#Preview {
//    @State var isPresentRegister: Bool = true
//   // ConnectionsView(isPresentRegister: $isPresentRegister)
//}
