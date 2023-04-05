import Foundation
import UIKit

extension UIImageView {
    func loadImageWith(path: String) {
        DispatchQueue.global().async {
            let image = UIImage(contentsOfFile: path)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}

extension UIImage {
    static func envelopeImage() -> UIImage {
        if let envelopeImage = UIImage(systemName: "envelope") {
            return envelopeImage
        } else {
            return UIImage()
        }
    }
    
    static func lockImage() -> UIImage {
        if let envelopeImage = UIImage(systemName: "lock") {
            return envelopeImage
        } else {
            return UIImage()
        }
    }
}


