import Firebase
import SwiftUI

@main
struct Golf_OnlineApp: App {
    // register app delegate for Firebase setup
    // @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var dataManager = DataManager()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
