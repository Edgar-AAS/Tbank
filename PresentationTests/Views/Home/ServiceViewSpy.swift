import Foundation
import Domain
import Presentation

class ServiceViewSpy: ServicesView {
    private(set) var emit: (([MainService]) -> Void)?
    
    func observe(completion: @escaping ([MainService]) -> Void) {
        emit = completion
    }
    
    func updateServicesView(services: [MainService]) {
        emit?(services)
    }
}
