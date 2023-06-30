import UIKit

public final class TransferSuccessView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = Colors.primaryColor
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var checkMarkImageView: UIImageView = {
        let view = UIImageView(image: Icons.checkMark)
        view.contentMode = .scaleAspectFit
        view.tintColor = Colors.secundaryColor
        return view
    }()
    
    private lazy var imageBackView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var completedLabel: UILabel = {
        let view = UILabel()
        view.text = "Concluído"
        view.textAlignment = .center
        view.textColor = Colors.offWhiteColor
        view.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return view
    }()
    
    private lazy var transferSuccessDescriptionLabel: UILabel = {
        let view = UILabel()
        view.text = "Transferência realizada com sucesso!"
        view.textAlignment = .center
        view.minimumScaleFactor = 0.5
        view.adjustsFontSizeToFitWidth = true
        view.textColor = UIColor(hexString: "#cecece")
        view.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "0A2647")
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var balanceLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        view.textAlignment = .center
        view.textColor = Colors.offWhiteColor
        view.text = "R$ 350,00"
        return view
    }()
    
    private lazy var transferTimeLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = UIColor(hexString: "#cecece")
        view.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        view.text = "21/02/2018 às 09:48"
        return view
    }()
    
    private lazy var recipientName: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .center
        view.textColor = Colors.offWhiteColor
        view.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        view.text = "para Edgar Arlindo Almeida dos Santos"
        return view
    }()

    private lazy var sendReceiptButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Enviar comprovante", for: .normal)
        view.backgroundColor = Colors.secundaryColor
        view.setTitleColor(Colors.primaryColor, for: .normal)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        view.layer.cornerRadius = 25
        return view
    }()
    
    private lazy var contentStack = makeVerticalStack(with: [balanceLabel, transferTimeLabel, recipientName, sendReceiptButton], spacing: 8)
    
    func updateUI(with viewModel: TransferSuccessViewModel) {
        balanceLabel.text = viewModel.balance
        transferTimeLabel.text = "\(viewModel.currentDate) às \(viewModel.currentTime)"
        recipientName.text = "para \(viewModel.contactName)"
    }
}

extension TransferSuccessView: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        imageBackView.addSubview(checkMarkImageView)
        contentView.addSubview(contentStack)
        containerView.addSubview(imageBackView)
        containerView.addSubview(completedLabel)
        containerView.addSubview(transferSuccessDescriptionLabel)
        containerView.addSubview(contentView)
    }
    
    func setupConstrains() {
        scrollView.fillConstraints(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor
        )
        
        containerView.fillConstraints(
            top: scrollView.topAnchor,
            leading: scrollView.leadingAnchor,
            trailing: scrollView.trailingAnchor,
            bottom: scrollView.bottomAnchor
        )
        
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        imageBackView.fillConstraints(
            top: containerView.topAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 80, left: 0, bottom: 0, right: 0)
        )
        
        checkMarkImageView.superviewCenter(size: .init(width: 120, height: 120))
        
        checkMarkImageView.fillConstraints(
            top: imageBackView.topAnchor,
            leading: nil,
            trailing: nil,
            bottom: imageBackView.bottomAnchor
        )
        
        checkMarkImageView.centerXAnchor.constraint(equalTo: imageBackView.centerXAnchor).isActive = true
        
        completedLabel.fillConstraints(
            top: checkMarkImageView.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil
        )
        
        transferSuccessDescriptionLabel.fillConstraints(
            top: completedLabel.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 8, left: 20, bottom: 0, right: 20)
        )
                                
        contentView.fillConstraints(
            top: transferSuccessDescriptionLabel.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: containerView.bottomAnchor,
            padding: .init(top: 40, left: 20, bottom: 0, right: 20)
        )
        
        contentStack.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    func setupAdditionalConfiguration() {
        contentStack.setCustomSpacing(2, after: balanceLabel)
        contentStack.setCustomSpacing(20, after: recipientName)
    }
}
