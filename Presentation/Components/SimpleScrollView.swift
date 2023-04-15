//import UIKit
//
//class SimpleScrollView: UIScrollView {
//    private lazy var containerView: UIView = {
//        let element = UIView()
//        element.translatesAutoresizingMaskIntoConstraints = false
//        return element
//    }()
//    
//    init(spacing: CGFloat = 0,
//         margins: NSDirectionalEdgeInsets = .zero) {
//        super.init(frame: .zero)
//        containerView
//        containerStackView.directionalLayoutMargins = margins
//        setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func addSubview(_ view: UIView) {
//        containerStackView.addArrangedSubview(view)
//    }
//    
//    func addCustomSpace(spacing: CGFloat, afterView: UIView) {
//        containerStackView.setCustomSpacing(spacing, after: afterView)
//    }
//}
//
//extension SimpleScrollView: CodeView {
//    func buildViewHierarchy() {
//        super.addSubview(containerStackView)
//    }
//    
//    func setupConstrains() {
//        NSLayoutConstraint.activate([
//            containerStackView.topAnchor.constraint(equalTo: topAnchor),
//            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            containerStackView.widthAnchor.constraint(equalTo: widthAnchor)
//        ])
//        
//        let height = containerStackView.heightAnchor.constraint(equalTo: heightAnchor)
//        height.priority = .defaultLow
//        height.isActive = true
//    }
//}
