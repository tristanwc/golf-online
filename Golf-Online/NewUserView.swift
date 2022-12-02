
import SwiftUI

struct NewUserView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var newUser = ""

    var body: some View {
        VStack {
            TextField("User", text: $newUser)
            Button {
                dataManager.addUser(userName: newUser)
            } label: {
                Text("Save")
            }
        }
        .padding()
    }
}

struct NewUserView_Previews: PreviewProvider {
    static var previews: some View {
        NewUserView()
    }
}
