import Foundation
import Presentation

class ProfileViewSpy: ProfileView {
    private(set) var emit: ((PersonHeaderViewModel) -> Void)?
    
    func observe(completion: @escaping (PersonHeaderViewModel) -> Void) {
        self.emit = completion
    }
    
    func updateProfileView(viewModel: PersonHeaderViewModel) {
        emit?(viewModel)
    }
}
