import UIKit
import Domain

public protocol ServicesCellDelegateProtocol: AnyObject {
    func cardServiceDidTapped(serviceTag: Int)
}

final class ServicesCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    static let reuseIdentifier = String(describing: ServicesCell.self)
    private var collectionView: UICollectionView!
    private var services: [Service] = []
    
    weak var delegate: ServicesCellDelegateProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Colors.primaryColor
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.register(ServiceCell.self, forCellWithReuseIdentifier: ServiceCell.reuseIdentifier)
    }
    
    func setupCell(with services: [Service]) {
        self.services = services
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cardServiceDidTapped(serviceTag: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCell.reuseIdentifier, for: indexPath) as? ServiceCell
        cell?.setupCell(service: services[indexPath.item])
        return cell ?? UICollectionViewCell()
    }
}

extension ServicesCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.size.width / 5, height: collectionView.frame.size.height - 20)
    }
}

extension ServicesCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(collectionView)
    }
    
    func setupConstrains() {
        collectionView.fillConstraints(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            bottom: contentView.bottomAnchor,
            size: .init(width: 0, height: contentView.bounds.width * 0.5)
        )
    }
}


