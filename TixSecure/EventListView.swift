import Foundation
import SwiftUI
import SwiftUICore

struct Event: Codable, Identifiable {
    let id: String
    let title: String
    let date: Date
    let price: Double
//    let imageURL: URL?
//    private enum CodingKeys: String, CodingKey {
//        case id, title, date, price
//        case imageURL = "image_url"
//    }
}

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    init() {
        // demo data
        events = [
            Event(id: "1", title: "Rock Concert", date: Date(), price: 75),
            Event(id: "2", title: "Art Festival", date: Calendar.current.date(byAdding: .day, value: 7, to: Date())!, price: 50)
        ]
    }
    func fetchEvents() {
        // For real app, load from backend
    }
}

struct EventCardView: View {
    let event: Event
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .aspectRatio(1, contentMode: .fit)
                .overlay(Text("Image").foregroundColor(.white))
            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.headline)
                Text(event.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(String(format: "$%.0f", event.price))
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
            }
            .padding(8)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 3)
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
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea() // background fills full screen

                VStack(spacing: 0) {
                    // Manual title if you want it
                    Text("Events")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 16)

                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(vm.events) { event in
                                NavigationLink(
                                    destination: TicketSelectionView(event: event)
                                        .environmentObject(authVM)
                                ) {
                                    EventCardView(event: event)
                                        .frame(maxWidth: .infinity)
                                        .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.vertical)
                        .ignoresSafeArea(edges: .bottom) // bottom safe area
                    }
                }
            }
            .toolbar(.hidden, for: .navigationBar) // still hide nav bar
            .onAppear { vm.fetchEvents() }
        }
        .ignoresSafeArea()
    }
}
