import SwiftUI
import AuthenticationServices
import PassKit

@main
struct TixSecureApp: App {
    @StateObject private var authVM = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            if authVM.isAuthenticated {
                MainTabView()
                    .environmentObject(authVM)
            } else {
                SignInView()
                    .environmentObject(authVM)
            }
        }
    }
}

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var user: User? = nil
    
    func signInDemo() {
        // For demo, just authenticate immediately
        self.user = User(id: "1", name: "Demo User", email: "demo@hack.com")
        self.isAuthenticated = true
    }
    
    func signInWithApple() {
        // Implement ASAuthorizationAppleIDProvider flow
    }
    
    func signOut() {
        isAuthenticated = false
        user = nil
    }
}

struct User: Codable, Identifiable {
    let id: String
    let name: String
    let email: String
}
