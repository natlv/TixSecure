import SwiftUI

struct ResellView: View {
    let ticket: Ticket
    @State private var price: String = ""
    @Environment(\.presentationMode) var mode
    @State private var showConfirmation = false

    var body: some View {
        VStack(spacing: 16) {
            // Back button
            HStack {
                Button { mode.wrappedValue.dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primary)
                }
                Spacer()
            }
            .padding()

            // NFT Verification Banner
            Text("NFT Ticket Verified!")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("BadgePurple"))
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.horizontal)

            // Ticket card
            VStack(alignment: .leading, spacing: 8) {
                Text(ticket.event.title).font(.title2)
                Text(ticket.seat).font(.subheadline)
                Text("Date: \(ticket.date, style: .date)").font(.caption)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 3)
            .padding(.horizontal)

            // Price input
            Text("Price").font(.caption).frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            TextField("Enter price", text: $price)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)

            // Confirm Listing button
            Button("Confirm Listing") {
                showConfirmation = true
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)

            Spacer()
        }
        .sheet(isPresented: $showConfirmation) {
            ResellConfirmationView()
        }
    }
}
