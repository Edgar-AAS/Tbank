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
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Edgar Arlindo"
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .offWhiteColor
        return label
    }() 
    
    lazy var notificationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bell"), for: .normal)
        button.tintColor = .secundaryColor
        return button
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.layer.masksToBounds = true
    }
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .primaryColor
        return view
    }()
    
    func updateHeaderDisplay(viewModel: ProfileViewModel) {
        userNameLabel.text = viewModel.username
    }
        
    private var headerViewHeight = NSLayoutConstraint()
    private var headerViewBottom = NSLayoutConstraint()
    var containerView = UIView()
    private var containerViewHeight = NSLayoutConstraint()
    
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
        headerView.addSubview(profileImageView)
        headerView.addSubview(userNameLabel)
        headerView.addSubview(notificationButton)
        addSubview(containerView)
        containerView.addSubview(headerView)
    }
    
    func setupConstrains() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: containerView.widthAnchor),
            centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.widthAnchor.constraint(equalTo: headerView.widthAnchor).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeight.isActive = true
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerViewBottom = headerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        headerViewBottom.isActive = true
        headerViewHeight = headerView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        headerViewHeight.isActive = true
        
        profileImageView.fillConstraints(
            top: containerView.topAnchor,
            leading: leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 16, left: 20, bottom: 0, right: 0),
            size: .init(width: K.ViewsSize.CircularButton.medium, height: K.ViewsSize.CircularButton.medium)
        )
        
        headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        
        userNameLabel.fillConstraints(
            top: nil,
            leading: profileImageView.trailingAnchor,
            trailing: notificationButton.leadingAnchor,
            bottom: nil,
            padding: .init(top: 0, left: 16, bottom: 0, right: 16)
        )
        
        userNameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        
        notificationButton.fillConstraints(
            top: userNameLabel.topAnchor,
            leading: nil,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 0, left: 0, bottom: 0, right: 16),
            size: .init(width: 24, height: 24)
        )
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .primaryColor
        configureGestureRecognizer()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        headerViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        headerViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
    
}
