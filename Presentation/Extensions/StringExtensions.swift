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
    
    func currencyInputFormatting() -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currencyAccounting
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
            
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        guard number != 0 as NSNumber else {
            return formatter.string(from: 0)!
        }

        
        print(formatter.string(from: number)!)
        return formatter.string(from: number)!
    }
    
    func removeCurrencyInputFormatting() -> Double {
        var number: NSNumber!
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        var amountWithPrefix = self
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        return number as! Double
    }
}
