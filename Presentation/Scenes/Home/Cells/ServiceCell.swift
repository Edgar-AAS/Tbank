import UIKit
import Domain

final class ServiceCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: ServiceCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var serviceView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "0A2647")
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.secundaryColor.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    lazy var serviceImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "iphone"))
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.tintColor = .secundaryColor
        return imageView
    }()
    
    lazy var serviceNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Recarga de celular"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    func setupCell(service: MainService) {
        self.serviceNameLabel.text = service.serviceName
        self.serviceImage.image = UIImage(systemName: service.serviceIconURL)
    }
}

extension ServiceCell: CodeView {
    func buildViewHierarchy() {
        addSubview(serviceView)
        serviceView.addSubview(serviceImage)
        addSubview(serviceNameLabel)
    }
    
    func setupConstrains() {
        serviceView.fillConstraints(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 8, left: 2, bottom: 0, right: 2),
            size: .init(width: 0, height: 64)
        )
        
        serviceImage.superviewCenter(size: .init(width: 36, height: 36))
        
        serviceNameLabel.fillConstraints(
            top: serviceView.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: 2, left: 2, bottom: 2, right: 2)
        )
    }
    
    func setupAdditionalConfiguration() {
        
    }
}
