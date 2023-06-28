import Foundation
import UIKit


enum HeaderHeights {
    static let small: CGFloat = 100
    static let medium: CGFloat = 200
    static let large: CGFloat = 300
}

enum CircularButtonSize {
    static let small: CGFloat = 36
    static let medium: CGFloat = 64
    static let large: CGFloat = 120
}

enum FileManagerPaths {
    static let userImage = "userImage"
}

enum Icons {
    static let arrow_foward = UIImage(systemName: "arrow.forward")
    static let bell = UIImage(systemName: "bell")
    static let plus = UIImage(systemName: "plus")
    static let transfer = UIImage(systemName: "dock.arrow.up.rectangle")
    static let calendar = UIImage(systemName: "calendar")
    static let copyPaste = UIImage(systemName: "square.on.square")
    static let qrCode = UIImage(systemName: "qrcode")
    static let checkMark = UIImage(systemName: "checkmark.circle.fill")
    
    enum Url {
        static let arrow_foward = "arrow.forward"
        static let bell = "bell"
        static let plus = "plus"
        static let transfer = "dock.arrow.up.rectangle"
        static let calendar = "calendar"
        static let copyPaste = "square.on.square"
        static let qrCode = "qrcode"
        static let demand = "dollarsign.square"
        static let deposit = "dock.arrow.down.rectangle"
    }
}

enum Colors {
    static let primaryColor = UIColor(hexString: "1A1A2E")
    static let secundaryColor = UIColor(hexString: "EBB52F")
    static let offWhiteColor = UIColor(hexString: "#F8F8FF")
}
