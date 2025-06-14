import SwiftUICore
import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @ObservedObject var ticketVM: TicketViewModel
    var body: some View {
        TabView {
            EventListView()
                .tabItem { Label("Home", systemImage: "house") }
            MyTicketsView(vm: ticketVM)
                .tabItem { Label("My Tickets", systemImage: "ticket") }
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person") }
        }
    }
}

