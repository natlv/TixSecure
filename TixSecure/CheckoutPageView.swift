import SwiftUICore
import PassKit
import SwiftUI

struct CheckoutPageView: View {
    let event: Event
    let option: TicketOption
    @State private var method: PaymentMethod = .applePay
    @Environment(\.presentationMode) var mode
    
    @State private var isShowingPurchaseSummary = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                HStack {
                    Button(action: { mode.wrappedValue.dismiss() }) {
                        Image(systemName: "chevron.left").foregroundColor(.primary)
                    }
                    Spacer()
                }
                .padding()

                VStack(alignment: .leading, spacing: 8) {
                    Text(event.title).font(.headline).foregroundColor(.white)
                    Text(event.date, style: .date).font(.subheadline).foregroundColor(.white.opacity(0.8))
                    Text(String(format: "$%.0f", event.price)).font(.largeTitle).bold().foregroundColor(.white)
                }
                .padding()
                .background(Color("BadgePurple"))
                .cornerRadius(12)
                .padding(.horizontal)

                HStack(spacing: 16) {
                    PaymentMethodButton(method: .card, selected: method == .card) { method = .card }
                    PaymentMethodButton(method: .applePay, selected: method == .applePay) { method = .applePay }
                }
                .padding(.horizontal)

                Button("Confirm Payment") {
                    buyFromUser(ticketId: option.id, newOwnerAddress: "0x7Ca11fA61B569322982813a69B25415DE27E533F")
                    isShowingPurchaseSummary = true
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)

                Spacer()
            }
            // This is the modern replacement for NavigationLink(isActive:)
            .navigationDestination(isPresented: $isShowingPurchaseSummary) {
                PurchaseSummaryView(event: event, option: option)
            }
        }
    }
}

enum PaymentMethod { case card, applePay }

struct PaymentMethodButton: View {
    let method: PaymentMethod
    let selected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: method == .applePay ? "applelogo" : "creditcard")
                Text(method == .applePay ? "Apple Pay" : "Card")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(selected ? Color("BadgePurple") : Color.white)
            .foregroundColor(selected ? .white : .primary)
            .cornerRadius(8)
            .shadow(radius: selected ? 4 : 1)
        }
    }
}

func buyFromUser(ticketId: String, newOwnerAddress: String) {
    guard let url = URL(string: "http://192.168.0.125:3000/buy-from-user") else { return }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let body: [String: Any] = [
        "ticketId": ticketId,
        "newOwnerAddress": newOwnerAddress
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body)

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data,
           let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
           let newOwnerAddress = json["newOwnerAddress"] as? String {
            print("✅ Ticket ownership updated! New owner: \(newOwnerAddress)")
        } else {
            print("❌ Failed to update ticket ownership")
        }
    }.resume()
}
