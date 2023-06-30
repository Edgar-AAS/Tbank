import UIKit

public final class TransferSuccessViewController: UIViewController {
    private lazy var transferSuccessView: TransferSuccessView = {
        return TransferSuccessView()
    }()
    
    public override func loadView() {
        super.loadView()
        view = transferSuccessView
    }
    
    public var presenter: ViewToPresenterTransferSuccess?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.updateUI()
        
        let backButton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
    }
    
    @objc func backButtonTapped() {
        presenter?.goToPixArea()
    }
}

extension TransferSuccessViewController: UpdateTransferSuccessView {
    public func updateViewWith(viewModel: TransferSuccessViewModel) {
        transferSuccessView.updateUI(with: viewModel)
    }
}
