//
//  Extension.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 05/06/2023.
//

import UIKit
import RappleProgressHUD
import MessageUI



//MARK: - TextField...

class TextField: UITextField {
    @IBInspectable var insetX: CGFloat = 0
    @IBInspectable var insetY: CGFloat = 0
    
    // Placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX))
    }
    
    // Text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX))
    }
}

class TextFieldWithImage: UITextField {
    @IBInspectable var insetX: CGFloat = 0
    @IBInspectable var insetY: CGFloat = 0
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX + 40))
    }
    
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX + 40))
    }
}


//MARK: - @IBDesignable UIView...

//@IBDesignable
class DesignableView: UIView { }

//@IBDesignable
class DesignableButton: UIButton { }

//@IBDesignable
class DesignableLabel: UILabel{ }

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat { get { return layer.cornerRadius } set { layer.cornerRadius = newValue } }
    
    @IBInspectable
    var borderWidth: CGFloat{ get { return layer.borderWidth } set { layer.borderWidth = newValue } }
    
    @IBInspectable
    var borderColor: UIColor?{
        get { if let color = layer.borderColor { return UIColor(cgColor: color) }; return nil }
        set { if let color = newValue { layer.borderColor = color.cgColor } else { layer.borderColor = nil } }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat{ get { return layer.shadowRadius } set { layer.shadowRadius = newValue } }
    
    @IBInspectable
    var shadowOpacity: Float { get { return layer.shadowOpacity } set { layer.shadowOpacity = newValue } }
    
    @IBInspectable
    var shadowOffset: CGSize { get { return layer.shadowOffset } set { layer.shadowOffset = newValue } }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get { if let color = layer.shadowColor { return UIColor(cgColor: color) }; return nil }
        set{ if let color = newValue { layer.shadowColor = color.cgColor } else { layer.shadowColor = nil } }
    }
    
    ////topCornerRadius...
    @IBInspectable var topCornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            layer.masksToBounds = true
        }
    }
    
    ///addsubViewWithConstraints..
    func addsubViewWithConstraints(subView: UIView ,topAnchor: NSLayoutYAxisAnchor? = nil ,leadingAnchor: NSLayoutXAxisAnchor? = nil, trailingAnchor: NSLayoutXAxisAnchor? = nil, bottomAnchor: NSLayoutYAxisAnchor? = nil, centerXAnchor: NSLayoutXAxisAnchor? = nil, centerYAnchor: NSLayoutYAxisAnchor? = nil, widthAnchor: CGFloat? = nil, heightAnchor: CGFloat? = nil, topAnchorConstant: CGFloat? = nil, leadingAnchorConstant: CGFloat? = nil, trailingAnchorConstant: CGFloat? = nil, bottomAnchorConstant: CGFloat? = nil, centerXAnchorConstant: CGFloat? = nil, centerYAnchorConstant: CGFloat? = nil, insertAt: Int? = 0){
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(subView, at: insertAt ?? 0)
        
        if let topAnchor = topAnchor { subView.topAnchor.constraint(equalTo: topAnchor, constant: topAnchorConstant ?? 0).isActive = true }
        if let leadingAnchor = leadingAnchor { subView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingAnchorConstant ?? 0).isActive = true }
        if let trailingAnchor = trailingAnchor { subView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingAnchorConstant ?? 0).isActive = true }
        if let bottomAnchor = bottomAnchor { subView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomAnchorConstant ?? 0).isActive = true }
        if let widthAnchor = widthAnchor { subView.widthAnchor.constraint(equalToConstant: widthAnchor).isActive = true }
        if let heightAnchor = heightAnchor { subView.heightAnchor.constraint(equalToConstant: heightAnchor).isActive = true }
        if let centerXAnchor = centerXAnchor { subView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: centerXAnchorConstant ?? 0).isActive = true }
        if let centerYAnchor = centerYAnchor { subView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: centerYAnchorConstant ?? 0).isActive = true }
    }
    
    ///addWidthHeightConstraints...
    func addWidthHeightConstraints(view: UIView, widthAnchor: CGFloat? = nil, heightAnchor: CGFloat? = nil){
        view.translatesAutoresizingMaskIntoConstraints = false
        if let widthAnchor = widthAnchor { view.widthAnchor.constraint(equalToConstant: widthAnchor).isActive = true }
        if let heightAnchor = heightAnchor { view.heightAnchor.constraint(equalToConstant: heightAnchor).isActive = true }
    }
    
    ///addCenterToSulerViewConstraints..
    func addCenterToSulerViewConstraints(view: UIView, centerXAnchor: NSLayoutXAxisAnchor? = nil, centerYAnchor: NSLayoutYAxisAnchor? = nil, centerXAnchorConstant: CGFloat? = nil, centerYAnchorConstant: CGFloat? = nil, insertAt: Int? = 0){
        view.translatesAutoresizingMaskIntoConstraints = false
        if let centerXAnchor = centerXAnchor { view.centerXAnchor.constraint(equalTo: centerXAnchor, constant: centerXAnchorConstant ?? 0).isActive = true }
        if let centerYAnchor = centerYAnchor { view.centerYAnchor.constraint(equalTo: centerYAnchor, constant: centerYAnchorConstant ?? 0).isActive = true }
    }
    
    ///circle...
    func circle() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    ///roundCorners...
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    ///animateFromBottom...
    func animateFromBottom(to finalPositionY: CGFloat, duration: TimeInterval = 0.5, completion: (() -> Void)? = nil) {
        let initialFrame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: bounds.width, height: bounds.height)
        frame = initialFrame; UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            self.frame.origin.y = finalPositionY }, completion: { _ in  completion?()   })
    }
    
    
    ///animateHideToBottom...
    func animateHideToBottom(duration: TimeInterval = 0.5, completion: (() -> Void)? = nil) {
        let finalFrame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: bounds.width, height: bounds.height)
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            self.frame = finalFrame }, completion: { _ in completion?() })
    }
    
    
    ///attributedTextWithMarkdownStyleFormatting...
    
    func attributedTextWithMarkdownStyleFormatting(_ text: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: text); let asterisk = "*"
        var searchRange = NSRange(location: 0, length: attributedText.length)
        
        while searchRange.location < attributedText.length {
            if let startRange = attributedText.string.range(of: asterisk, options: [], range: Range(searchRange, in: attributedText.string), locale: nil) {
                if let endRange = attributedText.string.range(of: asterisk, options: [], range: startRange.upperBound..<attributedText.string.endIndex, locale: nil) {
                    let startIndex = attributedText.string.distance(from: attributedText.string.startIndex, to: startRange.lowerBound)
                    let endIndex = attributedText.string.distance(from: attributedText.string.startIndex, to: endRange.lowerBound)
                    let range = NSRange(location: startIndex, length: endIndex - startIndex)
                    
                    /// Apply bold formatting
                    attributedText.addAttribute(.font, value: Constants.applyFonts_DMSans(style: .Medium, size: 17), range: range)
                    
                    /// Remove asterisks
                    attributedText.replaceCharacters(in: NSRange(location: startIndex, length: 1), with: NSAttributedString(string: ""))
                    attributedText.replaceCharacters(in: NSRange(location: endIndex - 1, length: 1), with: NSAttributedString(string: ""))
                    searchRange.location = endIndex - 2; searchRange.length = attributedText.length - searchRange.location
                } else { break  }
            } else {
                let nonBoldRange = NSRange(location: searchRange.location, length: 1)
                attributedText.addAttribute(.font, value: Constants.applyFonts_DMSans(style: .regular, size: 14), range: nonBoldRange)
                searchRange.location += 1; searchRange.length = attributedText.length - searchRange.location
            }
        }; return attributedText
    }
    
    
    
    
}

