import XCTest
import Main
import Validation

class CardConfigurationControllerTests: XCTestCase {
    func test_signUp_compose_with_correct_validations() {
        let validations = makeAddCardValidations()
        XCTAssertEqual(validations[0] as! RequiredFieldsValidation, RequiredFieldsValidation(fieldName: "name", fieldLabel: "de nome do cartão"))
    }
}
