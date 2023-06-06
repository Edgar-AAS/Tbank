import Foundation
import Presentation
import Domain

//o tratamento de memoria fica dentro do main layer
//uma camada que adiciona um comportamento

class WeakVarProxy<T: AnyObject> {
    weak var instance: T?
    
    init(_ instance: T) {
        self.instance = instance
    }
}
