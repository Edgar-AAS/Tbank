import Foundation
import Domain

extension Card {
    var getDigitalCardFormmated: DigitalCardFormatter {
        return DigitalCardFormatter(
            cardNumber: getCardNumber,
            cardExpirationDate: getExpirationDate,
            name: getCardName
        )
    }
    
    var getPhysicalFormmated: PhysicalCardFormater {
        return PhysicalCardFormater(
            balance: getFormattedBalance,
            cardNumber: getCardNumber,
            expirationDate: getExpirationDate
        )
    }
    
    var getCardInformationFormatter: CardInformationFormatter {
        return CardInformationFormatter(
            name: name,
            cardFlag: cardFlag,
            cardNumber: cardNumber.formatString(),
            cardExpirationDate: getExpirationDate,
            cardFunction: cardFunction,
            cvc: cvc
        )
    }
    
    var getFormattedBalance: String {
        return balance.currencyWith(symbol: .brazilianReal)
    }
    
    var getExpirationDate: String {
        return cardExpirationDate.toShortDate()
    }
    
    var getCardNumber: String {
        return cardNumber.toSafeCardNumber()
    }
    
    var getCardName: String {
        return name.uppercased()
    }
}
