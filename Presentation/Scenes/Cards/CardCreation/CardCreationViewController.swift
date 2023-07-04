import UIKit

public class CardCreationViewController: UIViewController {
    private lazy var cardCreationView: CardCreationView? = {
        return view as? CardCreationView
    }()

    public var goToCardConfiguration: (() -> Void)?
    
    public override func loadView() {
        super.loadView()
        view = CardCreationView(self)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        removeBackButtonTitle()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar()
    }
}

//MARK: - Delegate Actions
extension CardCreationViewController: CardCreationViewDelegateProtocol {
    func cardCreationButtonDidTapped() {
        goToCardConfiguration?()
    }
}
