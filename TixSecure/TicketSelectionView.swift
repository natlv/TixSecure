import SwiftUI

struct TicketSelectionView: View {
    let event: Event
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.presentationMode) var mode
    @State private var selectedOption: TicketOption? = nil
    
    let options: [TicketOption] = [ // demo data
        .init(id: "1", name: "Bob Dover", price: 160, date: Date(), category: "Cat B"),
        .init(id: "2", name: "Catherine Fly", price: 170, date: Date(), category: "Cat C"),
        .init(id: "3", name: "Donovan Guy", price: 180, date: Date(), category: "Cat A"),
        .init(id: "4", name: "Elijah Hill", price: 180, date: Date(), category: "Cat B")
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(["All","Cat","Date","Price"], id: \.self) { filter in
                        Text(filter.lowercased())
                            .font(.caption)
                            .padding(6)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
            }
            
            Text(event.title).font(.title2).bold().padding(.horizontal)
            Text(event.date, style: .date)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(options) { opt in
                        Button {
                            selectedOption = opt
                        } label: {
                            TicketOptionCard(option: opt)
                        }
                    }
                }
                .padding()
            }
            Spacer()
        }
        .sheet(item: $selectedOption) { opt in CheckoutPageView(event: event, option: opt)
                .environmentObject(authVM)
            }
        }
    }
    
struct TicketOption: Identifiable {
    let id: String
    let name: String
    let price: Double
    let date: Date
    let category: String
}
    
struct TicketOptionCard: View {
    let option: TicketOption
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .aspectRatio(1, contentMode: .fit)
                .overlay(Text("Image").foregroundColor(.white))

            Text(option.name).font(.headline)
            Text(String(format: "$%.0f", option.price)).font(.subheadline)
            Text(option.category).font(.caption).foregroundColor(.secondary)
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}