//MARK: - UITextField...
extension UITextField {
    
    ///placeHolderColor...
    @IBInspectable var placeHolderColor: UIColor? {
        get { return self.placeHolderColor }
        set { self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!]) }
    }
    
    func trimText() -> String {
        return self.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }
    
    func setEmpty(){ self.text = "" }
    
    func isEmptyTextField() -> Bool {
        if self.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" { return true } else { return false}
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self.text)
    }
    
    func isValidPassword() -> Bool {
        // Minimum 8 and Maximum 20 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character:
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,20}$"
        let passwordPred =  NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPred.evaluate(with: self.text)
    }
    
    ///isPasswordValid..
    func isPasswordValid() -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: self.text)
    }
    
    ///isPasswordInRange...
    func isPasswordInRange(range: Int = 7 ) -> Bool {
        if (self.text?.count ?? 0) <= range { return true } else { return false }
    }
    
    ///isPasswordInRange...
    func isInRange(range: Int = 7 ) -> Bool {
        print(self.text?.count ?? 0)
        print(range)
        if (self.text?.count ?? 0) <= range { return false } else { return true }
    }
    
    ///addSuggestedFields..
    func addSuggestedFields(suggestions: [String]) {
        let suggestionsToolbar = UIToolbar(); suggestionsToolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        var suggestionButtons: [UIBarButtonItem] = []
        for suggestion in suggestions {
            let suggestionButton = UIBarButtonItem(title: suggestion, style: .plain, target: self, action: #selector(suggestionTapped(_:)))
            suggestionButtons.append(suggestionButton)
        }
        suggestionsToolbar.items = [flexibleSpace] + suggestionButtons + [flexibleSpace]
        inputAccessoryView = suggestionsToolbar
    }
    
    ///suggestionTapped...
    @objc private func suggestionTapped(_ sender: UIBarButtonItem) {
        if let tappedSuggestion = sender.title { self.text = tappedSuggestion }
    }
    
}

///UITextField...
extension UITextView {
    func isEmptyTextView() -> Bool {
        if self.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" { return true } else { return false}
    }
}

//MARK: - UIViewController...
extension UIViewController {
    
    ///pushViewControllerWithStoryboardAndIdentifier
    func pushViewController(storyboard: String ,identifier: String, hidesBottomBarWhenPushed: Bool = true) {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier)
        controller.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    ///showCustomView...
    func showCustomView(firstBtnTitle: String, secondBtntext: String, message: String, yesAction: @escaping () -> Void, noAction: (() -> Void)? = nil) {
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        controller.modalPresentationStyle = .overFullScreen; controller.modalTransitionStyle = .crossDissolve
        controller.firstBtnTitle = firstBtnTitle; controller.secondBtntext = secondBtntext; controller.message = message
        controller.yesAction = yesAction; controller.noAction = noAction
        self.present(controller, animated: true, completion: nil)
    }
    
    ///showCustomMessageView...
    func showCustomMessageView(attributedString: NSMutableAttributedString, closeBtnAction: @escaping () -> Void) {
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MessageViewController") as! MessageViewController
        controller.modalPresentationStyle = .overFullScreen; controller.modalTransitionStyle = .crossDissolve
        controller.attributedString = attributedString; controller.closeBtnAction = closeBtnAction
        self.present(controller, animated: true, completion: nil)
    }
    
    ///showSimpleCustomMessageView...
    func showSimpleCustomMessageView(message: String, labelFont: UIFont, msgColor: UIColor, btnText: String, closeBtnAction: @escaping () -> Void) {
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SimpleMsgAlertViewController") as! SimpleMsgAlertViewController
        controller.modalPresentationStyle = .overFullScreen; controller.modalTransitionStyle = .crossDissolve
        controller.message = message; controller.labelFont = labelFont; controller.msgColor = msgColor; controller.btnText = btnText
        self.present(controller, animated: true, completion: nil)
    }
    
