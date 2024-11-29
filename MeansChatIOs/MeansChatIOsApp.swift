//
//  MeansChatIOsApp.swift
//  MeansChatIOs
//
//  Created by apple on 27/11/24.
//
import SwiftUI
import FirebaseCore
import GoogleSignIn
import StreamChat
import StreamChatSwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
          FirebaseApp.configure()
        return true
    }
    
    func application(
        _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
       return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct MeansChatIOsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var chatClient: ChatClient = {
        //For the tutorial we use a hard coded api key and application group identifier
        var config = ChatClientConfig(apiKey: .init("8br4watad788"))
        config.isLocalStorageEnabled = true
        config.applicationGroupIdentifier = "group.io.getstream.iOS.ChatDemoAppSwiftUI"

        // The resulting config is passed into a new `ChatClient` instance.
        let client = ChatClient(config: config)
        return client
    }()
    
    @State var streamChat: StreamChat?
    
    init() {
        var colors = ColorPalette()
        let streamBlue = UIColor(red: 215.0 / 255.0, green: 254.0 / 255.0, blue: 98.0 / 255.0, alpha: 1)
        colors.messageCurrentUserBackground = [streamBlue]
        colors.messageCurrentUserTextColor = .black
        colors.background = UIColor(red: 39.0 / 255.0, green: 39.0 / 255.0, blue: 39.0 / 255.0, alpha: 1)
        colors.text = .white
                
        let images = Images()
        images.reactionLoveBig = UIImage(systemName: "heart.fill")!
        
        let channelNamer: ChatChannelNamer = { channel, currentUserId in
            "\(channel.name ?? "no name")"
        }
        
        let appearance = Appearance(colors: colors, images: images)
        let utils = Utils(channelNamer: channelNamer)

        streamChat = StreamChat(chatClient: chatClient, appearance: appearance, utils: utils)
        connectUser()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    private func connectUser() {
        // This is a hardcoded token valid on Stream's tutorial environment.
        let token = try! Token(rawValue: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoibHVrZV9za3l3YWxrZXIifQ.kFSLHRB5X62t0Zlc7nwczWUfsQMwfkpylC6jCUZ6Mc0")
        
        // Call `connectUser` on our SDK to get started.
        chatClient.connectUser(
            userInfo: .init(
                id: "luke_skywalker",
                name: "Luke Skywalker",
                imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/2/20/LukeTLJ.jpg")!
            ),
            token: token
        ) { error in
            if let error = error {
                // Some very basic error handling only logging the error.
                log.error("connecting the user failed \(error)")
                return
            }
        }
    }
}
