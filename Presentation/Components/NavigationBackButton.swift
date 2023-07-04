import Foundation
import UIKit

class NavigationBackButton: UIBarButtonItem {
    init(title: String, target: AnyObject?, action: Selector?) {
        super.init()
        self.title = title
        self.target = target
        self.action = action
    }
    
    convenience init(target: AnyObject?, action: Selector?) {
        self.init(title: "Voltar", target: target, action: action)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
