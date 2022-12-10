import Foundation

import Combine
import Firebase

extension CardListView {
    final class Model: ObservableObject {
        @Published var cardViewModels: [CardView.CardModel] = []
        @Published var cardRepository: CardRepository
    
        let authenticationService = AuthenticationService()
        @Published var user: User?
        private var cancellables: Set<AnyCancellable> = []
    
        init() {
            cardRepository = CardRepository(authenticationService: authenticationService)
      
            authenticationService.$user
                .assign(to: \.user, on: self)
                .store(in: &cancellables)
      
            cardRepository.$cards.map { cards in
                cards.map { card in
                    CardView.CardModel(card: card, repository: self.cardRepository)
                }
            }
            .assign(to: &$cardViewModels)
        }
    
        func add(_ card: Card) {
            cardRepository.add(card)
        }
    
        func addStarterCards() {
            let cards = [
                Card(
                    question: "Which type of cloud is closest to the ground?",
                    answer: "Stratus"
                ),
                Card(
                    question: "What is the study of clouds called?",
                    answer: "Nephology"
                ),
                Card(
                    question: "Which Cloud is originally from Nibelheim?",
                    answer: "Cloud Strife"
                ),
                Card(
                    question: "Which type of cloud does Goku use for transportation?",
                    answer: "Flying Nimbus"
                )
            ]
      
            cards.forEach { card in
                cardRepository.add(card)
            }
        }
    }
}