    ///showCustomMessageView...
    func showCustomDeletMessageView(message: String, deleteBtnAction: @escaping () -> Void) {
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DeleteShoppingListViewController") as! DeleteShoppingListViewController
        controller.modalPresentationStyle = .overFullScreen; controller.modalTransitionStyle = .crossDissolve
        controller.message = message; controller.deleteBtnAction = deleteBtnAction
        self.present(controller, animated: true, completion: nil)
    }
    
    ///getAttributedString...
    func getAttributedString(message: String, msgColor: UIColor, msgFont: UIFont, boldTextList: [String], boldTextColorsList: [UIColor], boldTextFontsList: [UIFont])-> NSMutableAttributedString {
        let msg = message; let attributedString = NSMutableAttributedString(string: msg)
        
        let completetxtrange = (msg as NSString).range(of: msg)
        attributedString.addAttributes( [NSAttributedString.Key.font: msgFont , NSAttributedString.Key.foregroundColor : msgColor], range: completetxtrange)
        
        for (index, boldText) in boldTextList.enumerated() {
            let range = (msg as NSString).range(of: boldText)
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor : boldTextColorsList[index], NSAttributedString.Key.font : boldTextFontsList[index]], range: range)
        }
        return attributedString
        
    }
    
    ///removeSpecificControllerForNavigationStack...
    func removeSpecificControllerForNavigationStack(wantedToDeleteThatController: Swift.AnyClass, fromNavigationController: UINavigationController) {
        
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: wantedToDeleteThatController) {
                self.navigationController?.viewControllers.removeAll(where: { (VC) -> Bool in
                    if VC == controller{ return true } else { return false }
                })
            }
        }
    }
    
    func showAddNewTrip(firstBtnTitle: String, secondBtntext: String, message: String, yesAction: @escaping () -> Void) {
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        controller.modalPresentationStyle = .overFullScreen; controller.modalTransitionStyle = .crossDissolve
        controller.firstBtnTitle = firstBtnTitle; controller.secondBtntext = secondBtntext; controller.message = message
        controller.yesAction = yesAction
        self.present(controller, animated: true, completion: nil)
    }
    
    ///popViewController...
    func popViewController(animated: Bool = true){ self.navigationController?.popViewController(animated: animated) }
    
    ///popToRootViewController...
    func popToRootViewController(){ self.navigationController?.popToRootViewController(animated: true) }
    
    ///getDeviceModel...
    func getDeviceModel() -> String { let device = UIDevice.current; return device.model }
    
    ///setNewRootViewController...
    func setNewRootViewController(storyboard: String ,identifier: String, hidesBottomBarWhenPushed: Bool = true) {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier)
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBar.isHidden = true
        self.window?.rootViewController = navigationController
    }
    
    ///window..
    var window: UIWindow? {
        if #available(iOS 13, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return nil }
            return window
        }
        return self.window
    }
    
    ///addChildViewController...
    func addChildViewController(_ childViewController: UIViewController, toView containerView: UIView) {
        addChild(childViewController)
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(childViewController.view)
        
        NSLayoutConstraint.activate([
            childViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            childViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            childViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            childViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        childViewController.didMove(toParent: self)
    }
    
    ///removeChildViewController...
    func removeChildViewController(_ childViewController: UIViewController) {
        childViewController.willMove(toParent: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParent()
    }
    
    ///switchToViewController...
    func switchToViewController(viewController: UIViewController, containerView: UIView) {
        if let currentViewController = children.first { removeChildViewController(currentViewController) }
        addChildViewController(viewController, toView: containerView)
    }
    
    //presentAlert..
    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in self.dismiss(animated: true)}
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    ///presentAlertAndGoToSpecificConyroller...
    func presentAlertAndGoToSpecificConyroller(message : String, storyboard: String, identifier: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            self.pushViewController(storyboard: storyboard, identifier: identifier)
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    ///presentAlert...
    
    func presentAlertAndGoToViewController(withTitle title: String, message : String, storyboardName: String, idetifier: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            self.pushViewController(storyboard: storyboardName, identifier: idetifier)
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    ///presentAlertAndBackToPreviousView...
    func presentAlertAndBackToPreviousView(withTitle title: String, message : String, controller: UIViewController) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            controller.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    ///presentAlertAndBackToRootView...
    func presentAlertAndBackToRootView(withTitle title: String, message : String, controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            controller.navigationController?.popToRootViewController(animated: true)
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    ///popToPreviousSpecificController...
    func popToPreviousSpecificController(popController: AnyClass){
        guard let popController = self.getSpecificControllerForNavigationStack(wantedController: popController, fromNavigationController: self.navigationController!)
        else { self.navigationController?.popToRootViewController(animated: true); return }
        self.navigationController?.popToViewController(popController, animated: true)
    }
    
    ///getSpecificControllerForNavigationStack...
    func getSpecificControllerForNavigationStack(wantedController: Swift.AnyClass, fromNavigationController: UINavigationController)-> UIViewController? {
        for controller in self.navigationController!.viewControllers as Array { if controller.isKind(of: wantedController) { return controller } }
        return nil
    }
    
    ///presentAlertAndGotoThatFunction...
    func presentAlertAndGotoThatFunction(withTitle title: String, message : String, OKAction: UIAlertAction) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    ///presentAlertAndGotoThatFunction...
    func presentAlertAndGotoThatYesNoFunction(withTitle title: String, message : String, OKAction: UIAlertAction) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(OKAction)
        let noButton = UIAlertAction(title: "No", style: .default) { isComplcted in  }
        alertController.addAction(noButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    ///emptyTextField...
    func emptyTextField(textFields: [TextField]) {
        textFields.forEach { txt in txt.text = "" }
    }
    
    ///showHud..
    func showRappleActivity() { RappleActivityIndicatorView.startAnimating() }
    
    ///showRappleActivityWithLabel...
    func showRappleActivityWithLabel(msg: String) {
        RappleActivityIndicatorView.startAnimatingWithLabel(msg)
    }
    
    ///hideHUD..
    func hideRappleActivity() { RappleActivityIndicatorView.stopAnimation() }
    
    ///generatePDFWithItemsList...
    func generatePDFWithItemsList(itemsList: [String], projectTitle: String, subHeader: String) -> Data? {
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRect.zero, nil); UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: 612, height: 792), nil)
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle; paragraphStyle.lineSpacing = 20
        let headerAttributes: [NSAttributedString.Key: Any] = [ .font: Constants.applyFonts_DMSans(style: .bold, size: 20), .paragraphStyle: paragraphStyle ]
        let itemsAttributes: [NSAttributedString.Key: Any] = [ .font: Constants.applyFonts_DMSans(style: .regular, size: 14), .paragraphStyle: paragraphStyle ]
        let subHeaderAttributes: [NSAttributedString.Key: Any] = [ .font: Constants.applyFonts_DMSans(style: .Medium, size: 14), .paragraphStyle: paragraphStyle ]
        let lineHeight = "Sample".size(withAttributes: headerAttributes).height; var yPosition: CGFloat = 100
        let headerTitle = NSAttributedString(string: projectTitle, attributes: headerAttributes)
        let headerWidth = headerTitle.size().width
        let headerXPosition = (612 - headerWidth) / 2
        let headerRect = CGRect(x: headerXPosition, y: yPosition, width: headerWidth, height: lineHeight)
        headerTitle.draw(in: headerRect); yPosition += lineHeight
        
        // Calculate the width of the subheader to center it
        let subHeaderTitle = NSAttributedString(string: subHeader, attributes: subHeaderAttributes)
        let subHeaderWidth = subHeaderTitle.size().width
        let subHeaderXPosition = (612 - subHeaderWidth) / 2 // Center the subheader on the page
        let subHeaderRect = CGRect(x: subHeaderXPosition, y: yPosition + 10, width: subHeaderWidth, height: lineHeight)
        subHeaderTitle.draw(in: subHeaderRect); yPosition += lineHeight + 30
        
        for (index, item) in itemsList.enumerated() {
            let textRect = CGRect(x: 50, y: yPosition, width: 512, height: lineHeight)
            item.draw(in: textRect, withAttributes: itemsAttributes); yPosition += lineHeight + 12
            if index < itemsList.count { drawSeparatorLine(at: yPosition); yPosition += 20 }
        }
        UIGraphicsEndPDFContext(); return pdfData as Data
    }
    
    ///drawSeparatorLine...
    private func drawSeparatorLine(at yPosition: CGFloat) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(UIColor.lightGray.cgColor)
        context.setLineWidth(1.0); context.move(to: CGPoint(x: 50, y: yPosition))
        context.addLine(to: CGPoint(x: 562, y: yPosition)); context.strokePath()
    }
    
    ///getTimeAgo...
    func getTimeAgo(from dateString: String) -> String {
        let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let postedDate = dateFormatter.date(from: dateString) {
            let currentTimeStamp = Date(); let yearsAgo = currentTimeStamp.years(from: postedDate)
            let monthAgo = currentTimeStamp.months(from: postedDate); let daysAgo = currentTimeStamp.days(from: postedDate)
            let hoursAgo = currentTimeStamp.hours(from: postedDate); let minutesAgo = currentTimeStamp.minutes(from: postedDate)
            if yearsAgo != 0 { return (yearsAgo <= 1) ? "Last updated a year ago" : "Last updated \(yearsAgo) years ago" }
            else if monthAgo != 0 { return (monthAgo <= 1) ? "Last updated a month ago" : "Last updated \(monthAgo) months ago" }
            else if daysAgo != 0 { return (daysAgo <= 1) ? "Last updated a day ago" : "Last updated \(daysAgo) days ago" }
            else if hoursAgo != 0 {  return (hoursAgo <= 1) ? "Last updated an hour ago" : "Last updated \(hoursAgo) hours ago" }
            else if minutesAgo != 0 { return (minutesAgo <= 1) ? "Last updated a minute ago" : "Last updated \(minutesAgo) minutes ago" }
            else { return "Last updated a few seconds ago" }
        } else { return "Invalid date format" }
    }
    
    ///estimatedTextHeight...
    func estimatedTextHeight(for text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let maxSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        let attributes: [NSAttributedString.Key: Any] = [ .font: font ]
        let boundingRect = NSString(string: text).boundingRect(with: maxSize, options: options, attributes: attributes, context: nil)
        return ceil(boundingRect.height)
    }
    
    func estimatedTextWidth(for text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let maxSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        let attributes: [NSAttributedString.Key: Any] = [ .font: font ]
        let boundingRect = NSString(string: text).boundingRect(with: maxSize, options: options, attributes: attributes, context: nil)
        return ceil(boundingRect.width)
    }
    
    ///getDateFormatedString...
    func getDateFormatedString(startDate: Date, endDate: Date ) -> String {
        let formattedFirstDate = startDate.formattedString(with: "MMM dd")
        let formattedSecondDate = endDate.formattedString(with: "MMM dd")
        let dateRangeText = "\(formattedFirstDate) - \(formattedSecondDate)"
        return dateRangeText
    }
    
    func getDaysAndNightsString(datesRange: [Date])-> String{
        let dateRangeCount = datesRange.count
        let nightsCount = dateRangeCount > 1 ? dateRangeCount - 1 : 0
        let daysText = dateRangeCount > 1 ? "days" : "day"
        let nightsText = nightsCount > 1 ? "nights" : "night"
        let dateRangeLabelText = "\(dateRangeCount) \(daysText) (\(nightsCount) \(nightsText))"
        return dateRangeLabelText
    }
    
    ///formatDateWithFromToAndDays...
    func formatDateWithFromToAndDays(startDateString: String, endDateString: String) -> String? {
        let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        if let startDate = dateFormatter.date(from: startDateString), let endDate = dateFormatter.date(from: endDateString) {
            let calendar = Calendar.current; let components = calendar.dateComponents([.day], from: startDate, to: endDate)
            
            if let days = components.day {
                let daysCount = days + 1
                let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "MMM d"
                let startMonthDay = dateFormatter.string(from: startDate)
                let endMonthDay = dateFormatter.string(from: endDate)
                let durationLabel = (daysCount == 1) ? "day" : "days"
                return "\(startMonthDay) to \(endMonthDay) · \(daysCount) \(durationLabel)"
            }
        }; return nil
    }
    
    ////nextDate...
    func nextDate(from dateString: String, with format: String) -> String {
        let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "dd MMM yyyy"
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            if let nextDate = calendar.date(byAdding: .day, value: 1, to: date) {
                let outputFormatter = DateFormatter(); outputFormatter.dateFormat = format; return outputFormatter.string(from: nextDate)
            }
        }
        return ""
    }
    
    ///DatePicker...
    func DatePicker(textField: UITextField,mode: UIDatePicker.Mode, action: Selector, picker: UIDatePicker){
        let toolBar = UIToolbar(); toolBar.sizeToFit();  let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: action)
        toolBar.setItems([doneBtn], animated: true); textField.inputAccessoryView = toolBar
        textField.inputView = picker; picker.datePickerMode = mode; picker.preferredDatePickerStyle = .wheels
    }
    
    
    ///datesInRange...
    func datesInRange(from startDateString: String, to endDateString: String) -> [Date] {
        let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        if let startDate = dateFormatter.date(from: startDateString), let endDate = dateFormatter.date(from: endDateString) {
            var currentDate = startDate; var dateArray: [Date] = []; let calendar = Calendar.current
            while currentDate <= endDate { dateArray.append(currentDate); currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)! }
            return dateArray
        }
        return []
    }
    
    ///parseDate...
    func parseDate(from dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter.date(from: dateString)
    }
    
    ///findKey
    func findKey(forValue valueToFind: String, inDictionary dictionary: [Int: String]) -> Int? {
        for (key, value) in dictionary {
            if value == valueToFind { return key }
        }; return nil
    }
    
    ///getFullDayName...
    func getFullDayName(abbreviatedDay: String) -> String {
        let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "EEE"
        if let date = dateFormatter.date(from: abbreviatedDay) {
            let fullDayFormatter = DateFormatter(); fullDayFormatter.dateFormat = "EEEE"; return fullDayFormatter.string(from: date)
        }; return abbreviatedDay
    }
    
    ///getFullDayNameAndDayOfMonth...
    func getFullDayNameAndDayOfMonth(from dateString: String) -> String {
        let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) { dateFormatter.dateFormat = "EEEE d"; return dateFormatter.string(from: date) }
        return dateString
    }
    
    ///calculateTimeDifference..
    func calculateTimeDifference(start: String, end: String) -> String {
        let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "hh:mm a"
        if let startTime = dateFormatter.date(from: start), let endTime = dateFormatter.date(from: end) {
            let calendar = Calendar.current; let components = calendar.dateComponents([.hour, .minute], from: startTime, to: endTime)
            if let hours = components.hour, let minutes = components.minute {
                if hours == 0 { return "\(minutes)mins" } else { if minutes == 0 { return "\(hours)hr" } else { return "\(hours)hr \(minutes)mins" } }
            }
        }; return ""
    }
    
    
    
}

