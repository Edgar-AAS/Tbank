import Foundation
import Domain

enum CardFunction: String {
    case credit = "Crédito"
    case debit = "Débito"
    case hybridCard = "Débito e Crédito"
}

struct CardGenerator {
    private let cardFlag = "Gold"
    
    private func createCardNumber() -> String {
        let randomNumbers = (0..<16).map { _ in String(arc4random_uniform(10)) }
        let numbersString = randomNumbers.joined()
        return numbersString
    }
    
    private func createCVC() -> String {
        let randomNumbers = (0..<3).map { _ in String(arc4random_uniform(10)) }
        let numbersString = randomNumbers.joined()
        return numbersString
    }
    
    private func getCardFunction(cardFunction: CardFunction) -> String {
        return cardFunction.rawValue
    }
    
    private func createCardExpirationDate() -> String {
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
    
    func createDigitalCardWith(name: String) -> Card {
        return Card(isVirtual: true,
                        balance: 0.0,
                        cardFlag: cardFlag,
                        cardTag: 0,
                        cardBrandImageURL: "",
                        cardNumber: createCardNumber(),
                        cardExpirationDate: createCardExpirationDate(),
                        cardFunction: getCardFunction(cardFunction: .hybridCard),
                        cvc: createCVC(),
                        id: "",
                        name: name)
    }
}
