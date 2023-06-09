import UIKit

final class PixAreaDescriptionCell: UITableViewCell {
    static let reuseIdentifier = String(describing: PixAreaDescriptionCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var pixAreaDescriptionLabel: UILabel = .descriptionLabel(titleText: "Área Pix",
                                                                          subtitleText: "\nExperimente a liberdade do PIX: envie e receba pagamentos a qualquer hora, sem taxas!",
                                                                          titleFontSize: 30,
                                                                          subtitleFontSize: 20,
                                                                          titleColor: Colors.offWhiteColor,
                                                                          subtitleColor: UIColor(hexString: "#cecece"))
}

extension PixAreaDescriptionCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(pixAreaDescriptionLabel)
    }

    func setupConstrains() {
        pixAreaDescriptionLabel.fillConstraints(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            bottom: contentView.bottomAnchor,
            padding: .init(top: 8, left: 20, bottom: 20, right: 20)
        )
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = Colors.primaryColor
    }
}


