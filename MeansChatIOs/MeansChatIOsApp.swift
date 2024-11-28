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


class AppDelegate: NSObject, UIApplicationDelegate {
    var chatClient: ChatClient?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
          FirebaseApp.configure()
        let client = ChatClient(config: .init(apiKey: .init("dajpa9ujkavr3qb5z394856stfruqvynkcdvtwwatysgqfc2haec8ch2nbx3tx7m")))
        chatClient = client
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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
