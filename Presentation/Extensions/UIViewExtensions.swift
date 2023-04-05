import UIKit

extension UIView {
    func addBottomLineWithColor(color: UIColor, widht: CGFloat) {
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: self.frame.height - widht, width: self.frame.width, height: widht)
        bottomLayer.backgroundColor = color.cgColor
        self.layer.addSublayer(bottomLayer)
    }
}
