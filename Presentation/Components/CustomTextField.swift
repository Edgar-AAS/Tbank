import UIKit

class CustomTextField: UITextField {
    private let padding: CGFloat = 45
    
    private let placeholderText: String
    
    init(placeholderText: String = "") {
        self.placeholderText = placeholderText
        super.init(frame: .zero)
        configurate()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurate() {
        placeholder = placeholderText
        tintColor = .secundaryColor
        textColor = .white
        backgroundColor = UIColor(hexString: "0A2647")
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.secundaryColor.cgColor
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: attributes)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: padding, y: 0, width: bounds.width, height: bounds.height)
        return bounds
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: padding, y: 0, width: bounds.width, height: bounds.height)
        return bounds
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: padding, y: 0, width: bounds.width, height: bounds.height)
        return bounds
    }
}
