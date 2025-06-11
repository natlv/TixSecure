//import SwiftUI
//
//struct PurchaseSummaryView: View {
//    let event: Event
//    let option: TicketOption
//    
//    @Environment(\.presentationMode) var mode
//    
//    @State private var isShowingMyTickets = false
//    
//    let appUserWalletAddress = "0x7Ca11fA61B569322982813a69B25415DE27E533F"
//    
//    var body: some View {
//        VStack(spacing: 24) {
//            HStack { Button(action: { mode.wrappedValue.dismiss() }) {
//                    Image(systemName: "chevron.left").foregroundColor(.primary)
//                }
//                Spacer()
//            }
//            .padding()
//
//            VStack(spacing: 16) {
//                Image(systemName: "checkmark.circle.fill")
//                    .font(.system(size: 60))
//                    .foregroundColor(Color("BadgePurple"))
//                Text("Purchase Successful!").font(.title2)
//            }
//            .padding()
//            .background(Color("InfoBadge"))
//            .cornerRadius(12)
//            .padding(.horizontal)
//
//            // Ticket details card
//            VStack(alignment: .leading, spacing: 8) {
//                Text(option.name).font(.title)
//                Text("Quantity 1").font(.subheadline)
//                Text(option.date, style: .date).font(.caption)
//                Text("Seat A272").font(.caption)
//            }
//            .padding()
//            .background(Color.white)
//            .cornerRadius(12)
//            .shadow(radius: 3)
//            .padding(.horizontal)
//
//            Button("Back to Home") {
//                // demo dismiss to root
//                isShowingMyTickets = true
//            }
//            .foregroundColor(.primary)
//
//            Spacer()
//            
//            NavigationLink(
//                            destination: MyTicketsView(vm: TicketViewModel()),
//                            isActive: $isShowingMyTickets
//                        ) {
//                            EmptyView()
//                        }
//        }
//    }
//}

import SwiftUI

struct PurchaseSummaryView: View {
    let event: Event
    let option: TicketOption
    
    @Environment(\.presentationMode) var mode
    
    @State private var isShowingMyTickets = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                // Back button (remove as does not make sense to have)
//                HStack {
//                    Button(action: { mode.wrappedValue.dismiss() }) {
//                        Image(systemName: "chevron.left").foregroundColor(.primary)
//                    }
//                    Spacer()
//                }
//                .padding()

                // Confirmation message
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

                // Back to Home → triggers isShowingMyTickets
                Button("Back to Home") {
                    isShowingMyTickets = true
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)

                Spacer()
            }
            // New modern navigationDestination
            .navigationDestination(isPresented: $isShowingMyTickets) {
                MyTicketsView(vm: TicketViewModel())
            }
        }
    }
}
