import UIKit
import Domain

public class CardSuccessViewController: UIViewController {
    private lazy var cardView: CardSuccessView? = {
        return view as? CardSuccessView
    }()
    
    public var presenter: ViewToPresenterCardSuccessProtocol?
    
    public override func loadView() {
        super.loadView()
        view = CardSuccessView(self)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        removeBackButtonTitle()
        disableInteractivePopGesture()
    
        navigationItem.leftBarButtonItem = NavigationBackButton(target: self, action: #selector(backButtonTapped))
        
        if let cardViewController = navigationController?.viewControllers.last(where: { $0 is CardsViewProtocol}) {
            (cardViewController as? CardsViewController)?.isNeedUpdate = true
        }
        
        if let homeController = navigationController?.viewControllers.last(where: { $0 is HomeControllerProtocol}) {
            (homeController as? HomeController)?.isNeedUpdateCard = true
        }
    }
    
    @objc private func backButtonTapped() {
        presenter?.popToCardController()
    }
}

extension CardSuccessViewController: CardSuccessViewDelegate {
    func cardAcessbuttonDidTapped() {
        presenter?.goToCardInfo()
    }
}

