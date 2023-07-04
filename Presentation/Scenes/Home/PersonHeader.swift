import UIKit

public protocol PersonHeaderDelegateProtocol: AnyObject {
    func profileImageViewDidTapped()
}

public final class PersonHeaderCell: UITableViewCell {
    static let reuseIdentifier = String(describing: PersonHeaderCell.self)
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) { 
        super.init(coder: coder)
        setupView()
    }
    
    weak var delegate: PersonHeaderDelegateProtocol?
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = Colors.secundaryColor
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 32
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Colors.offWhiteColor
        return label
    }()
    
    lazy var notificationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Icons.bell, for: .normal)
        button.tintColor = Colors.secundaryColor
        return button
    }()
    
    private lazy var horizontalStack = makeHorizontalStack(with: [profileImageView, userNameLabel, notificationButton], spacing: 10)
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.secundaryColor
        return view
    }()
    
    func configureCell(with viewModel: PersonHeaderViewModel) {
        userNameLabel.text = viewModel.username
    }

    private func configureGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped))
        profileImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func profileImageViewTapped() {
        delegate?.profileImageViewDidTapped()
    }
}

extension PersonHeaderCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(horizontalStack)
    }
    
    func setupConstrains() {
        profileImageView.size(size: .init(width: CircularButtonSize.medium, height: CircularButtonSize.medium))
        
        horizontalStack.fillConstraints(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            bottom: contentView.bottomAnchor,
            padding: .init(top: 16, left: 20, bottom: 20, right: 20)
        )
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = Colors.primaryColor
        horizontalStack.alignment = .center
        configureGestureRecognizer()
    }
}
