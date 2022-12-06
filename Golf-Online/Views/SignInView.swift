import Firebase
import SwiftUI

struct SignInView: View {
    @State var email = ""
    @State var password = ""

    @State var showAlert = false
    @State var errorDescription: String?

    @ObservedObject var cardListViewModel: CardListView.Model

    private func showError(error: Error) {
        errorDescription = error.localizedDescription
        showAlert = true
    }

    var body: some View {
        ZStack {
            SignInBackgroundView()

            VStack(alignment: .center, spacing: 100) {
                Text("Golf Online").font(.custom("BrushScriptMT", size: 70)).offset(y: 60).foregroundColor(.white).shadow(radius: 3).glowBorder(color: .black, lineWidth: 2)

                UserInfoForm(email: $email, password: $password)

                VStack {
                    Button {
                        AuthenticationService.signIn(email: email, password: password) { _, error in
                            if let error = error { showError(error: error) }
                        }
                    }
                label: { SignInButton() }

                    Button {
                        AuthenticationService.addNewUser(email: email, password: password) { authResult, error in
                            if let error = error {
                                showError(error: error)
                            } else {
                                if let userInfo = authResult?.additionalUserInfo,
                                   userInfo.isNewUser
                                {
                                    cardListViewModel.addStarterCards()
                                }
                            }
                        }
                    }
                label: { SignUpButton() }
                }
                .disabled(email.isEmpty || password.count < 6)
                Spacer()
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text(errorDescription ?? "🙀"))
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(cardListViewModel: CardListView.Model())
    }
}

// MARK: - User Info Form

struct UserInfoForm: View {
    @Binding var email: String
    @Binding var password: String

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Email")
                    .font(.system(.body, design: .rounded)).foregroundColor(.white).fontWeight(.bold).glowBorder(color: .black, lineWidth: 1)
                TextField("Enter your email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress).textInputAutocapitalization(.never)
            }.padding([.bottom], 20)

            VStack(alignment: .leading) {
                Text("Password")
                    .font(.system(.body, design: .rounded)).foregroundColor(.white).fontWeight(.bold).glowBorder(color: .black, lineWidth: 1)
                SecureField("Enter a password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.default).textInputAutocapitalization(.never)
            }
        }
    }
}

// MARK: - Button Views

struct SignUpButton: View {
    @Environment(\.isEnabled) var isEnabled

    var body: some View {
        HStack {
            Spacer()
            Text("Sign Up")
                .foregroundColor(isEnabled ? .white : .gray)
            Spacer()
        }
        .padding()
        .background(
            Color(.gray)
                .opacity(isEnabled ? 0.95 : 0.6)
        )
        .cornerRadius(15)
    }
}

struct SignInButton: View {
    @Environment(\.isEnabled) var isEnabled

    var body: some View {
        HStack {
            Spacer()
            Text("Sign In")
                .foregroundColor(isEnabled ? .white : .gray)
            Spacer()
        }
        .padding()
        .background(
            Color(.gray)
                .opacity(isEnabled ? 0.95 : 0.6)
        )
        .cornerRadius(15)
    }
}

// MARK: - Background View

struct SignInBackgroundView: View {
    var body: some View {
        ZStack {
            GeometryReader { _ in
                Image("golf-ball-green").resizable().scaledToFill().frame(width: 400, height: 900).padding([.leading], 200)
            }
        }
        .ignoresSafeArea()
    }
}
