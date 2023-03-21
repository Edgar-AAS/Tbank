import UIKit

class ProfileHeader: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .lightGray
    }
    
    convenience init(_ delegate: ProfileHeaderDelegateProtocol?) {
        self.init(frame: .zero)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
   
    weak var delegate: ProfileHeaderDelegateProtocol?
    
    lazy var userPhotoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person"))
        imageView.backgroundColor = .orange
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var shortEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "@edgar.almd"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "@edgar.almd"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var bankBranch: UILabel = {
        let label = UILabel()
        label.text = "Agência: 0001"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var accountNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Conta 87654321-9"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var bankNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "380"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var corporateName: UILabel = {
        let label = UILabel()
        label.text = "Tail Bank Serviços S.A"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.black
        return label
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
        userPhotoImageView.layer.masksToBounds = true
    }
}

// MARK: - Private Method
extension ProfileHeader {
    func configureGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        userPhotoImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func imageTapped() {
        delegate?.userPhotoImageDidTapped()
    }
}

extension ProfileHeader: CodeView {
    func buildViewHierarchy() {
        addSubview(userPhotoImageView)
    }
    
    func setupConstrains() {
        userPhotoImageView.fillConstraints(
            top: topAnchor,
            leading: nil,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 24, left: 0, bottom: 0, right: 0),
            size: .init(width: 120, height: 120)
        )
        userPhotoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        configureGestureRecognizer()
    }
}
