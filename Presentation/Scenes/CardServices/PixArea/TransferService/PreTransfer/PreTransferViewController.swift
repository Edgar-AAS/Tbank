import UIKit
import Domain

public class PreTransferViewController: UIViewController {
    private lazy var transferButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Transferir", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(Colors.primaryColor, for: .normal)
        button.backgroundColor = Colors.secundaryColor
        button.addTarget(self, action: #selector(transferButtonTap), for: .touchUpInside)
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        return button
    }()

    private lazy var preTransferView: PreTransferScreen = {
        return PreTransferScreen()
    }()
    
    public override func loadView() {
        super.loadView()
        view = preTransferView
    }
    
    public var presenter: ViewToPresenterPreTransfer?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.callsPreTransferData()
    }
    
    @objc private func transferButtonTap() {
        print("teste")
    }
}

extension PreTransferViewController: UpdatePreTransferView {
    public func update(contact: ContactModel, balance: String) {
        preTransferView.setupTextLabels(balance, contact: contact)
    }
}

extension PreTransferViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(transferButton)
    }
    
    func setupConstrains() {
        let safeArea = view.safeAreaLayoutGuide
        
        transferButton.fillConstraints(
            top: nil,
            leading: safeArea.leadingAnchor,
            trailing: safeArea.trailingAnchor,
            bottom: safeArea.bottomAnchor,
            padding: .init(top: 0, left: 20, bottom: 20, right: 20),
            size: .init(width: 0, height: 60)
        )
    }
}
