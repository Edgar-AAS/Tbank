import Foundation

enum CardFunction: String {
    case credit = "Crédito"
    case debit = "Débito"
    case hybridCard = "Débito e Crédito"
}

struct CardGenerator {
    static let cardFlag = "MasterCard"
    
    static func createCardNumber() -> String {
        let randomNumbers = (0..<16).map { _ in String(arc4random_uniform(10)) }
        let numbersString = randomNumbers.joined()
        return numbersString
    }
    
    static func createCVC() -> String {
        let randomNumbers = (0..<3).map { _ in String(arc4random_uniform(10)) }
        let numbersString = randomNumbers.joined()
        return numbersString
    }
    
    static func getCardFunction(cardFunction: CardFunction) -> String {
        return cardFunction.rawValue
    }
    
    static func createCardExpirationDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        let yearsToAdd = 8
        let futureDate = calendar.date(byAdding: .year, value: yearsToAdd, to: date)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if let futureDate = futureDate {
            let expirationDate = dateFormatter.string(from: futureDate)
            return expirationDate
        }
        return "--/--"
    }
}
