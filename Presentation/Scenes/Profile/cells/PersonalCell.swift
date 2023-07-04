import UIKit

class PersonalCell: UITableViewCell {
    static let reuseIdentifier = String(describing: PersonalCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = Colors.primaryColor
        accessoryType = .disclosureIndicator
        textLabel?.textColor = Colors.offWhiteColor
    }
    
    func configureCellWith(viewModel: PersonalDataViewModel) {
        textLabel?.text = viewModel.infoName
        detailTextLabel?.text = viewModel.infoValue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
