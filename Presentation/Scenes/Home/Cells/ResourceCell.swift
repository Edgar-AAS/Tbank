import UIKit
import Domain

final class ResourceCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: ResourceCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var myCardsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Meus cartões"
        label.textColor = .white
        return label
    }()
    
    lazy var serviceView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "2D2173")
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    lazy var resourcesBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    lazy var resourceImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon-uber-64x64"))
        imageView.tintColor = .orange
        return imageView
    }()
    
    lazy var resourceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .orange
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    func setupCell(resource: Resource) {
        resourceLabel.text = resource.resourceDescription
    }
}

extension ResourceCell: CodeView {
    func buildViewHierarchy() {
        addSubview(resourcesBackgroundView)
        resourcesBackgroundView.addSubview(resourceImage)
        addSubview(resourceLabel)
    }
    
    func setupConstrains() {
        resourcesBackgroundView.fillConstraints(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: 2, left: 2, bottom: 2, right: 2)
        )
        
        resourceImage.fillConstraints(
            top: resourcesBackgroundView.topAnchor,
            leading: resourcesBackgroundView.leadingAnchor,
            trailing: nil,
            bottom: nil,
            size: .init(width: 80, height: 80)
        )
        
        resourceLabel.fillConstraints(
            top: resourceImage.bottomAnchor,
            leading: resourcesBackgroundView.leadingAnchor,
            trailing: resourcesBackgroundView.trailingAnchor,
            bottom: resourcesBackgroundView.bottomAnchor,
            padding: .init(top: 8, left: 8, bottom: 8, right: 8)
        )
    }
}