//MARK: - UIColor...
extension UIColor {
    ///Hex...
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexValue = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        if hexValue.hasPrefix("#") { hexValue.remove(at: hexValue.startIndex) }
        var rgbValue: UInt64 = 0; Scanner(string: hexValue).scanHexInt64(&rgbValue)
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}



//MARK: -
extension UIDevice {
    
    ///modelName...
    var modelName: String {
#if targetEnvironment(simulator)
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
            return mapToDevice(identifier: simulatorModelIdentifier)
        }
#endif
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return mapToDevice(identifier: identifier)
    }
    
    ///mapToDevice...
    private func mapToDevice(identifier: String) -> String {
        ///modelMapping...
        let modelMapping: [String: String] = [
            "iPhone1,1": "iPhone 2G", "iPhone1,2": "iPhone 3G", "iPhone2,1": "iPhone 3GS", "iPhone3,1": "iPhone 4", "iPhone3,2": "iPhone 4", "iPhone3,3": "iPhone 4", "iPhone4,1": "iPhone 4S", "iPhone5,1": "iPhone 5", "iPhone5,2": "iPhone 5", "iPhone5,3": "iPhone 5c", "iPhone5,4": "iPhone 5c", "iPhone6,1": "iPhone 5s", "iPhone6,2": "iPhone 5s", "iPhone7,1": "iPhone 6 Plus", "iPhone7,2": "iPhone 6", "iPhone8,1": "iPhone 6s", "iPhone8,2": "iPhone 6s Plus", "iPhone8,4": "iPhone SE (1st generation)", "iPhone9,1": "iPhone 7", "iPhone9,2": "iPhone 7 Plus", "iPhone9,3": "iPhone 7", "iPhone9,4": "iPhone 7 Plus", "iPhone10,1": "iPhone 8", "iPhone10,2": "iPhone 8 Plus", "iPhone10,3": "iPhone X", "iPhone10,4": "iPhone 8", "iPhone10,5": "iPhone 8 Plus", "iPhone10,6": "iPhone X", "iPhone11,2": "iPhone XS", "iPhone11,4": "iPhone XS Max", "iPhone11,6": "iPhone XS Max", "iPhone11,8": "iPhone XR", "iPhone12,1": "iPhone 11", "iPhone12,3": "iPhone 11 Pro", "iPhone12,5": "iPhone 11 Pro Max", "iPhone12,8": "iPhone SE (2nd generation)", "iPhone13,1": "iPhone 12 mini", "iPhone13,2": "iPhone 12", "iPhone13,3": "iPhone 12 Pro", "iPhone13,4": "iPhone 12 Pro Max", "iPhone14,4": "iPhone 13 mini", "iPhone14,5": "iPhone 13", "iPhone14,2": "iPhone 13 Pro", "iPhone14,3": "iPhone 13 Pro Max", "iPhone14,10": "iPhone 14", "iPhone14,11": "iPhone 14 Pro", "iPhone14,12": "iPhone 14 Pro Max" ]
        return modelMapping[identifier] ?? "Unknown iPhone model"
    }
}


