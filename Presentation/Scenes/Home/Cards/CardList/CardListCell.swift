import UIKit

class CardListCell: UITableViewCell {
    static let reuseIdentifier = String(describing: CardListCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        configurateCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurateCell() {
        detailTextLabel?.textColor = .secundaryColor
        textLabel?.textColor = .white
        imageView?.image = UIImage(named: "yellowImageCard")
        backgroundColor = .primaryColor
        accessoryType = .disclosureIndicator
    }
}