import Foundation
import Presentation

class CardsViewSpy: CardsView {
    private(set) var emit: ((CardsViewViewModel) -> Void)?
    
    func observe(completion: @escaping (CardsViewViewModel) -> Void) {
        emit = completion
    }
    
    func updateCardsView(viewModel: CardsViewViewModel) {
        emit?(viewModel)
    }
}
