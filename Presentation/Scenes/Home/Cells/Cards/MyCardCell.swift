import UIKit

final class MyCardCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: MyCardCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    lazy var myBalanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "Saldo"
        label.textColor = .white
        return label
    }()
    
    lazy var balanceCardLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .secundaryColor
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
        view.backgroundColor = UIColor(hexString: "0A2647")
        return view
    }()
    
    lazy var cardMarkView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var cardNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.text = "**** 3270"
        return label
    }()
    
    lazy var cardExpirationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "03/25"
        label.textColor = .white
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardNumberView.layer.cornerRadius = cardNumberView.frame.height / 2
        cardNumberView.clipsToBounds = true
    }
    
    func setupCell(with cardModel: CardModel) {
        balanceCardLabel.text = cardModel.balance
        cardNumberLabel.text = cardModel.cardNumber
        cardExpirationLabel.text = cardModel.cardExpirationDate
    }
}

extension MyCardCell: CodeView {
    func buildViewHierarchy() {
        addSubview(myBalanceLabel)
        addSubview(balanceCardLabel)
        addSubview(cardMarkView)
        cardMarkView.addSubview(cardMarkImage)
        addSubview(cardNumberView)
        cardNumberView.addSubview(cardNumberLabel)
        addSubview(cardExpirationLabel)
    }
    
    func setupConstrains() {
        myBalanceLabel.fillConstraints(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 32, left: 20, bottom: 0, right: 0)
        )
        
        balanceCardLabel.fillConstraints(
            top: myBalanceLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 8, left: 20, bottom: 0, right: 16)
        )
        
        cardMarkView.fillConstraints(
            top: balanceCardLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 48, left: 20, bottom: 0, right: 0),
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
    }
}
