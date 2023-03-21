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
    
    private func setupFormTextField() {
        placeholder = textExample
        layer.cornerRadius = 10
        layer.borderColor = UIColor.orange.cgColor
        layer.borderWidth = 1
        backgroundColor = UIColor(hexString: "404258")
        autocorrectionType = .no
    }
}
