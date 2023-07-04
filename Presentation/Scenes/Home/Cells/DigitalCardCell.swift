import UIKit
import Domain

final class DigitalCardCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: DigitalCardCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    lazy var cardNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        return label
    }()
        
    lazy var cardMarkImage: UIImageView = {
        let cardMarkImage = UIImage(named: "icon-mastercard-64x64")
        let imageView = UIImageView(image: cardMarkImage)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var cardNumberView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "AB831F")
        return view
    }()

    lazy var cardMarkView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var cardNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    lazy var cardExpirationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardNumberView.makeCornerRadius()
    }
    
    func configureCell(with cardModel: Card) {
        let viewModel = cardModel.getDigitalCardFormmated
        cardNameLabel.text = viewModel.name
        cardNumberLabel.text = viewModel.cardNumber
        cardExpirationLabel.text = viewModel.cardExpirationDate
    }
}

extension DigitalCardCell: CodeView {
    func buildViewHierarchy() {
        addSubview(cardNameLabel)
        addSubview(cardMarkView)
        cardMarkView.addSubview(cardMarkImage)
        addSubview(cardNumberView)
        cardNumberView.addSubview(cardNumberLabel)
        addSubview(cardExpirationLabel)
    }
    
    func setupConstrains() {
        cardNameLabel.fillConstraints(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 32, left: 20, bottom: 0, right: 8)
        )
        
        cardMarkView.fillConstraints(
            top: cardNameLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 85, left: 20, bottom: 0, right: 0),
            size: .init(width: 64, height: 36)
        )
        cardMarkImage.fillSuperview()
        
        cardNumberView.fillConstraints(
            top: cardMarkView.bottomAnchor,
            leading: leadingAnchor,
            trailing: nil,
            bottom: bottomAnchor,
            padding: .init(top: 8, left: 20, bottom: 16, right: 0),
            size: .init(width: 120, height: 0)
        )
        cardNumberLabel.superviewCenter()
        
        cardExpirationLabel.fillConstraints(
            top: nil,
            leading: nil,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: 0, left: 0, bottom: 20, right: 20)
        )
    }
    
    func setupAdditionalConfiguration() {
        layer.cornerRadius = 20
        clipsToBounds = true
        backgroundColor = Colors.secundaryColor.withAlphaComponent(0.95)
    }
}
