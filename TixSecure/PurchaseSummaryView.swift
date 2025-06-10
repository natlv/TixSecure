import SwiftUI

struct PurchaseSummaryView: View {
    let option: TicketOption
    @Environment(\.presentationMode) var mode
    var body: some View {
        VStack(spacing: 24) {
            HStack { Button(action: { mode.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left").foregroundColor(.primary)
                }
                Spacer()
            }
            .padding()

            VStack(spacing: 16) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(Color("BadgePurple"))
                Text("Purchase Successful!").font(.title2)
            }
            .padding()
            .background(Color("InfoBadge"))
            .cornerRadius(12)
            .padding(.horizontal)

            // Ticket details card
            VStack(alignment: .leading, spacing: 8) {
                Text(option.name).font(.title)
                Text("Quantity 1").font(.subheadline)
                Text(option.date, style: .date).font(.caption)
                Text("Seat A272").font(.caption)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 3)
            .padding(.horizontal)

            Button("Back to Home") {
                // demo dismiss to root
            }
            .foregroundColor(.primary)

            Spacer()
        }
    }
}