//MARK: - UITabBarItem...
extension UITabBarItem {
    
    ///selectedImageName...
    @IBInspectable var selectedImageName: String? {
        get { return selectedImage?.accessibilityIdentifier }
        set {
            if let imageName = newValue {
                selectedImage = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
                selectedImage?.accessibilityIdentifier = imageName
            } else { selectedImage = nil }
        }
    }
    
    ///unselectedImageName...
    @IBInspectable var unselectedImageName: String? {
        get { return image?.accessibilityIdentifier }
        set {
            if let imageName = newValue {
                image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
                image?.accessibilityIdentifier = imageName
            } else { image = nil }
        }
    }
}


//MARK: - UITableViewCell...
extension UITableViewCell {
    
    ///setUpBGView...
    func setUpBGView(){
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = backgroundView
    }
    
    ///formatDateWithFromToAndDays...
    func formatDateWithFromToAndDays(startDateString: String, endDateString: String) -> String? {
        let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        if let startDate = dateFormatter.date(from: startDateString), let endDate = dateFormatter.date(from: endDateString) {
            let calendar = Calendar.current; let components = calendar.dateComponents([.day], from: startDate, to: endDate)
            
            if let days = components.day {
                let daysCount = days + 1
                let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "MMM d"
                let startMonthDay = dateFormatter.string(from: startDate)
                let endMonthDay = dateFormatter.string(from: endDate)
                let durationLabel = (daysCount == 1) ? "day" : "days"
                return "\(startMonthDay) to \(endMonthDay) · \(daysCount) \(durationLabel)"
            }
        }; return nil
    }
    
