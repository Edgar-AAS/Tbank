import Foundation
import UIKit

protocol CardCreationViewDelegateProtocol: AnyObject {
    func cardCreationButtonDidTapped()
}

class CardCreationView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var cardImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "card-logo"))
        return imageView
    }()
    
    private weak var delegate: CardCreationViewDelegateProtocol?
    
    convenience init(_ delegate: CardCreationViewDelegateProtocol) {
        self.init(frame: .zero)
        self.delegate = delegate
    }
    
    lazy var descriptionVirtualCardLabel: UILabel = .descriptionLabel(titleText: "Simplifique suas compras com um cartão digital!", subtitleText: "\nDescubra os benefícios de um cartão seguro, prático e flexível para suas compras online e offline.", titleFontSize: 30, subtitleFontSize: 20, titleColor: .offWhiteColor, subtitleColor: UIColor(hexString: "#cecece"))
    
    lazy var makeVirtualCardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Criar cartão digital", for: .normal)
        button.backgroundColor = UIColor(hexString: "EBB52F")
        button.setTitleColor(UIColor(hexString: "1A1A2E"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    @objc private func tap() {
        delegate?.cardCreationButtonDidTapped()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeVirtualCardButton.layer.cornerRadius = makeVirtualCardButton.frame.size.height / 2
        makeVirtualCardButton.clipsToBounds = true
    }
}

extension CardCreationView: CodeView {
    func buildViewHierarchy() {
        addSubview(cardImageView)
        addSubview(descriptionVirtualCardLabel)
        addSubview(makeVirtualCardButton)
    }
    
    func setupConstrains() {
        cardImageView.fillConstraints(
            top: safeAreaLayoutGuide.topAnchor,
            leading: nil,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 36, left: 0, bottom: 0, right: 0),
            size: .init(width: 200, height: 200)
        )
        
        cardImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        descriptionVirtualCardLabel.fillConstraints(
            top: cardImageView.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 24, bottom: 0, right: 16)
        )
                
        NSLayoutConstraint.activate([
            makeVirtualCardButton.topAnchor.constraint(greaterThanOrEqualTo: descriptionVirtualCardLabel.bottomAnchor, constant: 16),
            makeVirtualCardButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            makeVirtualCardButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            makeVirtualCardButton.heightAnchor.constraint(equalToConstant: 60),
            makeVirtualCardButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .primaryColor
    }
}
