import Firebase
import SwiftUI

struct SettingsView: View {
    @ObservedObject var model = Model()
    @State var showForm = false
    @State var showSignInView = false
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                List {
                    VStack {
                        HStack {
                            Text("Dark Mode Toggle")
                            ModeSwitchView()
                        }
                    }
                }
            }
            .sheet(isPresented: $showForm) {
                ModeSwitchView()
            }
            .fullScreenCover(isPresented: $showSignInView) {
                SignInView(cardListViewModel: model)
            }
            .onAppear {
                showSignInView = model.user == nil ? true : false
            }
            .onChange(of: model.user) { user in
                showSignInView = user == nil ? true : false
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing:
                Menu {
                    if let email = model.user?.email {
                        Text(email)
                        Button("Sign Out", action: AuthenticationService.signOut)
                    }
                }
                    label: {
                    Image(systemName: "person.fill")
                        .font(.title)
                }
            )
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .accentColor(.primary)
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
