//
//  ReadMoreLabel.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 13/08/2023.
//

import UIKit

//MARK: - TrailingContent...
enum TrailingContent {
    case readmore
    case readless

    var text: String {
        switch self {
        case .readmore: return "...Show more"
        case .readless: return " Show Less"
        }
    }
}

//MARK: - UILabel...
extension UILabel {
    
    //MARK: - Variables...
    private var minimumLines: Int { return 4 }
    private var highlightColor: UIColor { return UIColor(hex: "#E26A2B") }
    private var attributes: [NSAttributedString.Key: Any] { return [.font: Constants.applyFonts_DMSans(style: .Medium, size: 14)] }
    
    //MARK: - Functions...
    
    ///requiredHeight...
    public func requiredHeight(for text: String) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = minimumLines; label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        label.font = font; label.text = text; label.sizeToFit()
        return label.frame.height
    }
    
    ///highlight...
    func highlight(_ text: String, color: UIColor) {
        guard let labelText = self.text else { return }
        let range = (labelText as NSString).range(of: text)
        let mutableAttributedString = NSMutableAttributedString.init(string: labelText)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        self.attributedText = mutableAttributedString
    }
    
    ///appendReadmore...
    func appendReadmore(after text: String, trailingContent: TrailingContent) {
        self.numberOfLines = minimumLines
        let fourLineText = "\n\n\n"; let fourlineHeight = requiredHeight(for: fourLineText)
        let sentenceText = NSString(string: text); let sentenceRange = NSRange(location: 0, length: sentenceText.length)
        var truncatedSentence: NSString = sentenceText; var endIndex: Int = sentenceRange.upperBound
        let size: CGSize = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        while truncatedSentence.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size.height >= fourlineHeight {
            if endIndex == 0 { break }; endIndex -= 1
            truncatedSentence = NSString(string: sentenceText.substring(with: NSRange(location: 0, length: endIndex)))
            truncatedSentence = (String(truncatedSentence) + trailingContent.text) as NSString
        }; self.text = truncatedSentence as String; self.highlight(trailingContent.text, color: highlightColor)
    }
    
    ///appendReadLess...
    func appendReadLess(after text: String, trailingContent: TrailingContent) {
        self.numberOfLines = 0; self.text = text + trailingContent.text
        self.highlight(trailingContent.text, color: highlightColor)
    }
}


//MARK: - UITapGestureRecognizer....
extension UITapGestureRecognizer {

    //MARK: - Functions...
    
    ///didTap..
    func didTap(label: UILabel, inRange targetRange: NSRange) -> Bool {
        
        let layoutManager = NSLayoutManager(); let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        layoutManager.addTextContainer(textContainer); textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0; textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size; textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}



