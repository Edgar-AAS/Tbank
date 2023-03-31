import Foundation
import Presentation

class ProfileViewSpy: ProfileView {
    private(set) var emit: ((ProfileViewModel) -> Void)?
    
    func observe(completion: @escaping (ProfileViewModel) -> Void) {
        self.emit = completion
    }
    
    func updateProfileView(viewModel: ProfileViewModel) {
        emit?(viewModel)
    }
}
