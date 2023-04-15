import Foundation
import Domain

public final class MainQueueDispatchDecorator<T> {
    private let instance: T
    
    public init(_ instance: T) {
        self.instance = instance
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else { return DispatchQueue.main.async(execute: completion) }
        completion()
    }
}

extension MainQueueDispatchDecorator: AddAccount where T: AddAccount {
    public func add(addAccountModel: AddAccountModel, completion: @escaping (AddAccount.Result) -> Void) {
        instance.add(addAccountModel: addAccountModel, completion: { [weak self] result in
            self?.dispatch { completion(result) }
        })
    }
}

extension MainQueueDispatchDecorator: Authentication where T: Authentication {
    public func auth(authenticationModel: AuthenticationModel, completion: @escaping (Authentication.Result) -> Void) {
        instance.auth(authenticationModel: authenticationModel) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: FetchUserDataResources where T: FetchUserDataResources {
    public func fetch(completion: @escaping (Result<UserData, DomainError>) -> Void) {
        instance.fetch { [weak self] result  in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: FetchUserCards where T: FetchUserCards {
    public func fetch(completion: @escaping (Result<UserCards, DomainError>) -> Void) {
        instance.fetch { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: AddCard where T: AddCard {
    public func add<T>(cardModel: T, completion: @escaping (Result<Void, DomainError>) -> Void) where T : Model {
        instance.add(cardModel: cardModel) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}


