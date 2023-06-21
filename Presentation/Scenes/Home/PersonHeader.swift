import UIKit

public protocol PersonHeaderDelegateProtocol: AnyObject {
    func profileButtonDidTapped()
}

public final class PersonHeader: UIView {
    static let reuseIdentifier = String(describing: PersonHeader.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.minimumScaleFactor = 0.5
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
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.layer.masksToBounds = true
    }
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.secundaryColor
        return view
    }()
    
    func updateHeaderDisplay(viewModel: ProfileViewModel) {
        userNameLabel.text = viewModel.username
    }

    private func configureGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped))
        profileImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func profileImageViewTapped() {
        delegate?.profileButtonDidTapped()
    }
}

extension PersonHeader: CodeView {
    func buildViewHierarchy() {
        addSubview(profileImageView)
        addSubview(userNameLabel)
        addSubview(notificationButton)
        addSubview(horizontalStack)
    }
    
    func setupConstrains() {
        let safeArea = safeAreaLayoutGuide
        
        profileImageView.size(size: .init(width: CircularButtonSize.medium, height: CircularButtonSize.medium))
        
        horizontalStack.fillConstraints(
            top: safeArea.topAnchor,
            leading: safeArea.leadingAnchor,
            trailing: safeArea.trailingAnchor,
            bottom: safeArea.bottomAnchor,
            padding: .init(top: 0, left: 20, bottom: 0, right: 16)
        )
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = Colors.primaryColor
        horizontalStack.alignment = .center
        configureGestureRecognizer()
    }
}
