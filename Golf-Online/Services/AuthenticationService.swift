import Firebase

class AuthenticationService: ObservableObject {
    @Published var user: User?
    private var authenticationStateHandle: AuthStateDidChangeListenerHandle?
  
    init() {
        addListeners()
    }
  
    static func signIn(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        if Auth.auth().currentUser != nil {
            Self.signOut()
        }
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
  
    static func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
  
    static func addNewUser(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }
  
    private func addListeners() {
        if let handle = authenticationStateHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    
        authenticationStateHandle = Auth.auth()
            .addStateDidChangeListener { _, user in
                self.user = user
            }
    }
}
