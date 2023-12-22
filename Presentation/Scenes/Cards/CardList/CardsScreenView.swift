import Foundation
import UIKit

public class CardsScreenView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    lazy var myCardsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Meus Cartões"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = Colors.offWhiteColor
        return label
    }()
    
    lazy var myCardsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(AddVirtualCardCell.self, forCellReuseIdentifier: AddVirtualCardCell.reuseIdentifier)
        tableView.register(CardListCell.self, forCellReuseIdentifier: CardListCell.reuseIdentifier)
        tableView.backgroundColor = Colors.primaryColor
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    func setupTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        myCardsTableView.delegate = delegate
        myCardsTableView.dataSource = dataSource
    }
}

extension CardsScreenView: CodeView {
    func buildViewHierarchy() {
        addSubview(myCardsTitleLabel)
        addSubview(myCardsTableView)
    }
    
    func setupConstrains() {
        myCardsTitleLabel.fillConstraints(
            top: safeAreaLayoutGuide.topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 32, left: 24, bottom: 0, right: 16)
        )
        
        myCardsTableView.fillConstraints(
            top: myCardsTitleLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: safeAreaLayoutGuide.bottomAnchor,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = Colors.primaryColor
    }
}
