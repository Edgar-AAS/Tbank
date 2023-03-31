import Foundation
import XCTest

class CurrencyFormatterTests: XCTestCase {
    func test_formatter_for_integer_values() {
        let integerValues: [Double] = [
            1, 2, 3,
            10, 20, 30,
            100, 200, 300,
            1000, 2000, 3000,
            10000, 20000, 30000,
            100000, 200000, 300000,
            1000000, 2000000, 3000000
        ]
        
        XCTAssertEqual(integerValues[0].currencyWith(symbol: .brazilianReal), "R$ 1,00")
        XCTAssertEqual(integerValues[1].currencyWith(symbol: .brazilianReal), "R$ 2,00")
        XCTAssertEqual(integerValues[2].currencyWith(symbol: .brazilianReal), "R$ 3,00")
        
        XCTAssertEqual(integerValues[3].currencyWith(symbol: .brazilianReal), "R$ 10,00")
        XCTAssertEqual(integerValues[4].currencyWith(symbol: .brazilianReal), "R$ 20,00")
        XCTAssertEqual(integerValues[5].currencyWith(symbol: .brazilianReal), "R$ 30,00")
        
        XCTAssertEqual(integerValues[6].currencyWith(symbol: .brazilianReal), "R$ 100,00")
        XCTAssertEqual(integerValues[7].currencyWith(symbol: .brazilianReal), "R$ 200,00")
        XCTAssertEqual(integerValues[8].currencyWith(symbol: .brazilianReal), "R$ 300,00")
        
        XCTAssertEqual(integerValues[9].currencyWith(symbol: .brazilianReal), "R$ 1.000,00")
        XCTAssertEqual(integerValues[10].currencyWith(symbol: .brazilianReal), "R$ 2.000,00")
        XCTAssertEqual(integerValues[11].currencyWith(symbol: .brazilianReal), "R$ 3.000,00")
        
        XCTAssertEqual(integerValues[12].currencyWith(symbol: .brazilianReal), "R$ 10.000,00")
        XCTAssertEqual(integerValues[13].currencyWith(symbol: .brazilianReal), "R$ 20.000,00")
        XCTAssertEqual(integerValues[14].currencyWith(symbol: .brazilianReal), "R$ 30.000,00")
        
        XCTAssertEqual(integerValues[15].currencyWith(symbol: .brazilianReal), "R$ 100.000,00")
        XCTAssertEqual(integerValues[16].currencyWith(symbol: .brazilianReal), "R$ 200.000,00")
        XCTAssertEqual(integerValues[17].currencyWith(symbol: .brazilianReal), "R$ 300.000,00")
        
        XCTAssertEqual(integerValues[18].currencyWith(symbol: .brazilianReal), "R$ 1.000.000,00")
        XCTAssertEqual(integerValues[19].currencyWith(symbol: .brazilianReal), "R$ 2.000.000,00")
        XCTAssertEqual(integerValues[20].currencyWith(symbol: .brazilianReal), "R$ 3.000.000,00")
    }
    
    func test_formatter_for_decimal_values() {
        let decimalValues: [Double] = [
            1.1, 2.2, 3.3,
            10.1, 20.2, 30.3,
            100.1, 200.2, 300.3,
            1000.1, 2000.2, 3000.3,
            10000.1, 20000.2, 30000.3,
            100000.1, 200000.2, 300000.3,
            1000000.1, 2000000.2, 3000000.3
        ]
        
        XCTAssertEqual(decimalValues[0].currencyWith(symbol: .brazilianReal), "R$ 1,10")
        XCTAssertEqual(decimalValues[1].currencyWith(symbol: .brazilianReal), "R$ 2,20")
        XCTAssertEqual(decimalValues[2].currencyWith(symbol: .brazilianReal), "R$ 3,30")
        
        XCTAssertEqual(decimalValues[3].currencyWith(symbol: .brazilianReal), "R$ 10,10")
        XCTAssertEqual(decimalValues[4].currencyWith(symbol: .brazilianReal), "R$ 20,20")
        XCTAssertEqual(decimalValues[5].currencyWith(symbol: .brazilianReal), "R$ 30,30")
        
        XCTAssertEqual(decimalValues[6].currencyWith(symbol: .brazilianReal), "R$ 100,10")
        XCTAssertEqual(decimalValues[7].currencyWith(symbol: .brazilianReal), "R$ 200,20")
        XCTAssertEqual(decimalValues[8].currencyWith(symbol: .brazilianReal), "R$ 300,30")
        
        XCTAssertEqual(decimalValues[9].currencyWith(symbol: .brazilianReal), "R$ 1.000,10")
        XCTAssertEqual(decimalValues[10].currencyWith(symbol: .brazilianReal), "R$ 2.000,20")
        XCTAssertEqual(decimalValues[11].currencyWith(symbol: .brazilianReal), "R$ 3.000,30")
        
        XCTAssertEqual(decimalValues[12].currencyWith(symbol: .brazilianReal), "R$ 10.000,10")
        XCTAssertEqual(decimalValues[13].currencyWith(symbol: .brazilianReal), "R$ 20.000,20")
        XCTAssertEqual(decimalValues[14].currencyWith(symbol: .brazilianReal), "R$ 30.000,30")
        
        XCTAssertEqual(decimalValues[15].currencyWith(symbol: .brazilianReal), "R$ 100.000,10")
        XCTAssertEqual(decimalValues[16].currencyWith(symbol: .brazilianReal), "R$ 200.000,20")
        XCTAssertEqual(decimalValues[17].currencyWith(symbol: .brazilianReal), "R$ 300.000,30")
        
        XCTAssertEqual(decimalValues[18].currencyWith(symbol: .brazilianReal), "R$ 1.000.000,10")
        XCTAssertEqual(decimalValues[19].currencyWith(symbol: .brazilianReal), "R$ 2.000.000,20")
        XCTAssertEqual(decimalValues[20].currencyWith(symbol: .brazilianReal), "R$ 3.000.000,30")
    }
    
    func test_formatter_for_centesimal_values() {
        let centesimalValues: [Double] = [
            10.01, 10.02, 10.03, 10.04, 10.05, 10.06, 10.07, 10.08, 10.09,
        ]
        
        XCTAssertEqual(centesimalValues[0].currencyWith(symbol: .brazilianReal), "R$ 10,01")
        XCTAssertEqual(centesimalValues[1].currencyWith(symbol: .brazilianReal), "R$ 10,02")
        XCTAssertEqual(centesimalValues[2].currencyWith(symbol: .brazilianReal), "R$ 10,03")
        
        XCTAssertEqual(centesimalValues[3].currencyWith(symbol: .brazilianReal), "R$ 10,04")
        XCTAssertEqual(centesimalValues[4].currencyWith(symbol: .brazilianReal), "R$ 10,05")
        XCTAssertEqual(centesimalValues[5].currencyWith(symbol: .brazilianReal), "R$ 10,06")
        
        XCTAssertEqual(centesimalValues[6].currencyWith(symbol: .brazilianReal), "R$ 10,07")
        XCTAssertEqual(centesimalValues[7].currencyWith(symbol: .brazilianReal), "R$ 10,08")
        XCTAssertEqual(centesimalValues[8].currencyWith(symbol: .brazilianReal), "R$ 10,09")
    }
}

