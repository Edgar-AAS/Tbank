import Foundation
import Presentation

class LoadingViewSpy: LoadingView {
    private(set) var emit: ((LoadingViewModel) -> Void)?
    
    func observe(completion: @escaping (LoadingViewModel) -> Void) {
        self.emit = completion
    }
    
    func isLoading(viewModel: LoadingViewModel) {
        emit?(viewModel)
    }
}
