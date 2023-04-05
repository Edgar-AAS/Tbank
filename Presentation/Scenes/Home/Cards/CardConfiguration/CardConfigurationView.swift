import UIKit

public class CardConfigurationView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        let deviceSreenHeight = UIScreen.main.bounds.height
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: deviceSreenHeight * 1.5)
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        return button
    }()
    
    lazy var descriptionLabel: UILabel = .descriptionLabel(titleText: "Dê um nome ao seu cartão digital!", subtitleText: "\nEscolha um nome que o identifique facilmente e que reflita o uso do seu cartão digital.", titleFontSize: 30, subtitleFontSize: 20, subtitleColor: .systemGray)
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
}

extension CardConfigurationView: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(descriptionLabel)
    }
    
    func setupConstrains() {
        scrollView.fillConstraints(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor
        )
                
        descriptionLabel.fillConstraints(
            top: scrollView.topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
    }
}
