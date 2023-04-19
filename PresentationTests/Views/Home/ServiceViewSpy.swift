import Foundation
import Domain
import Presentation

class ServiceViewSpy: ServicesView {
    private(set) var emit: (([Service]) -> Void)?
    
    func observe(completion: @escaping ([Service]) -> Void) {
        emit = completion
    }
    
    func updateServicesView(services: [Service]) {
        emit?(services)
    }
}
