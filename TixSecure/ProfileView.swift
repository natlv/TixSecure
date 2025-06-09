import SwiftUICore
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authVM: AuthViewModel
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("Profile Page")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                VStack(spacing: 16) {
                    VStack(spacing: 8) {
                        Image("profile_picture")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))

                        if let user = authVM.user {
                            Text(user.name)
                                .font(.title3)
                                .foregroundColor(.primary)
                            Text(verbatim: user.email)
                                .font(.subheadline)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color("InfoBadge"))
                                .clipShape(Capsule())

                            Text("verified user")
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color("InfoBadge"))
                                .clipShape(Capsule())
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)

                    VStack(spacing: 12) {
                        ProfileButton(icon: "pencil", title: "Edit Profile") {
                            // action
                        }
                        ProfileButton(icon: "folder", title: "My Favourites") {}
                        ProfileButton(icon: "gearshape", title: "Settings") {}
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)

                    // Logout
                    Button(action: {
                        authVM.signOut()
                    }) {
                        Text("Logout")
                            .font(.footnote)
                            .foregroundColor(.primary)
                    }
                    .padding(.top, 10)
                }
                .padding()
                Spacer()
            }
        }
    }
}

struct ProfileButton: View {
    let icon: String
    let title: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.purple)
                Text(title)
                    .foregroundColor(.primary)
                    .font(.body)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
        }
    }
}

#Preview {
    ProfileView().environmentObject(AuthViewModel())
}
