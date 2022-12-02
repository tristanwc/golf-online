import Firebase
import SwiftUI

class DataManager: ObservableObject {
    @Published var users: [User] = []

    init() {
        fetchUsers()
    }

    func fetchUsers() {
        users.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Users")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }

            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()

                    let id = data["id"] as? String ?? ""
                    let age = data["age"] as? String ?? ""
                    let gender = data["gender"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    print("Id: \(id), Name: \(name), Age: \(age), Gender: \(gender)")
                    let user = User(id: id, name: name, age: age, gender: gender)
                    self.users.append(user)
                }
            }
        }
    }

    func addUser(userName: String) {
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(userName)
        ref.setData(["name": userName, "id": 10]) {
            error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
