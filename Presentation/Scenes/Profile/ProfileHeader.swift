import UIKit
import Domain

public class ProfileHeader: UIView {
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
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var shortEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "@edgar.almd"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var bankBranchAndAccountNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var bankNumberAndCorporateNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    func configureHeaderWith(viewModel: ProfileInfoViewModel) {
        userNameLabel.text = viewModel.username
        bankBranchAndAccountNumberLabel.attributedText = getBankBranchAndAcconuntNumberAttributedString(title1: "Agência",
                                                                                                        subtitle1: viewModel.bankBranch,
                                                                                                        title2: "Conta",
                                                                                                        subtitle2: viewModel.bankAccountNumber)
        bankNumberAndCorporateNameLabel.attributedText = getbankNumberAndCorporateNameAttributedString(title1: "Banco",
                                                                                                       subtitle1: viewModel.bankNumber,
                                                                                                       subtitle2: viewModel.corporateName)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
        userPhotoImageView.layer.masksToBounds = true
    }
    
    private func getBankBranchAndAcconuntNumberAttributedString(title1: String, subtitle1: String, title2: String, subtitle2: String) -> NSMutableAttributedString {
        let firstAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.white]
        let secondAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: Colors.secundaryColor]

        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(string: "\(title1): ", attributes: firstAttributes))
        attributedText.append(NSAttributedString(string: "\(subtitle1)", attributes: secondAttributes))
        attributedText.append(NSAttributedString(string: " | ", attributes: firstAttributes))
        attributedText.append(NSAttributedString(string: "\(title2): ", attributes: firstAttributes))
        attributedText.append(NSAttributedString(string: "\(subtitle2)", attributes: secondAttributes))
        return attributedText
    }
    
    private func getbankNumberAndCorporateNameAttributedString(title1: String, subtitle1: String, subtitle2: String) -> NSMutableAttributedString {
        let firstAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.white]
        let secondAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: Colors.secundaryColor]

        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(string: "\(title1): ", attributes: firstAttributes))
        attributedText.append(NSAttributedString(string: "\(subtitle1)", attributes: secondAttributes))
        attributedText.append(NSAttributedString(string: " - ", attributes: firstAttributes))
        attributedText.append(NSAttributedString(string: "\(subtitle2)", attributes: secondAttributes))
        return attributedText
    }
}

// MARK: - Private Method
extension ProfileHeader {
    private func configureGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        userPhotoImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func imageTapped() {
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
            size: .init(width: CircularButtonSize.large, height: CircularButtonSize.large)
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
            bottom: bottomAnchor,
            padding: .init(top: 2, left: 16, bottom: 0, right: 16)
        )
    }
    
    func setupAdditionalConfiguration() {
        configureGestureRecognizer()
        backgroundColor = Colors.primaryColor
    }
}
