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
    
    lazy var descriptionVirtualCardLabel: UILabel = {
        let label = UILabel()
        let titleColor = UIColor(hexString: "1A1A2E")
        let subtitleColor = UIColor.systemGray
        let titleFontSize = UIFont.boldSystemFont(ofSize: 30)
        let subtitleFontSize = UIFont.systemFont(ofSize: 20)
        
        let titleAttributes = [NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.font: titleFontSize]
        let subtitleAtributes = [NSAttributedString.Key.foregroundColor: subtitleColor, NSAttributedString.Key.font: subtitleFontSize]
        
        let title = NSMutableAttributedString(string: "Simplifique suas compras com um cartão digital!", attributes: titleAttributes)
        let subtitle = NSMutableAttributedString(string: "\n\nDescubra os benefícios de um cartão seguro, prático e flexível para suas compras online e offline.", attributes: subtitleAtributes)
        
        title.addAttribute(.font, value: titleFontSize, range: NSRange(location: 0, length: title.length))
        title.addAttribute(.foregroundColor, value: titleColor, range: NSRange(location: 0, length: title.length))
        
        subtitle.addAttribute(.foregroundColor, value: subtitleColor, range: NSRange(location: 0, length: subtitle.length))
        subtitle.addAttribute(.font, value: subtitleFontSize, range: NSRange(location: 0, length: subtitle.length))
        
        title.append(subtitle)
        label.attributedText = title
        label.numberOfLines = 0
        return label
    }()
    
    lazy var makeVirtualCardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Criar cartão digital", for: .normal)
        button.backgroundColor = UIColor(hexString: "EBB52F")
        button.setTitleColor(UIColor(hexString: "1A1A2E"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()
    
    @objc private func tap() {
        delegate?.cardCreationButtonDidTapped()
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
            makeVirtualCardButton.heightAnchor.constraint(equalToConstant: 50),
            makeVirtualCardButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
}
