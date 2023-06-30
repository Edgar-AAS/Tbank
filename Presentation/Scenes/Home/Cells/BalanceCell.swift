import UIKit

final class BalanceCell: UITableViewCell {
    static let reuseIdentifier = String(describing: BalanceCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        contentView.backgroundColor = Colors.primaryColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var myAccountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Minha Conta"
        label.textColor = Colors.offWhiteColor
        return label
    }()
    
    lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = Colors.secundaryColor
        return label
    }()
    
    private lazy var hideShowBalanceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = Colors.secundaryColor
        return button
    }()
    
    func configureCell(with viewModel: BalanceViewModel) {
        balanceLabel.text = viewModel.totalBalance
    }
}

extension BalanceCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(myAccountLabel)
        contentView.addSubview(balanceLabel)
        contentView.addSubview(hideShowBalanceButton)
    }
    
    func setupConstrains() {
        myAccountLabel.fillConstraints(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 16, left: 20, bottom: 0, right: 16)
        )
        
        hideShowBalanceButton.fillConstraints(
            top: nil,
            leading: myAccountLabel.trailingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 0, left: 20, bottom: 0, right: 0),
            size: .init(width: 36, height: 36)
        )
        hideShowBalanceButton.centerYAnchor.constraint(equalTo: myAccountLabel.centerYAnchor).isActive = true

        balanceLabel.fillConstraints(
            top: myAccountLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            bottom: contentView.bottomAnchor,
            padding: .init(top: 16, left: 20, bottom: 16, right: 20)
        )
    }
}
