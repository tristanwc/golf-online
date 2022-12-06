import Firebase
import SwiftUI

struct CardListView: View {
    @ObservedObject var model = Model()

    @State var showForm = false
    @State var showSignInView = false

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    VStack {
                        ForEach(model.cardViewModels) { cardViewModel in
                            CardView(model: cardViewModel)
                                .padding([.vertical])
                        }
                    }
                    .frame(width: geometry.size.width)
                }
            }
            .sheet(isPresented: $showForm) {
                NewCardForm(cardListViewModel: model)
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
            .navigationTitle("Cloud Cards")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading:
                Menu {
                    if let email = model.user?.email {
                        Text(email)
                        Button("Sign Out", action: AuthenticationService.signOut)
                    }
                }
                    label: {
                    Image(systemName: "person.fill")
                        .font(.title)
                },
                trailing:
                Button { showForm.toggle() }
                label: {
                        Image(systemName: "plus")
                            .font(.title)
                    }
            )
        }
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView()
    }
}
