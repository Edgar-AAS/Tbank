import Foundation

extension String {
    func toSafeCardNumber() -> String {
        let subString = suffix(4)
        let asterisks = "•••• "
        let string = asterisks.appending(subString)
        return string
    }
    
    func toShortDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let setFormatter = DateFormatter()
        setFormatter.dateFormat = "MM/yy"
        setFormatter.locale = Locale(identifier: "pt_BR")
        
        if let date = dateFormatter.date(from: self) {
            return setFormatter.string(from: date)
        }
        return "--/--"
    }
    
    func formatString() -> String {
        let formattedString = self.enumerated().map { (index, char) -> String in
            return (index > 0 && index % 4 == 0) ? " \(char)" : String(char)
        }.joined()
        return formattedString
    }
    
    func formatBankAccountNumber() -> String {
        let formattedString = self.enumerated().map { (index, char) -> String in
            return (index == self.count - 1) ? "-\(char)" : String(char)
        }.joined()
        return formattedString
    }
}
