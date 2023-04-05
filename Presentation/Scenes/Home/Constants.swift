import Foundation
import UIKit

enum HeaderHeight: CGFloat {
    case small = 100
    case medium = 200
    case large = 300
}

enum CircularButtonSize: CGFloat {
    case small = 36
    case medium = 64
    case large = 120
}

struct K {
    struct PathComponents {
        static let userImage = "userImage"
    }

    struct ViewsSize {
        struct Header {
            static let smallHeight = HeaderHeight.small.rawValue
            static let mediumHeight = HeaderHeight.medium.rawValue
            static let largeHeight = HeaderHeight.large.rawValue
        }
        
        struct CircularButton {
            static let small = CircularButtonSize.small.rawValue
            static let medium = CircularButtonSize.medium.rawValue
            static let large = CircularButtonSize.large.rawValue
        }
    }
}
