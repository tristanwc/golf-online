import Combine
import Foundation

extension CardView {
    final class CardModel: ObservableObject, Identifiable {
        private let cardRepository: CardRepository
        @Published var card: Card
        private var cancellables: Set<AnyCancellable> = []
        var id = ""

        init(card: Card, repository: CardRepository) {
            self.cardRepository = repository
            self.card = card

            $card
                .compactMap { $0.id }
                .assign(to: \.id, on: self)
                .store(in: &cancellables)
        }

        func update(card: Card) {
            cardRepository.update(card)
        }

        func remove() {
            cardRepository.remove(card)
        }
    }
}
