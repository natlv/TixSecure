import Foundation
import SwiftUI
import SwiftUICore

struct Ticket: Codable, Identifiable {
    let id: String
    let event: Event
    let seat: String
    let date: Date
    let isCheckedIn: Bool
}

class TicketViewModel: ObservableObject {
    @Published var tickets: [Ticket] = []
    
    init() {
        // demo data
        tickets = [
            Ticket(
                id: "t1",
                event: Event(id: "e1", title: "Keshi 2025", date: Date(), price: 180),
                seat: "A272",
                date: Date(),
                isCheckedIn: false
            ),
            Ticket(
                id: "t2",
                event: Event(id: "e2", title: "Requiem World Tour", date: Date().addingTimeInterval(86400*3), price: 200),
                seat: "B101",
                date: Date().addingTimeInterval(86400*3),
                isCheckedIn: true
            )
        ]
    }
    
    func fetchTickets() {
        // to implement
    }

    func resell(ticket: Ticket, price: Double) {
        // to implement
    }

    func checkIn(ticket: Ticket) {
        // to implement
    }
}

struct MyTicketsView: View {
    @StateObject private var vm = TicketViewModel()
    @State private var ticketToResell: Ticket?

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 24) {
                    ForEach(vm.tickets) { ticket in
                        TicketCardView(
                            ticket: ticket,
                            onCheckIn: { vm.checkIn(ticket: ticket) },
                            onResell: { ticketToResell = ticket }
                        )
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("My Tickets")
            .onAppear { vm.fetchTickets() }
        }
        .sheet(item: $ticketToResell) { ticket in
            ResellView(ticket: ticket)
        }
    }
}

struct TicketCardView: View {
    let ticket: Ticket
    let onCheckIn: () -> Void
    let onResell: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(ticket.event.title)
                    .font(.headline)
                Text(ticket.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Seat: \(ticket.seat)")
                    .font(.caption)
                Text("Quantity: 1")
                    .font(.caption)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 3)

            HStack {
                if ticket.isCheckedIn {
                    Text("Checked In")
                        .font(.subheadline)
                        .foregroundColor(.green)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(8)
                } else {
                    Button("Check In", action: onCheckIn)
                        .buttonStyle(.bordered)
                }

                Spacer()

                Button("Resell", action: onResell)
                    .buttonStyle(.borderedProminent)
            }
        }
    }
}
