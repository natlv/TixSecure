import SwiftUICore
import SwiftUI
import _AuthenticationServices_SwiftUI

struct SignInView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
            VStack(spacing: 10) {
                // Logo and branding
                Image("TixSecure")
                    .resizable()
                    .scaledToFit()

                    Text("Sign in to TixSecure")
                        .font(.largeTitle).bold()
                        .padding(.top)
                    
                    // Google Sign In
                    Button(action: { authVM.signInDemo() }) {
                        HStack {
                            Image("google_logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                            Text("Sign in with Google")
                                .bold()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .cornerRadius(8)
                    }
                    
                    // Apple Sign In
                    Button(action: { authVM.signInDemo() }) {
                        HStack {
                            Image(systemName: "applelogo")
                                .frame(width: 24, height: 24)
                            Text("Sign in with Apple")
                                .bold()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    
                    // Divider with 'or'
                    HStack(alignment: .center) {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray.opacity(0.3))
                        Text("or")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray.opacity(0.3))
                    }
                    .padding(.horizontal)
                    
                    // Email & Password Fields
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Enter your email")
                            .font(.caption)
                        TextField("example@email.com", text: $email)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        
                        Text("Enter your password")
                            .font(.caption)
                        SecureField("••••••", text: $password)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    
                    
                // Sign Up / Sign In Buttons
                HStack(spacing: 16) {
                    Button("Sign up") {
                        // TODO: signup flow
                    }
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color("InfoBadge"))
                    .foregroundColor(.black)
                    .cornerRadius(8)

                    Button("Sign in") {
                        authVM.signInDemo()
                    }
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color("BadgePurple"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .background(Color.white)
        }
    }

#Preview {
    SignInView()
        .environmentObject(AuthViewModel())
}

