import Foundation

public protocol LoadingView {
    func isLoading(viewModel: LoadingViewModel)
}

public struct LoadingViewModel {
    public var isLoading: Bool
    
    public init(isLoading: Bool) {
        self.isLoading = isLoading
    }
}
