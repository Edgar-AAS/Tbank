import Foundation
import Presentation
import Domain

class ResourcesViewSpy: ResourcesView {
    private(set) var emit: (([Resource]) -> Void)?
    
    func observe(completion: @escaping ([Resource]) -> Void) {
        emit = completion
    }
    
    func updateResourcesView(resources: [Resource]) {
        emit?(resources)
    }
}
