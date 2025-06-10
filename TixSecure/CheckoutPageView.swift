import SwiftUICore
import PassKit
import SwiftUI

//struct CheckoutView: View {
//    let event: Event
//    func makeUIViewController(context: Context) -> PKPaymentAuthorizationViewController {
//        let request = PKPaymentRequest()
//        request.merchantIdentifier = "your.merchant.id"
//        request.supportedNetworks = [.visa, .masterCard, .amex]
//        request.merchantCapabilities = .threeDSecure
//        request.countryCode = "US"
//        request.currencyCode = "USD"
//        request.paymentSummaryItems = [
//            PKPaymentSummaryItem(label: event.title, amount: NSDecimalNumber(value: event.price))
//        ]
//        guard let vc = PKPaymentAuthorizationViewController(paymentRequest: request) else {
//            fatalError("Unable to create Apple Pay controller")
//        }
//        vc.delegate = context.coordinator
//        return vc
//    }
//    func updateUIViewController(_ uiViewController: PKPaymentAuthorizationViewController, context: Context) {}
//    func makeCoordinator() -> Coordinator { Coordinator(self) }
//    class Coordinator: NSObject, PKPaymentAuthorizationViewControllerDelegate {
//        let parent: CheckoutView
//        init(_ parent: CheckoutView) { self.parent = parent }
//        func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController,
//                                                didAuthorizePayment payment: PKPayment,
//                                                handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
//            completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
//        }
//        func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
//            controller.dismiss(animated: true)
//        }
//    }
    
struct CheckoutPageView: View {
    let event: Event
    let option: TicketOption
    @State private var method: PaymentMethod = .applePay
    @Environment(\.presentationMode) var mode

    var body: some View {
        VStack(spacing: 24) {
            HStack { Button(action: { mode.wrappedValue.dismiss() }) {
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
                // demo action
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)

            Spacer()
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

