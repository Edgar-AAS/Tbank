import Foundation

public protocol LoadingView: AnyObject {
    func isLoading(viewModel: LoadingViewModel)
}

public struct LoadingViewModel {
    public var isLoading: Bool
    
    public init(isLoading: Bool) {
        self.isLoading = isLoading
    }
}
