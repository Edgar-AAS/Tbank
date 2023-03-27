import UIKit

final class CardCell: UITableViewCell, UICollectionViewDelegate {
    static let reuseIdentifier = String(describing: CardCell.self)
    var collectionView: UICollectionView!
    
    var cards = [CardModel]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
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
    
    lazy var addCardButton: UIButton = {
        let button = UIButton(type: .system)
        let buttonImage = UIImage(systemName: "plus")
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hexString: "2D2D2D").cgColor
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hexString: "202020")
        return button
    }()
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .red
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.register(MyCardCell.self, forCellWithReuseIdentifier: MyCardCell.reuseIdentifier)
    }
    
    func setupCell(with viewModel: CardsViewViewModel?) {
        guard let viewModel = viewModel else { return }
        self.cards = viewModel.cards
    }
}

extension CardCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCardCell.reuseIdentifier, for: indexPath) as? MyCardCell
        cell?.setupCell(with: cards[indexPath.row])
        cell?.backgroundColor = .purple
        return cell ?? UICollectionViewCell()
    }
}

extension CardCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(myCardsLabel)
        contentView.addSubview(addCardButton)
        contentView.addSubview(collectionView)
    }
    
    func setupConstrains() {
        myCardsLabel.fillConstraints(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 20, left: 20, bottom: 0, right: 0)
        )
        
        addCardButton.fillConstraints(
            top: contentView.topAnchor,
            leading: nil,
            trailing: contentView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 8, left: 0, bottom: 0, right: 16),
            size: .init(width: 100, height: 44)
        )
        
        collectionView.fillConstraints(
            top: myCardsLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            bottom: contentView.bottomAnchor,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: contentView.bounds.width * 0.8)
        )
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .black
    }
}

extension CardCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.size.width/1.2, height: collectionView.frame.size.height - 20)
    }
}
