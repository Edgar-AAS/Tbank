import UIKit

extension UILabel {
    static func descriptionLabel(titleText: String?, subtitleText: String?, titleFontSize: CGFloat = 24, subtitleFontSize: CGFloat = 16, titleColor: UIColor = .black, subtitleColor: UIColor = .darkGray) -> UILabel {
        let label = UILabel()
        let titleColor = titleColor
        let subtitleColor = subtitleColor
        
        let titleFontSize = UIFont.boldSystemFont(ofSize: titleFontSize)
        let subtitleFontSize = UIFont.systemFont(ofSize: subtitleFontSize)
        
        let titleAttributes = [NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.font: titleFontSize]
        let subtitleAtributes = [NSAttributedString.Key.foregroundColor: subtitleColor, NSAttributedString.Key.font: subtitleFontSize]
        
        let title = NSMutableAttributedString(string: titleText ?? "", attributes: titleAttributes)
        let subtitle = NSMutableAttributedString(string: "\n\(subtitleText ?? "")", attributes: subtitleAtributes)
        
        title.addAttribute(.font, value: titleFontSize, range: NSRange(location: 0, length: title.length))
        title.addAttribute(.foregroundColor, value: titleColor, range: NSRange(location: 0, length: title.length))
        
        subtitle.addAttribute(.foregroundColor, value: subtitleColor, range: NSRange(location: 0, length: subtitle.length))
        subtitle.addAttribute(.font, value: subtitleFontSize, range: NSRange(location: 0, length: subtitle.length))

        title.append(subtitle)
        label.attributedText = title
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }
}
