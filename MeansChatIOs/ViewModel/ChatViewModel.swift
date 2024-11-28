//
//  ChatViewModel.swift
//  MeansChatIO
//
//  Created by apple on 27/11/24.
//

import Foundation
import SwiftUI
import StreamChat

// Import StreamChat framework.
//import StreamChat
//
//// for sake of simplicity we are extending ChatClient and add a static var `shared`
//extension ChatClient {
//  static var shared: ChatClient!
//}

//// API key can be found on the dashboard: https://getstream.io/dashboard/
//let config = ChatClientConfig(apiKey: .init("{{ api_key }}"))
//let userID = "leia_organa"
//
//// Create an instance of ChatClient and share it using the singleton
//ChatClient.shared = ChatClient(config: config)
//
//// Option A: with expiring token
//// The `tokenProvider` closure will be called again when the token is expired
//ChatClient.shared.connectUser(
//  userInfo: .init(id: userID),
//  tokenProvider: { providerResult in
//    loadChatToken(completion: providerResult)
//  },
//  completion: { error in
//    if let error = error {
//      print("Connection failed with: \(error)")
//    } else {
//      // User successfully connected
//    }
//  }
//)
//// or alternatively, using the async-await method
//let connectedUser = try await ChatClient.shared.connectUser(
//  userInfo: .init(id: userID),
//  tokenProvider: { providerResult in
//    loadChatToken(completion: providerResult)
//  }
//)
//
//// An example of a token provider
//func loadChatToken(completion: @escaping (Result<Token, Error>) -> Void) {
//  NetworkingLayer.getChatToken() { token in
//    do {
//      let token = try Token(rawValue: token)
//      completion(.success(token))
//    } catch {
//      completion(.failure(error))
//    }
//  }
//}
//
//// Option B: with a non-expiring token
//// You can generate the token for this user from https://getstream.io/chat/docs/ios-swift/token_generator/?language=swift
//let token: Token = "{{ chat_user_token }}"
//
///// Connect the user using a closure based method
//ChatClient.shared.connectUser(
//  userInfo: .init(id: userID),
//  token: token
//) { error in
//  if let error = error {
//    print("Connection failed with: \(error)")
//  } else {
//    // User successfully connected
//  }
//}
//// or alternatively, using the async-await version
//let connectedUser = try await ChatClient.shared.connectUser(
//  userInfo: .init(id: userID),
//  token: token
//)


/*import StreamChat
import StreamChatUI
import StreamChatTestMockServer

class ChatViewModel: ObservableObject {
    private var client: ChatClient
    private var channel: ChatChannel?
    
    @Published var messages: [Message] = []
    @Published var unreadCount: Int = 0

    init() {
        // Initialize Chat Client with your Stream API Key
        client = ChatClient(config: .init(apiKeyString: "YOUR_API_KEY"))
    }

    func connect() {
        // Example: Connect user (you should implement user authentication)
        client.connectUser(
            userInfo: User(id: "user-id", name: "User Name", imageURL: nil),
            token: "user-token"
        ) { result in
            switch result {
            case .success:
                print("User connected")
                self.createChannel()
            case .failure(let error):
                print("Failed to connect user: \(error)")
            }
        }
    }

    func createChannel() {
        // Example: Create or join a channel
        channel = client.channel(type: .messaging, id: "general")
        
        channel?.watch { result in
            switch result {
            case .success(let channel):
                self.messages = channel.messages.map { $0.asModel() }
                self.unreadCount = channel.unreadCount // Get unread messages count
            case .failure(let error):
                print("Failed to watch channel: \(error)")
            }
        }
    }

    func sendMessage(_ text: String) {
        guard let channel = channel else { return }
        
        let message = Message(text: text)
        channel.sendMessage(message) { result in
            switch result {
            case .success(let message):
                self.messages.append(message)
            case .failure(let error):
                print("Failed to send message: \(error)")
            }
        }
    }
}
 */

//struct ChatView: View {
//    @StateObject private var viewModel = ChatViewModel()
//
//    var body: some View {
//        VStack {
//            HStack {
//                Text("Chat")
//                    .font(.title)
//                Spacer()
//                if viewModel.unreadCount > 0 {
//                    Text("\(viewModel.unreadCount)")
//                        .foregroundColor(.white)
//                        .padding(8)
//                        .background(Circle().fill(Color.red))
//                        .font(.caption)
//                }
//            }
//            .padding()
//
//            List(viewModel.messages, id: \.id) { message in
//                Text(message.text)
//            }
//
//            HStack {
//                TextField("Enter message...", text: $messageText)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                Button("Send") {
//                    viewModel.sendMessage(messageText)
//                    messageText = ""
//                }
//            }
//            .padding()
//        }
//        .onAppear {
//            viewModel.connect()
//        }
//    }
//
//    @State private var messageText = ""
//}
//
//struct ContentView: View {
//    var body: some View {
//        NavigationView {
//            ChatView()
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