    ///calculateDaysBetween...
    func calculateDaysBetween(startDateString: String, endDateString: String) -> String? {
        let inputDateFormatter = DateFormatter(); inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        guard let startDate = inputDateFormatter.date(from: startDateString), let endDate = inputDateFormatter.date(from: endDateString) else { return nil }
        let calendar = Calendar.current; let daysDifference = calendar.dateComponents([.day], from: calendar.startOfDay(for: startDate), to: calendar.startOfDay(for: endDate))
        if let dayDifference = daysDifference.day {
            if dayDifference <= 0 { return "    ends today    " } else { return "    ends in \(dayDifference)d    " }
            
            
        } else { return nil }
    }
    
    
    func calculateTimesToGo(startDateString: String, endDateString: String) -> String? {
        let inputDateFormatter = DateFormatter(); inputDateFormatter.dateFormat = "yyyy-MM-dd"
        guard let startDate = inputDateFormatter.date(from: startDateString), let endDate = inputDateFormatter.date(from: endDateString) else { return nil }
        let calendar = Calendar.current; let timeDifference = calendar.dateComponents([.second], from: startDate, to: endDate)
        if let secondsDifference = timeDifference.second { let daysDifference = secondsDifference / (60 * 60 * 24);  return "    \(daysDifference)d to go    "  }
        else { return nil }
    }
    
    ///getMonthNameAndDate..
    func getMonthNameAndDate(from dateString: String) -> String? {
        let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        if let date = dateFormatter.date(from: dateString) { dateFormatter.dateFormat = "MMMM d"; return dateFormatter.string(from: date) }
        return nil
    }
    
    ///parseDate...
    func parseDate(from dateString: String, withOutputFormat outputFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = outputFormat
            return dateFormatter.string(from: date)
        }
        
        return Date().formattedString(with: "yyyy-MM-dd")
    }
    
    
    
    
}

//MARK: - TableView...
extension UITableView {
    
    ///takeScreenshot..
    func takeScreenshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(contentSize, false, UIScreen.main.scale)
        let savedContentOffset = contentOffset; let savedFrame = frame
        contentOffset = .zero; frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        contentOffset = savedContentOffset; frame = savedFrame;  UIGraphicsEndImageContext()
        return image
    }
    
    ///setupTiTleIndex...
    func setupTiTleIndex(color: UIColor, font: UIFont){
        DispatchQueue.main.async { [unowned self] in
            if let tableViewIndex = self.subviews.first(where: { String(describing: type(of: $0)) == "UITableViewIndex" }) {
                tableViewIndex.setValue(font, forKey: "font"); self.reloadSectionIndexTitles()
            }
        }
        sectionIndexColor = color; sectionIndexBackgroundColor = UIColor.clear
    }
    
}



//MARK: - Label....
extension UILabel {
    
    ///setUpLabel...
    func setUpLabel(text: String? ,font: UIFont?, textAlignment: NSTextAlignment? = .left, textColor: UIColor? = .white, numberOfLines: Int? = 1, textBGcolor: UIColor = UIColor.white, radius: CGFloat = 0, maskToBound: Bool = false){
        self.text = text
        self.font = font
        self.textAlignment = textAlignment ?? .left
        self.textColor = textColor
        self.numberOfLines = numberOfLines ?? 0
        self.backgroundColor = textBGcolor
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = maskToBound
    }
    
