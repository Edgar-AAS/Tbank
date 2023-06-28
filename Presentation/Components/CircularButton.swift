import UIKit

final class CircularButton: UIButton {
    private let size: CGFloat
    private let image: UIImage?
    private let color: UIColor?
    private let tint: UIColor?
    
    init(size: CGFloat, image: UIImage?, backgroundColor: UIColor?, tintColor: UIColor?) {
        self.size = size
        self.image = image
        self.tint = tintColor
        self.color = backgroundColor
        super.init(frame: .zero)
        configureButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
    }
    
    private func configureButton() {
        setImage(image, for: .normal)
        backgroundColor = color
        tintColor = tint
        frame.size = .init(width: size, height: size)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

