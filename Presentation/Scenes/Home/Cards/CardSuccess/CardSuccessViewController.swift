import UIKit
import Domain

public class CardSuccessViewController: UIViewController {
    public var cardView: CardSuccessView?
    public var presenter: ViewToPresenterCardSuccessProtocol?
    
    public override func loadView() {
        super.loadView()
        cardView = CardSuccessView(self)
        view = cardView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        let backButton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
        if let cardViewController = navigationController?.viewControllers.last(where: { $0 is CardsViewProtocol}) {
            (cardViewController as? CardsViewController)?.isNeedUpdate = true
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

