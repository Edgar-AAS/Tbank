import Foundation

public enum CurrencySymbols: String {
    case brazilianReal = "R$"
    case americanDollar = "$"
    case euro = "€"
    case poundSterling = "£"
    case japaneseYen = "¥"
    case russianRuble = "₽"
    case swissFranc = "CHF"
    case canadianDollar = "CAD"
    case australianDollar = "AUD"
}

extension Double {
    public func currencyWith(symbol: CurrencySymbols) -> String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.currencySymbol = symbol.rawValue
        formatter.alwaysShowsDecimalSeparator = true
        return formatter.string(for: self) ?? "Não foi possível mostrar o saldo"
    }
}