    ///countLines...
    func countLines() -> Int {
        guard let myText = self.text as NSString? else {
            return 0
        }
        // Call self.layoutIfNeeded() if your view uses auto layout
        let rect = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font as Any], context: nil)
        return Int(ceil(CGFloat(labelSize.height) / self.font.lineHeight))
    }
    
    ///requiredWidth...
    static func requiredWidth(for text: String, with font: UIFont, padding: CGFloat = 20) -> CGFloat {
        let label = UILabel(); label.font = font; label.text = text
        let attributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: attributes)
        return ceil(size.width) + padding
    }
    
    func updateTrimmedText(fullText: String, numberOfLines: Int) {
        let trimmedText = trimTextToFit(text: fullText, numberOfLines: numberOfLines)
        let readMoreText = NSAttributedString(string: " Read More...", attributes: [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        
        let attributedString = NSMutableAttributedString(string: trimmedText)
        attributedString.append(readMoreText)
        self.attributedText = attributedString
    }
    
    ///trimTextToFit...
    func trimTextToFit(text: String, numberOfLines: Int) -> String {
        let maxChars = numberOfLines * numberOfLinesForFullText(text: text); return String(text.prefix(maxChars))
    }
    
    ///numberOfLinesForFullText...
    func numberOfLinesForFullText(text: String) -> Int {
        let maxSize = CGSize(width: frame.width, height: CGFloat.greatestFiniteMagnitude)
        let textHeight = (text as NSString).boundingRect( with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font ?? UIFont.systemFont(ofSize: 17)], context: nil ).height
        let lineHeight = font.lineHeight; return Int(textHeight / lineHeight)
    }
    
    ///removeSoonLineBreakFromLabel...
    func removeSoonLineBreakFromLabel() {
        if #available(iOS 14.0, *) { self.lineBreakStrategy = [] } else { self.lineBreakMode = .byWordWrapping }
    }
    
    ///trimAndLoweredText...
    func trimAndLoweredText() -> String {
        return self.text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }
}

//MARK: - Buttons
extension UIButton {
    
    ///setButtonValues...
    func setButtonValues(text: String? = "", cornerRadius : CGFloat? = 0.0, masksToBounds: Bool? = false, borderColor: UIColor? = .clear, borderWidth: CGFloat? = 0.0, font: UIFont? = UIFont.systemFont(ofSize: 16), textColor: UIColor? = .black, textAlignment: NSTextAlignment? = .center, BgColor: UIColor? = .white, tintColor: UIColor){
        self.setTitle(text, for: UIControl.State.normal); self.layer.cornerRadius = cornerRadius ?? 0.0; self.layer.masksToBounds = masksToBounds ?? false
        self.layer.borderColor = borderColor?.cgColor ?? UIColor.clear.cgColor; self.layer.borderWidth = borderWidth ?? 0.0; self.titleLabel?.font = font
        self.titleLabel?.textColor = textColor; self.titleLabel?.textAlignment = textAlignment ?? .center
        self.backgroundColor = BgColor ?? .white; self.tintColor = tintColor
    }
}


//MARK: - UIStackView...
extension UIStackView {
    
    ///addSubViews..
    func addArrangeAllSubViews(views: [UIView]) { views.forEach { view in  self.addArrangedSubview(view)  } }
    
    ///removeFullyAllArrangedSubviews...
    func removeFullyAllArrangedSubviews() { arrangedSubviews.forEach { (view) in  removeFully(view: view) } }
    
    ///removeFully...
    func removeFully(view: UIView) { removeArrangedSubview(view); view.removeFromSuperview() }
}

//MARK: - GradientView...
class GradientView: UIView {
    
    // MARK: - View Init Methods...
    
    ///frame...
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    ///coder...
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Function...
    private func setupView() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        guard let theLayer = self.layer as? CAGradientLayer else { return }
        theLayer.colors = [UIColor(hex: "#013781", alpha: 0.5).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor]
        theLayer.startPoint = CGPoint(x: 0.0, y: 1.0); theLayer.endPoint = CGPoint(x: 0.0, y: 0.2)
        theLayer.cornerRadius = 12; theLayer.locations = [0, 1]; theLayer.frame = self.bounds
    }
    
    override class var layerClass: AnyClass { return CAGradientLayer.self }
}

class GradientMasterView: UIView {
    
    // MARK: - Inspectable Properties...
    
    ///startColor...
    @IBInspectable var startColor: UIColor = UIColor(hex: "#013781", alpha: 0.5) { didSet { updateGradient() } }
    
    ///endColor...
    @IBInspectable var endColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0) { didSet { updateGradient() } }
    
    ///startPoint...
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.0, y: 1.0) { didSet { updateGradient() } }
    
    ///endPoint..
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0.0, y: 0.2) { didSet { updateGradient() } }
    
    // MARK: - View Init Methods...
    
    ///frame...
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    ///coder..
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Function...
    
    ///setupView...
    private func setupView() { autoresizingMask = [.flexibleWidth, .flexibleHeight]; updateGradient() }
    
    ///updateGradient..
    private func updateGradient() {
        guard let theLayer = layer as? CAGradientLayer else { return }
        theLayer.colors = [startColor.cgColor, endColor.cgColor]; theLayer.startPoint = startPoint; theLayer.endPoint = endPoint
        theLayer.cornerRadius = 12; theLayer.locations = [0, 1]; theLayer.frame = bounds
    }
    
    ///layerClass..
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    
}

//MARK: - UIDatePicker...
extension UIDatePicker {
    
