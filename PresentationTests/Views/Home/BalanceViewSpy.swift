import Foundation
import Presentation

class BalanceViewSpy: BalanceView {
    private(set) var emit: ((BalanceViewModel) -> Void)?
    
    func observe(completion: @escaping (BalanceViewModel) -> Void) {
        emit = completion
    }
    
    func updateBalanceView(viewModel: BalanceViewModel) {
        emit?(viewModel)
    }
}
