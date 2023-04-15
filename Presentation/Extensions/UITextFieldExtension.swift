import UIKit

extension UITextField {
    func setupLeftImageView(image: UIImage, with color: UIColor) {
        let leftImage = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
        leftImage.frame = CGRect(x: 10, y: self.frame.height / 2 + 12, width: 25, height: 20)
        self.addSubview(leftImage)
        tintColor = color
    }
}
