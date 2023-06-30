import UIKit
import Domain

final class ResourcesGridCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    static let reuseIdentifier = String(describing: ResourcesGridCell.self)
    var collectionView: UICollectionView!

    var resourceViewModels: [ResourceViewModel] = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var recommendationLabel: UILabel = {
        let label = UILabel()
        label.text = "Confira também"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = Colors.offWhiteColor
        return label
    }()

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Colors.primaryColor
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        collectionView.register(ResourceCell.self, forCellWithReuseIdentifier: ResourceCell.reuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resourceViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResourceCell.reuseIdentifier, for: indexPath) as? ResourceCell
        cell?.resourceImage.image = UIImage(named: "resource-\(indexPath.row + 1)")
        cell?.configureCell(with: resourceViewModels[indexPath.item])
        return cell ?? UICollectionViewCell()
    }
    
    func configureCell(with viewModel: [ResourceViewModel]) {
        self.resourceViewModels = viewModel
        collectionView.reloadData()
    }
}

extension ResourcesGridCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(collectionView)
        contentView.addSubview(recommendationLabel)
    }
    
    func setupConstrains() {
        let cv = contentView
        
        recommendationLabel.fillConstraints(
            top: cv.topAnchor,
            leading: cv.leadingAnchor,
            trailing: cv.trailingAnchor,
            bottom: nil,
            padding: .init(top: 8, left: 20, bottom: 0, right: 20)
        )
        
        collectionView.fillConstraints(
            top: recommendationLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            bottom: contentView.bottomAnchor,
            size: .init(width: 0, height: bounds.width * 1.2)
        )
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = Colors.primaryColor
    }
}

extension ResourcesGridCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widht = (collectionView.bounds.width / 2) - 25
        let height = (collectionView.bounds.height / 2) - 15
        return CGSize(width: widht, height: height)
    }
}
