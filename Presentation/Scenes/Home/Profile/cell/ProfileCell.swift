import UIKit

class ProfileCell: UITableViewCell {
    static let reuseIdentifier = String(describing: ProfileCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        configurateCell()
    }
    
    private func configurateCell() {
        backgroundColor = .primaryColor
        accessoryType = .disclosureIndicator
        textLabel?.textColor = .offWhiteColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
