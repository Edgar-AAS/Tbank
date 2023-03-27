import Foundation

extension String {
    func toSafeCardNumber() -> String {
        let subString = suffix(4)
        let asterisks = "**** "
        let string = asterisks.appending(subString)
        return string
    }
    
    func toShortDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let setFormatter = DateFormatter()
        setFormatter.dateFormat = "MM/yy"
        
        if let date = dateFormatter.date(from: self) {
            return setFormatter.string(from: date)
        }
        return "--/--"
    }
}
