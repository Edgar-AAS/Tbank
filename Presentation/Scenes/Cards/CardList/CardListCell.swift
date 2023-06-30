import UIKit
import Domain

class CardListCell: UITableViewCell {
    static let reuseIdentifier = String(describing: CardListCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        configurate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(userCard: Card) {
        textLabel?.text = userCard.name
        detailTextLabel?.text = userCard.cardNumber.toSafeCardNumber()
    }
    
    private func configurate() {
        selectionStyle = .none
        detailTextLabel?.textColor = Colors.secundaryColor
        textLabel?.textColor = .white
        imageView?.image = UIImage(named: "yellowImageCard")
        backgroundColor = Colors.primaryColor
        accessoryType = .disclosureIndicator
    }
}
