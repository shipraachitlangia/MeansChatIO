//
//  ChatMessageView.swift
//  MeansChatIO
//
//  Created by apple on 27/11/24.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

struct ChatMessageView: View {
  //  @Binding var contacts: Contact
    @Environment(\.dismiss) var dismiss
    @State private var text: String = ""
    @State var channelInfoShown = false
    @State var messageDisplayInfo: MessageDisplayInfo?
    @StateObject var viewModel: ChatChannelViewModel
    
    init(channelId: ChannelId) {
        _viewModel = StateObject(wrappedValue: ChatChannelViewModel(
            channelController: InjectedValues[\.chatClient].channelController(
                for: channelId
            ))
        )
    }
    var body: some View {
        NavigationView {
            if let channel = viewModel.channel {
                VStack(spacing: 0) {
                    MessageListView(
                        factory: DefaultViewFactory.shared,
                        channel: channel,
                        messages: viewModel.messages,
                        messagesGroupingInfo: viewModel.messagesGroupingInfo,
                        scrolledId: $viewModel.scrolledId,
                        showScrollToLatestButton: $viewModel.showScrollToLatestButton,
                        quotedMessage: $viewModel.quotedMessage,
                        currentDateString: viewModel.currentDateString,
                        listId: viewModel.listId,
                        onMessageAppear: viewModel.handleMessageAppear(index:scrollDirection:),
                        onScrollToBottom: viewModel.scrollToLastMessage,
                        onLongPress: { displayInfo in
                            messageDisplayInfo = displayInfo
                            withAnimation {
                                viewModel.showReactionOverlay(for: AnyView(self))
                            }
                        }
                    )

                    MessageComposerView(
                        viewFactory: DefaultViewFactory.shared,
                        channelController: viewModel.channelController,
                        quotedMessage: $viewModel.quotedMessage,
                        editedMessage: $viewModel.editedMessage,
                        onMessageSent: viewModel.scrollToLastMessage
                    )
                }
                .overlay(
                    viewModel.reactionsShown ?
                        ReactionsOverlayView(
                            factory: DefaultViewFactory.shared,
                            channel: channel,
                            currentSnapshot: viewModel.currentSnapshot!,
                            messageDisplayInfo: messageDisplayInfo!,
                            onBackgroundTap: {
                                viewModel.reactionsShown = false
                                messageDisplayInfo = nil
                            }, onActionExecuted: { actionInfo in
                                viewModel.messageActionExecuted(actionInfo)
                                messageDisplayInfo = nil
                            }
                        )
                        .transition(.identity)
                        .edgesIgnoringSafeArea(.all)
                        : nil
                )
                .background(Color(.BackgroundColor))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    DefaultChatChannelHeader(
                        channel: channel,
                        headerImage: InjectedValues[\.utils].channelHeaderLoader.image(for: channel),
                        isActive: $channelInfoShown
                    )
                }
            }
        }
    }
    /*
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .padding(.leading)
                        .foregroundStyle(.white)
                }

                Image(.logo)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: .leading) {
                    Text("Abhidnya Sonawane")
                        .foregroundStyle(.white)
                        .font(.custom( "Fira Code" ,size: 16))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    
                    Text("last seen Oct 25, 2024")
                        .foregroundStyle(Color(.SubTitleColor) )
                }
                
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    
                }, label: {
                    Image(systemName: "paperclip")
                        .foregroundStyle(.white)
                })
                       
                TextField(
                    "",
                    text: $text,
                    prompt: Text("Send Message")
                        .foregroundColor(Color(.SubTitleColor))
                )
                .padding()
                .background(Color(.TextFieldBgColor))
                .cornerRadius(30)
                .shadow(color: Color(.SubTitleColor).opacity(0.1), radius: 5, x: 0, y: 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color(.SubTitleColor), lineWidth: 2)
                )
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "arrow.up")
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color(.SubTitleColor))
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                })
            }
            .padding()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color(.BackgroundColor))
    }
     */
}

//#Preview {
//    ChatMessageView()
//}
