import SwiftUICore
import SwiftUI
import _AuthenticationServices_SwiftUI

struct SignInView: View {
    @EnvironmentObject var authVM: AuthViewModel
    var body: some View {
        VStack(spacing: 1) {
            Text("Sign in to TixSecure").font(.largeTitle)
            
//            SignInWithAppleButton(
//                .signIn,
//                onRequest: { request in
//                    request.requestedScopes = [.fullName, .email]
//                },
//                onCompletion: { result in
//                    switch result {
//                    case .success(let authResults):
//                        // Handle credential
//                        authVM.signInWithApple()
//                    case .failure(let error):
//                        print("Authorization failed: \\(error)")
//                    }
//                }
//            )
//            .signInWithAppleButtonStyle(.black)
//            .frame(height: 50)
            
            // Fake “Apple Sign In”
            Button(action: { authVM.signInDemo() }) {
                HStack {
                    Image(systemName: "applelogo")
                    Text("Sign in with Apple")
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            
            Spacer()
        }

        .padding()
    }
}
