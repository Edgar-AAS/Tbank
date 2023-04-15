import Foundation
import UIKit

extension UIImageView {
    func loadImageWith(path: String) {
        DispatchQueue.global().async { [weak self] in
            let image = UIImage(contentsOfFile: path)
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
    func loadImageWith(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