    /// Set maximum age in years and display date picker with month and year
    func setMaximumAgeInYears(_ years: Int, textField: UITextField, action: Selector, picker: UIDatePicker, setTextOnLunched: Bool = true, initialYear: Int = 1990) {
        let currentDate = Date(); let calendar = Calendar.current
        var maxDateComponents = calendar.dateComponents([.year, .month], from: currentDate); maxDateComponents.year! -= years
        let maxDate = calendar.date(from: maxDateComponents); self.maximumDate = maxDate
        
        let toolBar = UIToolbar(); toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: action)
        toolBar.setItems([flexibleSpace, doneBtn], animated: true)
        
        textField.inputAccessoryView = toolBar; textField.inputView = self
        datePickerMode = .date; preferredDatePickerStyle = .wheels
        
        let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "MM/yyyy"
        let initialMonth = 1; let initialDate = createDate(year: initialYear, month: initialMonth)
        let formattedDate = dateFormatter.string(from: initialDate)
        if setTextOnLunched { textField.text = formattedDate }; date = initialDate
    }
    
    /// Create date
    private func createDate(year: Int, month: Int) -> Date {
        let calendar = Calendar.current; var components = DateComponents()
        components.year = year; components.month = month; components.day = 1
        return calendar.date(from: components) ?? Date()
    }
    
    
}


//MARK: - UserDefaults...
extension UserDefaults {
    
    ///save...
    func save<T:Encodable>(customObject object: T, inKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) { self.set(encoded, forKey: key) }
    }
    
    ///retrieve...
    func retrieve<T:Decodable>(object type:T.Type, fromKey key: String) -> T? {
        if let data = self.data(forKey: key) {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(type, from: data) { return object } else { print("Couldnt decode object"); return nil }
        } else { print("Couldnt find key"); return nil }
    }
}

//MARK: - UICollectionView...
extension UICollectionView {
    
    ///addPullToRefresh...
    func addPullToRefresh(target: Any, action: Selector) {
        let refreshControl = UIRefreshControl(); refreshControl.addTarget(target, action: action, for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    ///endPullToRefresh..
    func endPullToRefresh() { refreshControl?.endRefreshing() }
}

//MARK: - UITableView...
extension UITableView {
    
    ///addPullToRefresh...
    func addPullToRefresh(target: Any, action: Selector) {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(target, action: action, for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    ///endPullToRefresh..
    func endPullToRefresh() { refreshControl?.endRefreshing() }
}


//MARK: - UITextField...
extension UITextField {
    func addClearButtonWithExpandedSize(expandedWidth: CGFloat, expandedHeight: CGFloat) {
        let clearButtonContainer = UIView(frame: CGRect(x: 0, y: 0, width: 30 + expandedWidth, height: max(30, expandedHeight)))
        
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        clearButton.tintColor = .gray
        clearButton.frame = CGRect(x: 0, y: (clearButtonContainer.frame.height - 30) / 2, width: 30, height: 30)
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        
        clearButtonContainer.addSubview(clearButton)
        
        rightView = clearButtonContainer
        rightViewMode = .whileEditing
    }
    
    ///clearButtonTapped...
    @objc private func clearButtonTapped() { text = "" }
}


//MARK: - Date...
extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
    
    ///currentYear...
    func currentYear() -> Int {
        let calendar = Calendar.current; let components = calendar.dateComponents([.year], from: self); return components.year ?? 0
    }
    
    ///withComponents...
    func withComponents(_ components: Set<Calendar.Component>) -> Date {
        let calendar = Calendar.current; let dateComponents = calendar.dateComponents(components, from: self)
        return calendar.date(from: dateComponents)!
    }
    
    ///formattedString...
    func formattedString(with format: String) -> String {
        let dateFormatter = DateFormatter(); dateFormatter.dateFormat = format; return dateFormatter.string(from: self)
    }
    
    ///toString...
    func toString() -> String {
        let dateFormatter = DateFormatter(); dateFormatter.dateStyle = .medium; dateFormatter.timeStyle = .medium; return dateFormatter.string(from: self)
    }
    
    ///addingOneDayFormatted...
    func addingOneDayFormatted(with format: String) -> String {
        let calendar = Calendar.current
        if let nextDate = calendar.date(byAdding: .day, value: 1, to: self) {
            let dateFormatter = DateFormatter(); dateFormatter.dateFormat = format; return dateFormatter.string(from: nextDate)
        }; return ""
    }
    
    
}

//MARK: - String...
extension String {
    
    ///removing...
    func removing(substringsToRemove: [String]) -> String {
        var result = self
        for substring in substringsToRemove { result = result.replacingOccurrences(of: substring, with: "") }
        return result
    }
    
    ///trimAndLoweredText...
    func trimAndLoweredText() -> String {
        return self.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func convertDateFormat(from inputFormat: String, to outputFormat: String) -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = inputFormat
        
        if let date = inputDateFormatter.date(from: self) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = outputFormat
            return outputDateFormatter.string(from: date)
        }
        
        return ""
    }
    
}

//MARK: - UICollectionViewCell...
extension UICollectionViewCell {
    
    ///getDayNameAndDate...
    func getDayNameAndDate(from dateString: String) -> String? {
        let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) { dateFormatter.dateFormat = "E dd"; return dateFormatter.string(from: date) }
        return nil
    }
    
    ///extractTimeFromDateTime..
    func extractTimeFromDateTime(dateTimeString: String) -> String {
        let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = dateFormatter.date(from: dateTimeString) {
            let timeFormatter = DateFormatter(); timeFormatter.dateFormat = "ha"; return timeFormatter.string(from: date)
        }
        return "12Am"
    }
}

///UITabBarController...
extension UITabBarController {
    
    ///setBadgeValue...
    func setBadgeValue(_ value: String?, forIndex index: Int) {
        if let tabBarItems = tabBar.items, index < tabBarItems.count { tabBarItems[index].badgeValue = value }
    }
}

