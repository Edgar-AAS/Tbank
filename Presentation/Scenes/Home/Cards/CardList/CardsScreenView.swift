import Foundation
import UIKit

protocol CardsScreenViewDelegateProtocol: AnyObject {
    func closeButtonDidTapped()
}

public class CardsScreenView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    weak var delegate: CardsScreenViewDelegateProtocol?
    
    convenience init(delegate: CardsScreenViewDelegateProtocol?) {
        self.init(frame: .zero)
        self.delegate = delegate
    }

    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        let buttonImage = UIImage(systemName: "xmark")
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .darkGray
        return button
    }()
    
    lazy var myCardsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Meus Cartões"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    lazy var myCardsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.register(AddVirtualCardCell.self, forCellReuseIdentifier: AddVirtualCardCell.reuseIdentifier)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        return tableView
    }()
    
    func setupTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        myCardsTableView.delegate = delegate
        myCardsTableView.dataSource = dataSource
    }
    
    @objc func closeButtonTapped() {
        delegate?.closeButtonDidTapped()
    }

}

extension CardsScreenView: CodeView {
    func buildViewHierarchy() {
        addSubview(closeButton)
        addSubview(myCardsTitleLabel)
        addSubview(myCardsTableView)
    }
    
    func setupConstrains() {
        let circularButtonSize = K.ViewsSize.CircularButton.small
        closeButton.fillConstraints(
            top: safeAreaLayoutGuide.topAnchor,
            leading: leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 16, left: 24, bottom: 0, right: 0),
            size: .init(width: circularButtonSize, height: circularButtonSize)
        )
        
        myCardsTitleLabel.fillConstraints(
            top: closeButton.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 24, bottom: 0, right: 16)
        )
        
        myCardsTableView.fillConstraints(
            top: myCardsTitleLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: safeAreaLayoutGuide.bottomAnchor,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
    }
}
