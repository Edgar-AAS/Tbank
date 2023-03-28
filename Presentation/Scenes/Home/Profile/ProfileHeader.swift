import UIKit

class ProfileHeader: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
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
        let imageView = UIImageView(image: UIImage(systemName: "camera"))
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
        label.backgroundColor = .red
        label.textAlignment = .center
        return label
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Edgar Arlindo"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    lazy var bankBranchAndAccountNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Agência: \("0002")" + " | " + "Conta: \("12345678-9")"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    var string: (banNumber: String, accountNuber: String)?
    
    lazy var bankNumberAndCorporateNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Banco: \("029")" + " - " + "TBank S.A"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
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
    private func configureGestureRecognizer() {
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
        addSubview(shortEmailLabel)
        addSubview(userNameLabel)
        addSubview(bankBranchAndAccountNumberLabel)
        addSubview(bankNumberAndCorporateNameLabel)
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
        
        shortEmailLabel.fillConstraints(
            top: userPhotoImageView.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
        
        userNameLabel.fillConstraints(
            top: shortEmailLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 8, left: 16, bottom: 0, right: 16)
        )
        
        bankBranchAndAccountNumberLabel.fillConstraints(
            top: userNameLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
        
        bankNumberAndCorporateNameLabel.fillConstraints(
            top: bankBranchAndAccountNumberLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 2, left: 16, bottom: 0, right: 16)
        )
    }
    
    func setupAdditionalConfiguration() {
        configureGestureRecognizer()
    }
}
