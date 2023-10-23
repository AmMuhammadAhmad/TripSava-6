//
//  SafariViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 08/06/2023.
//
 
import SafariServices

class SafariViewController: NSObject, SFSafariViewControllerDelegate {
    
    /// Singleton instance
    static let shared = SafariViewController()
    
    /// Open URL in Safari view controller
    func openUrlWith(linkString: String, Parentcontroller: UIViewController) {
        var link = linkString; link = link.trimmingCharacters(in: .whitespacesAndNewlines) 
        if !link.contains("https://") && !link.contains("http://") { link = "https://" + link }
        
        /// Try to create a URL from the link string
        if let url = URL(string: link) {
            let controller = SFSafariViewController(url: url)
            controller.delegate = self; Parentcontroller.present(controller, animated: true, completion: nil)
        } else { Parentcontroller.presentAlert(withTitle: "Alert", message: "Invalid URL: ") }
    }
    
    /// Delegate method when Safari view controller is dismissed
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

//MARK:- UITapGestureRecognizer
extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabell(label: UILabel, inRange targetRange: NSRange) -> Bool {
        /// Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        /// Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        /// Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        /// Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        
        ///let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.01 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        guard let attributedText = label.attributedText else { return false }
        
        let mutableStr = NSMutableAttributedString.init(attributedString: attributedText)
        mutableStr.addAttributes([NSAttributedString.Key.font : label.font!], range: NSRange.init(location: 0, length: attributedText.length))
        
        ///If the label have text alignment. Delete this code if label have a default (left) aligment. Possible to add the attribute in previous adding.
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        mutableStr.addAttributes([NSAttributedString.Key.paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: attributedText.length))
        
        /// Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: mutableStr)
        
        /// Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        /// Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        /// Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x ,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
    
    
}

extension UITapGestureRecognizer {
    func didTapAttributedTexts(in label: UILabel, inRange targetRange: NSRange) -> Bool {
        
        /// Create instances of NSLayoutManager, NSTextContainer, and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: .zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText ?? NSAttributedString())

        /// Configure the layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        /// Configure the textContainer size and exclusion path if needed
        textContainer.size = label.bounds.size
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines

        /// Check if the tap location falls within the targetRange
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (label.bounds.size.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (label.bounds.size.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer,
                                                            in: textContainer,
                                                            fractionOfDistanceBetweenInsertionPoints: nil)

        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
