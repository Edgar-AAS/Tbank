import UIKit
import Domain

final class ServicesCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    static let reuseIdentifier = String(describing: ServicesCell.self)
    var collectionView: UICollectionView!
    
    var services = [Service]()
    
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
        collectionView.backgroundColor = Colors.primaryColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.register(ServiceCell.self, forCellWithReuseIdentifier: ServiceCell.reuseIdentifier)
    }
    
    func setupCell(services: [Service]) {
        self.services = services
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCell.reuseIdentifier, for: indexPath) as? ServiceCell
        cell?.setupCell(service: services[indexPath.item])
        cell?.backgroundColor = Colors.primaryColor
        return cell ?? UICollectionViewCell()
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
            size: .init(width: 0, height: contentView.bounds.width / 2)
        )
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = Colors.primaryColor
    }
}

extension ServicesCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.size.width/5, height: collectionView.frame.size.height - 20)
    }
}
