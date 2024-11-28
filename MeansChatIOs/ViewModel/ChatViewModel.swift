//
//  ChatViewModel.swift
//  MeansChatIO
//
//  Created by apple on 27/11/24.
//

import Foundation
import SwiftUI
import StreamChat
import Combine

/*
 // for sake of simplicity we are extending ChatClient and add a static var `shared`
 class ChatViewModel {
 extension ChatClient {
 static var shared: ChatClient!
 }
 
 // API key can be found on the dashboard: https://getstream.io/dashboard/
 let config = ChatClientConfig(apiKey: .init("{{ api_key }}"))
 let userID = "leia_organa"
 
 // Create an instance of ChatClient and share it using the singleton
 ChatClient.shared = ChatClient(config: config)
 
 // Option A: with expiring token
 // The `tokenProvider` closure will be called again when the token is expired
 ChatClient.shared.connectUser(
 userInfo: .init(id: userID),
 tokenProvider: { providerResult in
 loadChatToken(completion: providerResult)
 },
 completion: { error in
 if let error = error {
 print("Connection failed with: \(error)")
 } else {
 // User successfully connected
 }
 }
 )
 // or alternatively, using the async-await method
 let connectedUser = try await ChatClient.shared.connectUser(
 userInfo: .init(id: userID),
 tokenProvider: { providerResult in
 loadChatToken(completion: providerResult)
 }
 )
 
 // An example of a token provider
 func loadChatToken(completion: @escaping (Result<Token, Error>) -> Void) {
 NetworkingLayer.getChatToken() { token in
 do {
 let token = try Token(rawValue: token)
 completion(.success(token))
 } catch {
 completion(.failure(error))
 }
 }
 }
 
 // Option B: with a non-expiring token
 // You can generate the token for this user from https://getstream.io/chat/docs/ios-swift/token_generator/?language=swift
 let token: Token = "{{ chat_user_token }}"
 
 /// Connect the user using a closure based method
 ChatClient.shared.connectUser(
 userInfo: .init(id: userID),
 token: token
 ) { error in
 if let error = error {
 print("Connection failed with: \(error)")
 } else {
 // User successfully connected
 }
 }
 // or alternatively, using the async-await version
 let connectedUser = try await ChatClient.shared.connectUser(
 userInfo: .init(id: userID),
 token: token
 )
 }
 /*
  import StreamChatTestMockServer
  
  // The ViewModel: Manages the data for the View
  class ChatViewModel: ObservableObject {
  @Published var messages: [Message] = []
  @Published var isAuthenticated = false
  @Published var errorMessage: String?
  
  private var chatClientManager: ChatClientManager
  private var channelController: ChannelController?
  
  private var cancellables = Set<AnyCancellable>()
  
  init(chatClientManager: ChatClientManager) {
  self.chatClientManager = chatClientManager
  }
  
  // Login user using ChatClientManager
  func loginUser(userID: String, token: String) {
  chatClientManager.loginUser(userID: userID, token: token) { [weak self] result in
  switch result {
  case .success:
  self?.isAuthenticated = true
  self?.loadMessages(channelID: "general") // Load channel messages after login
  case .failure(let error):
  self?.errorMessage = "Failed to login: \(error.localizedDescription)"
  }
  }
  }
  
  // Load messages from a channel
  func loadMessages(channelID: String) {
  channelController = chatClientManager.createChannelController(channelID: channelID)
  
  // Synchronize and fetch messages
  channelController?.synchronize { [weak self] result in
  switch result {
  case .success:
  self?.messages = self?.channelController?.messages ?? []
  case .failure(let error):
  self?.errorMessage = "Error loading messages: \(error.localizedDescription)"
  }
  }
  }
  
  // Send a message to the channel
  func sendMessage(_ text: String) {
  let message = Message(text: text)
  channelController?.createMessage(message) { [weak self] result in
  switch result {
  case .success(let message):
  self?.messages.append(message)
  case .failure(let error):
  self?.errorMessage = "Failed to send message: \(error.localizedDescription)"
  }
  }
  }
  }
  
  import StreamChat
  
  // The Model: Responsible for data operations
  class ChatClientManager {
  private(set) var chatClient: ChatClient
  
  init(apiKey: String) {
  self.chatClient = ChatClient(config: .init(apiKey: .init(apiKey)))
  }
  
  // Login user to GetStream
  func loginUser(userID: String, token: String, completion: @escaping (Result<Void, Error>) -> Void) {
  let user = User(id: userID, name: "John Doe", imageURL: nil)
  chatClient.connectUser(user, token: token) { result in
  switch result {
  case .success:
  completion(.success(()))
  case .failure(let error):
  completion(.failure(error))
  }
  }
  }
  
  // Create a channel controller for the chat
  func createChannelController(channelID: String) -> ChannelController {
  return chatClient.channelController(for: .channel(id: channelID))
  }
  }
  */
 */
