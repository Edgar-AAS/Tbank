import UIKit

class FormTextField: UITextField {
    private var textExample: String?
    
    init(placeholder: String? = nil) {
        self.textExample = placeholder
        super.init(frame: .zero)
        setupFormTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupFormTextField() {
        placeholder = textExample
        layer.cornerRadius = 5
        layer.borderColor = UIColor.systemGreen.cgColor
        layer.borderWidth = 1
        backgroundColor = .systemGray6
    }
}
