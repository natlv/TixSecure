import SwiftUI
import AuthenticationServices
import PassKit

@main
struct TixSecureApp: App {
    @StateObject private var authVM = AuthViewModel()
    @StateObject private var ticketVM = TicketViewModel()
    var body: some Scene {
        WindowGroup {
            Group {
                if authVM.isAuthenticated {
                    MainTabView(ticketVM: ticketVM)
                        .environmentObject(authVM)
                } else {
                    SignInView()
                        .environmentObject(authVM)
                }
            }
            .onOpenURL { url in
                            print("📲 Received URL: \(url)")
                            if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                               components.scheme == "tixsecure",
                               components.host == "scanresult",
                               let queryItem = components.queryItems?.first(where: { $0.name == "data" }),
                               let data = queryItem.value {
                                print("✅ NFC data received: \(data)")
                                ticketVM.completeDemoCheckIn(with: data)
                            }
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
