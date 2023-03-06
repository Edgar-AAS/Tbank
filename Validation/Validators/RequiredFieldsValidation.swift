import Foundation
import Presentation

public final class RequiredFieldsValidation: Validation, Equatable {
    private let fieldName: String
    private let fieldLabel: String
    
    public init(fieldName: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
    }
    
    //se o fieldName tiver valor e nao for vazio return nil, else return errorMessage
   public func validate(data: [String : Any]?) -> String? {
        guard let fieldName = data?[fieldName] as? String, !fieldName.isEmpty else { return "O campo \(fieldLabel) é obrigatório" }
        return nil
   }
    
    public static func == (lhs: RequiredFieldsValidation, rhs: RequiredFieldsValidation) -> Bool {
        return lhs.fieldName == rhs.fieldName && lhs.fieldLabel == rhs.fieldLabel
    }
}
