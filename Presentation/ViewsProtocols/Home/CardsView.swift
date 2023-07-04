import Foundation
import Domain

public protocol UpdateCardListCells {
    func updateCardsList(cardListSource: CardListSource)
}

public struct CardListSource {
    public let physicalCards: [Card]
    public let virtualCards: [Card]
    
    public init(physicalCards: [Card], virtualCards: [Card]) {
        self.physicalCards = physicalCards
        self.virtualCards = virtualCards
    }
}
