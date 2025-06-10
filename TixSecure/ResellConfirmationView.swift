import SwiftUI

struct ResellConfirmationView: View {
    @Environment(\.presentationMode) var mode

    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Button { mode.wrappedValue.dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primary)
                }
                Spacer()
            }
            .padding()

            Text("Ticket Listed!")
                .font(.title2)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("InfoBadge"))
                .cornerRadius(8)
                .padding(.horizontal)

            Button("Back to Home") {
                // Pop to root or dismiss
                mode.wrappedValue.dismiss()
            }
            .foregroundColor(.primary)

            Spacer()
        }
    }
}
