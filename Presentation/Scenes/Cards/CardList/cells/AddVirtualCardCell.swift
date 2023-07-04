import Foundation
import UIKit

protocol AddVirtualCardCellDelegate: AnyObject {
    func AddVirtualCardButtonDidTapped()
}

class AddVirtualCardCell: UITableViewCell {
    static let reuseIdentifier = String(describing: AddVirtualCardCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var addVirtualCardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setTitle("Criar cartão digital", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        button.tintColor = UIColor(hexString: "#FCB119")
        return button
    }()
}

extension AddVirtualCardCell: CodeView {
    func buildViewHierarchy() {
        addSubview(addVirtualCardButton)
    }
    
    func setupConstrains() {
        addVirtualCardButton.fillConstraints(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            bottom: contentView.bottomAnchor,
            padding: .init(top: 16, left: 34, bottom: 0, right: 0)
        )
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = UIColor(hexString: "0A2647").withAlphaComponent(0.7)
    }
}
