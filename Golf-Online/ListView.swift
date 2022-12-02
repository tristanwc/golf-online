
import SwiftUI

struct ListView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var showPopup = false

    var body: some View {
        NavigationView {
            List(dataManager.users, id: \.id) { user in
                Text("User: \(user.id), Name: \(user.name), Age: \(user.age), Gender: \(user.gender)")
            }
            .navigationTitle("Users")
            .navigationBarItems(trailing: Button(action: {
                showPopup.toggle()
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $showPopup) {
                NewUserView()
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(DataManager())
    }
}
