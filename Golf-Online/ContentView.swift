import Firebase
import SwiftUI

struct ContentView: View {
    @State var showingBottomSheet = false
    var body: some View {
        ZStack {
            Color.black

            Image("golf-ball-green").resizable().scaledToFill().frame(width: 400, height: 900).padding([.leading], 200)
            Text("Golf Online").font(.custom("BrushScriptMT", size: 70)).offset(y: -250).foregroundColor(.white).shadow(radius: 3).glowBorder(color: .black, lineWidth: 2)
            Button("Start Golfing") {
                showingBottomSheet.toggle()
            }.buttonStyle(.borderedProminent).offset(y: 25).fontWeight(.bold).font(.system(.body).lowercaseSmallCaps())
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showingBottomSheet) {
            BottomSheetView()
                .presentationDetents([.height(500)])
                .presentationDragIndicator(.hidden)
                .opacity(0.9)
        }
    }
}

struct BottomSheetView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isUserLoggedIn = false
    var body: some View {
        if isUserLoggedIn {
            ListView()
                .environmentObject(DataManager())
        } else {
            content
        }
    }

    var content: some View {
        ZStack {
            Color.yellow.opacity(0.5)
            Color.green.opacity(0.5)
            VStack {
                Group {
                    Text("Welcome").font(.system(size: 40, weight: .bold, design: .rounded)).foregroundColor(.white).frame(alignment: .leading)
                    HStack {
                        Image(systemName: "person.circle").padding([.leading], 20)
                            .font(.system(size: 35)).foregroundColor(.white)
                        VStack(spacing: 20) {
                            TextField(email, text: $email)
                                .foregroundColor(.white).bold().font(.system(size: 18, design: .rounded)).textInputAutocapitalization(.never)
                                .placeholder(when: email.isEmpty) {
                                    Text("Email").foregroundColor(.white).bold().font(.system(size: 18, design: .rounded))
                                }
                            Rectangle().frame(width: 300, height: 1)
                                .foregroundColor(.white)
                                .padding([.trailing], 50)
                        }
                    }
                }.padding([.top], 10)
                Group {
                    HStack {
                        Image(systemName: "lock.circle").padding([.leading], 20)
                            .font(.system(size: 35)).foregroundColor(.white)
                        VStack {
                            SecureField(password, text: $password)
                                .foregroundColor(.white).bold().font(.system(size: 18, design: .rounded)).textInputAutocapitalization(.never)
                                .placeholder(when: password.isEmpty) {
                                    Text("Password").foregroundColor(.white).bold().font(.system(size: 18, design: .rounded))
                                }
                            Rectangle().frame(width: 300, height: 1)
                                .foregroundColor(.white)
                                .padding([.trailing], 50)
                        }
                    }
                }.padding([.top], 10)

                Group {
                    Button {
                        register()
                    } label: {
                        Text("Sign Up")
                            .bold()
                            .frame(width: 200, height: 40)
                            .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.linearGradient(colors: [.cyan, .blue], startPoint: .top, endPoint: .bottomTrailing)))
                            .foregroundColor(.white)
                    }
                    Button(action: {
                        login()
                    }, label: {
                        Text("Already have an account? Login")
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                    })
                }
                .padding(.top).offset(y: 100)
                .onAppear {
                    Auth.auth().addStateDidChangeListener { _, user in
                        if user != nil {
                            isUserLoggedIn.toggle()
                        }
                    }
                }
            }
            .offset(y: -70)
        }
        .ignoresSafeArea()
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) {
            _, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }

    func register() {
        Auth.auth().createUser(withEmail: email, password: password) {
            _, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View
    {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
