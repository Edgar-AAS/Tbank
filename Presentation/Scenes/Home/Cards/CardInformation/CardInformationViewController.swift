import UIKit
import Domain

public protocol UpdateCardView: AnyObject {
    func update(cardViewModel: CardModel)
}

public class CardInformationViewController: UIViewController {
    lazy var cardInformationView: CardInformationView? = {
        return view as? CardInformationView
    }()
    
    var presenter: ViewToPresenterCardInformationViewProtocol?
    
    public override func loadView() {
        super.loadView()
        cardInformationView = CardInformationView()
        view = cardInformationView
        view.backgroundColor = .primaryColor
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.updateCardInformationView()
        title = "Cartão digital"
        let backButton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonTapped() {
        presenter?.popToCardController()
    }
}

extension CardInformationViewController: UpdateCardView {
    public func update(cardViewModel: CardModel) {
        cardInformationView?.updateUI(cardViewModel: cardViewModel)
    }
}
