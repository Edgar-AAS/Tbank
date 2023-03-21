import UIKit

final class ResourcesGridCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    static let reuseIdentifier = String(describing: ResourcesGridCell.self)
    var collectionView: UICollectionView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .yellow
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        collectionView.register(ResourceCell.self, forCellWithReuseIdentifier: ResourceCell.reuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResourceCell.reuseIdentifier, for: indexPath) as? ResourceCell
        return cell ?? UICollectionViewCell()
    }
}

extension ResourcesGridCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(collectionView)
    }
    
    func setupConstrains() {
        collectionView.fillConstraints(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            bottom: contentView.bottomAnchor,
            size: .init(width: 0, height: bounds.width * 1.2)
        )
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .red
    }
}

extension ResourcesGridCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widht = (collectionView.bounds.width / 2) - 25
        let height = (collectionView.bounds.height / 2) - 15
        return CGSize(width: widht, height: height)
    }
}
