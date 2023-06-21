import UIKit
import Domain

class ContactListCell: UITableViewCell {
    static let reuseIdentifier = String(describing: ContactListCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var circularView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 32
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(hexString: "0A2647")
        return view
    }()
    
    lazy var letterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.textColor = Colors.secundaryColor
        return label
    }()
    
    lazy var contactNameLabel: UILabel = {
       let label = UILabel()
        label.textColor = Colors.offWhiteColor
        label.minimumScaleFactor = 0.75
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var horiontalStack = makeHorizontalStack(with: [circularView, contactNameLabel], spacing: 10)
    
    func setupCell(contact: ContactModel) {
        contactNameLabel.text = contact.name
        letterLabel.text = contact.name.firtsLettersOfName()
    }
}

extension ContactListCell: CodeView {
    func buildViewHierarchy() {
        addSubview(horiontalStack)
        circularView.addSubview(letterLabel)
    }
    
    func setupConstrains() {
        letterLabel.superviewCenter()
        circularView.size(size: .init(width: 64, height: 64))
        horiontalStack.fillConstraints(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: 16, left: 16, bottom: 16, right: 16)
        )
    }

    func setupAdditionalConfiguration() {
        horiontalStack.alignment = .center
        backgroundColor = Colors.primaryColor
        selectionStyle = .none
    }
}
