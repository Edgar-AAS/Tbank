import UIKit

public class CardConfigurationViewController: UIViewController {
    var cardConfigurationView: CardConfigurationView?

    public override func loadView() {
        super.loadView()
        cardConfigurationView = CardConfigurationView()
        view = cardConfigurationView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
