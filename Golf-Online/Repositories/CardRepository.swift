import Foundation

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class CardRepository: ObservableObject {
    private let store = Firestore.firestore()
    private let path = "cards"

    @Published var cards: [Card] = []

    var userID = ""
    private let authenticationService: AuthenticationService
    private var cancellables: Set<AnyCancellable> = []

    init(authenticationService: AuthenticationService) {
        self.authenticationService = authenticationService

        authenticationService.$user
            .compactMap { user in
                user?.uid
            }
            .assign(to: \.userID, on: self)
            .store(in: &cancellables)

        authenticationService.$user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.get()
            }
            .store(in: &cancellables)
    }

    func get() {
        store.collection(path)
            .whereField("userID", isEqualTo: userID)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting cards: \(error.localizedDescription)")
                    return
                }

                self.cards = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Card.self)
                } ?? []
            }
    }

    func add(_ card: Card) {
        do {
            var newCard = card
            newCard.userID = userID
            _ = try store.collection(path).addDocument(from: newCard)
        } catch {
            fatalError("Unable to add card: \(error.localizedDescription).")
        }
    }

    func update(_ card: Card) {
        guard let cardId = card.id else { return }

        do {
            try store.collection(path).document(cardId).setData(from: card)
        } catch {
            fatalError("Unable to update card: \(error.localizedDescription).")
        }
    }

    func remove(_ card: Card) {
        guard let cardId = card.id else { return }

        store.collection(path).document(cardId).delete { error in
            if let error = error {
                print("Unable to remove card: \(error.localizedDescription)")
            }
        }
    }
}
