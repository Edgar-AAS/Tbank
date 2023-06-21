import UIKit

public final class TransferSuccessView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension TransferSuccessView: CodeView {
    func buildViewHierarchy() {
        
    }
    
    func setupConstrains() {
        
    }
}
