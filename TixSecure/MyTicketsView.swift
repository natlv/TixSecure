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

class TicketViewModel: NSObject, ObservableObject {
    @Published var tickets: [Ticket] = []
    @Published var showDemoNFCAlert: Bool = false
    private var ticketBeingCheckedIn: Ticket?
    
    override init() {
        // demo data
        tickets = [
            Ticket(
                id: "t1",
                event: Event(id: "e1", title: "Keshi 2025", date: Date(), price: 180, imageName: "keshi", category: "Concert"),
                seat: "A272",
                date: Date(),
                isCheckedIn: false
            ),
            Ticket(
                id: "t2",
                event: Event(id: "e2", title: "Requiem World Tour", date: Date().addingTimeInterval(86400*3), price: 200, imageName: "keshi", category: "Concert"),
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
    
    func completeDemoCheckIn(with data: String) {
        print("✅ Completing DEMO check-in with NFC data: \(data)")

        if let ticket = ticketBeingCheckedIn {
            if let index = tickets.firstIndex(where: { $0.id == ticket.id }) {
                tickets[index] = Ticket(
                    id: tickets[index].id,
                    event: tickets[index].event,
                    seat: tickets[index].seat,
                    date: tickets[index].date,
                    isCheckedIn: true
                )
                updateBackendCheckIn(ticketId: tickets[index].id)
                print("🎉 Ticket \(tickets[index].id) marked as checked in")
            }
        } else {
            // Fallback: just check in first unchecked ticket (demo mode)
            if let index = tickets.firstIndex(where: { !$0.isCheckedIn }) {
                tickets[index] = Ticket(
                    id: tickets[index].id,
                    event: tickets[index].event,
                    seat: tickets[index].seat,
                    date: tickets[index].date,
                    isCheckedIn: true
                )
                updateBackendCheckIn(ticketId: tickets[index].id)
                print("🎉 Ticket \(tickets[index].id) marked as checked in")
            } else {
                print("⚠️ All tickets already checked in")
            }
        }

        ticketBeingCheckedIn = nil
        showDemoNFCAlert = false
        
    }



    func checkIn(ticket: Ticket) {
        print("▶️ Armed check-in for ticket \(ticket.id)")
        ticketBeingCheckedIn = ticket
        showDemoNFCAlert = true
    }
    
    func updateBackendCheckIn(ticketId: String) {
        guard let url = URL(string: "http://192.168.0.125:3000/check-in") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "ticketId": ticketId
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let success = json["success"] as? Bool, success == true {
                print("✅ Backend check-in updated for ticketId \(ticketId)")
            } else {
                print("❌ Failed to update backend check-in for ticketId \(ticketId)")
            }
        }.resume()
    }

}


struct MyTicketsView: View {
    @ObservedObject var vm: TicketViewModel
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
        .alert(isPresented: $vm.showDemoNFCAlert) {
            Alert(
                    title: Text("Ready to Check In"),
                    message: Text("Hold Near Reader"),
                    dismissButton: .default(Text("OK"))
            )
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

