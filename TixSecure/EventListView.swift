import Foundation
import SwiftUI
import SwiftUICore

struct Event: Codable, Identifiable {
    let id: String
    let title: String
    let date: Date
    let price: Double
    let imageName: String
    let category: String
    
    var dateText: String {
        let df = DateFormatter()
        df.dateFormat = "d MMMM yyyy"
        return df.string(from: date)
    }
}

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var searchText: String = ""
    
    init() {
        // demo data
        events = [
            Event(id: "1", title: "Keshi 2025", date: Date(), price: 160, imageName: "keshi",
                category: "Concert"),
            Event(id: "2", title: "BLACKPINK World Tour", date: Calendar.current.date(byAdding: .day, value: 7, to: Date())!, price: 400, imageName: "blackpink", category: "Concert")
        ]
    }
    
    var filtered: [Event] {
        guard !searchText.isEmpty else { return events }
        return events.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    func fetchEvents() {
        // For real app, load from backend
    }
}

struct EventCardView: View {
    let event: Event
    
    var body: some View {
        VStack(spacing: 0) {
            // Poster Image
            Image(event.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 240)
                .clipped()
            
            // Info Panel
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(event.title)
                        .font(.title3).bold()
                        .foregroundColor(.white)
                    Spacer()
                    Text("$\(Int(event.price))")
                        .font(.title3).bold()
                        .foregroundColor(.white)
                }

                Text(event.category)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.white.opacity(0.25))
                    .foregroundColor(.white)
                    .clipShape(Capsule())

                HStack(spacing: 4) {
                    Image(systemName: "calendar")
                        .foregroundColor(.white)
                    Text(event.dateText)
                        .font(.caption)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(Color.badgePurple)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 4)
    }
}

//struct EventListView: View {
//    @EnvironmentObject var authVM: AuthViewModel
//    @StateObject private var vm = EventViewModel()
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                LazyVStack(spacing: 16) {
//                    ForEach(vm.events) { event in
//                        NavigationLink(
//                            destination: TicketSelectionView(event: event)
//                                .environmentObject(authVM)
//                        ) {
//                            EventCardView(event: event)
//                                .padding(.horizontal)
//                        }
//                    }
//                }
//                .padding(.vertical)
//            }
//            .navigationTitle("Events")
//            .onAppear { vm.fetchEvents() }
//        }
//    }
//}

struct EventListView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject private var vm = EventViewModel()

    var body: some View {
            NavigationView {
                VStack(spacing: 0) {
                    // Search Bar
                    HStack(spacing: 12) {
                      Image(systemName: "line.horizontal.3")
                      TextField("Explore Events", text: $vm.searchText)
                      Image(systemName: "magnifyingglass")
                    }
                    .padding(10)
                    .background(Color(.systemGray5))
                    .clipShape(Capsule())
                    .padding(.horizontal)
                    .padding(.top, 16)

                    // Cards
                    ScrollView {
                        LazyVStack(spacing: 24) {
                            ForEach(vm.filtered) { event in
                                NavigationLink {
                                    TicketSelectionView(event: event)
                                        .environmentObject(authVM)
                                } label: {
                                    EventCardView(event: event)
                                        .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                }
                .background(Color(.systemGroupedBackground).ignoresSafeArea())
                .navigationTitle("Events")
                .onAppear { vm.fetchEvents() }
            }
        }
    }

#Preview {
    EventListView()
        .environmentObject(AuthViewModel())
}
