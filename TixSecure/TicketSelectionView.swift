import SwiftUI

struct FilterPill: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Text(title)
            .font(.caption)
            .foregroundColor(isSelected ? .white : .primary)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(isSelected ? Color("BadgePurple") : Color.gray.opacity(0.2))
            .cornerRadius(6)
            .onTapGesture(perform: action)
    }
}


struct TicketSelectionView: View {
    let event: Event
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.presentationMode) var mode
    
    @State private var selectedFilter: String = "All"
    private let filters = ["All", "Cat", "Date", "Price"]
    
    let options: [TicketOption] = [ // demo data
        .init(id: "avail-1", name: "Bob Dover", price: 160, date: Date(), category: "Cat B", imageName: "nft1"),
        .init(id: "avail-2", name: "Catherine Fly", price: 170, date: Date(), category: "Cat C", imageName: "nft2"),
        .init(id: "avail-3", name: "Donovan Guy", price: 180, date: Date(), category: "Cat A", imageName: "nft3"),
        .init(id: "avail-4", name: "Elijah Hill", price: 180, date: Date(), category: "Cat B", imageName: "nft4")
    ]
    
    private var sortedOptions: [TicketOption] {
        switch selectedFilter {
        case "Cat":
            return options.sorted { $0.category < $1.category }
        case "Date":
            return options.sorted { $0.date     < $1.date     }
        case "Price":
            return options.sorted { $0.price    < $1.price    }
        default:
            return options
        }
    }
    
    @State private var selectedOption: TicketOption? = nil
    
    var body: some View {
          VStack(spacing: 16) {
              // — Filters —
              ScrollView(.horizontal, showsIndicators: false) {
                  HStack(spacing: 8) {
                      ForEach(filters, id: \.self) { f in
                          FilterPill(
                              title: f,
                              isSelected: selectedFilter == f
                          ) {
                              selectedFilter = f
                          }
                      }
                  }
                  .padding(.horizontal)
              }

              // — Title + Date
              VStack(spacing: 4) {
                  Text(event.title)
                      .font(.title2).bold()
                  Text(event.date, style: .date)
                      .font(.subheadline)
                      .foregroundColor(.secondary)
              }
              .padding(.horizontal)

              // — Options Grid —
              ScrollView {
                  LazyVGrid(
                      columns: [ GridItem(.flexible()), GridItem(.flexible()) ],
                      spacing: 16
                  ) {
                      ForEach(sortedOptions) { opt in
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
          .sheet(item: $selectedOption) { opt in
              CheckoutPageView(event: event, option: opt)
                  .environmentObject(authVM)
          }
          .navigationTitle("Choose Ticket")
          .navigationBarTitleDisplayMode(.inline)
      }
  }


  struct TicketOptionCard: View {
      let option: TicketOption

      var body: some View {
          VStack(alignment: .leading, spacing: 6) {
              // ← real image
              Image(option.imageName)
                  .resizable()
                  .scaledToFill()
                  .frame(height: 120)
                  .clipped()
                  .cornerRadius(8)

              Text(option.name)
                  .font(.headline)
              Text("$\(Int(option.price))")
                  .font(.subheadline)
              Text(option.category)
                  .font(.caption)
                  .foregroundColor(.secondary)
          }
          .padding(8)
          .background(Color.white)
          .cornerRadius(12)
          .shadow(radius: 2)
      }
  }

  

struct TicketOption: Identifiable {
    let id: String
    let name: String
    let price: Double
    let date: Date
    let category: String
    let imageName: String
    
    var dateText: String {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df.string(from: date)
    }
}
    

