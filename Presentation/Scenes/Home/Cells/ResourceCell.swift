import UIKit
import Domain


private let imageCache = NSCache<NSString, UIImage>()

final class ResourceCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: ResourceCell.self)
    var representedIdentifier: String?
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var serviceView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "2D2173")
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    lazy var resourcesBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "0A2647")
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.secundaryColor.cgColor
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    lazy var resourceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .offWhiteColor
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var imageContentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "0A2647")
        return view
    }()
    
    lazy var resourceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func setupCell(resource: Resource) {
        if let url = URL(string: resource.applogoURL) {
            resourceLabel.text = resource.resourceDescription
            loadImage(with: url, imageId: resource.applogoURL)
        }
    }
    
    private func loadImage(with url: URL, imageId: String) {
        if let image = imageCache.object(forKey: imageId as NSString) {
            resourceImage.image = image
        } else {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            imageCache.setObject(image, forKey: imageId as NSString)
                            self?.resourceImage.image = image
                        }
                    }
                }
            }
        }
    }
}

extension ResourceCell: CodeView {
    func buildViewHierarchy() {
        addSubview(resourcesBackgroundView)
        addSubview(imageContentView)
        imageContentView.addSubview(resourceImage)
        resourcesBackgroundView.addSubview(imageContentView)
        addSubview(resourceLabel)
    }
    
    func setupConstrains() {
        resourcesBackgroundView.fillConstraints(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor
        )
        
        imageContentView.fillConstraints(
            top: resourcesBackgroundView.topAnchor,
            leading: resourcesBackgroundView.leadingAnchor,
            trailing: resourcesBackgroundView.trailingAnchor,
            bottom: nil
        )
        
        resourceLabel.fillConstraints(
            top: imageContentView.bottomAnchor,
            leading: resourcesBackgroundView.leadingAnchor,
            trailing: resourcesBackgroundView.trailingAnchor,
            bottom: resourcesBackgroundView.bottomAnchor,
            padding: .init(top: 2, left: 8, bottom: 2, right: 8)
        )
        
        resourceImage.fillConstraints(
            top: imageContentView.topAnchor,
            leading: imageContentView.leadingAnchor,
            trailing: nil,
            bottom: imageContentView.bottomAnchor,
            padding: .init(top: 0, left: 0, bottom: 2, right: 0),
            size: .init(width: 80, height: 80)
        )
    }
}
