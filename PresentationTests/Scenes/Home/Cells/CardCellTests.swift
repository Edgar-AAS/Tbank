import XCTest
import Presentation

class CardCellTests: XCTestCase {
    func test_addCardButtonDelegate_is_called_on_buttonTap() {
        let sut = CardCell()
        let addCardButtonDelegateSpy = AddCardButtonDelegateSpy()
        sut.delegate = addCardButtonDelegateSpy
        sut.addCardButton.simulateTap()
        XCTAssertEqual(addCardButtonDelegateSpy.isCalled, true)
    }
}

class AddCardButtonDelegateSpy: AddCardButtonDelegateProtocol {
    private(set) var isCalled = false
    
    func addCardButtonDidTapped() {
        isCalled = true
    }
}
