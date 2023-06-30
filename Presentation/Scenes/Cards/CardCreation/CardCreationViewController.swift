import UIKit

public class CardCreationViewController: UIViewController {
    var cardCreationView: CardCreationView?
    
    public var goToCardConfiguration: (() -> Void)?
    
    public override func loadView() {
        super.loadView()
        cardCreationView = CardCreationView(self)
        view = cardCreationView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        removeBackButtonTitle()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension CardCreationViewController: CardCreationViewDelegateProtocol {
    func cardCreationButtonDidTapped() {
        goToCardConfiguration?()
    }
}
