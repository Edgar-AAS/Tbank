import Foundation
import Presentation

public final class CompareFieldsValidation: Validation, Equatable {
    private let fieldName: String
    private let fieldNameToCompare: String
    private let fieldLabel: String
    
    public init(fieldName: String, fieldNameToCompare: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
        self.fieldNameToCompare = fieldNameToCompare
    }
    
    //se o fieldName tiver valor e nao for vazio return nil else return errorMessage
    //tem valor no data?[fieldName]
    // esse valor é do tipo String?
    //se tiver valor entao veja se tem valor no data?[fieldName]
    // veja se ele é do tipo String e compare de sao iguais
    //se forem, retorne nil, senao retorne um Error message
    
    public func validate(data: [String : Any]?) -> String? {
        guard let fieldValue = data?[fieldName] as? String, let fieldValueToCompare = data?[fieldNameToCompare] as? String, fieldValue == fieldValueToCompare else { return "O campo \(fieldLabel) é inválido" }
        return nil
    }
    
    public static func == (lhs: CompareFieldsValidation, rhs: CompareFieldsValidation) -> Bool {
        return
            lhs.fieldName == rhs.fieldName &&
            lhs.fieldLabel == rhs.fieldLabel &&
            lhs.fieldNameToCompare == rhs.fieldNameToCompare
    }
}
