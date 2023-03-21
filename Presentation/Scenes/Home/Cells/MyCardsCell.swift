import UIKit

class MyCardCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: MyCardCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "R$ 2500,00"
        label.textColor = .white
        return label
    }()
    
}
