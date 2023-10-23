//
//  OTPView.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 13/07/2023.
//

import UIKit

@IBDesignable
class OTPView: UIView {
    
    
    //MARK: - IBInspectable...
    
    ///numberOfFields...
    @IBInspectable var numberOfFields: Int = 4 { didSet { updateTextFields() } }
    
    @IBInspectable var txtSize: CGSize = CGSize(width: 60, height: 60) { didSet { updateTextFields() } }
    
    ///spacing...
    @IBInspectable var spacing: CGFloat = 8.0 { didSet { stackView.spacing = spacing } }
    
    ///txtFieldsRadius...
    @IBInspectable var txtFieldsRadius: CGFloat = 12 { didSet { updateTextFields() } }
    
    ///defaultBorderColor...
    @IBInspectable var defaultBorderColor: UIColor = .lightGray { didSet { updateTextFields() } }
    
    ///selectedBorderColor..
    @IBInspectable var selectedBorderColor: UIColor = .lightGray { didSet { updateTextFields() } }
    
    ///defaultTextFieldTextColor...
    @IBInspectable var defaultTextFieldTextColor: UIColor = .black { didSet { updateTextFields() } }
    
    ///selectedTextFieldTextColor...
    @IBInspectable var selectedTextFieldTextColor: UIColor = .blue { didSet { updateTextFields() } }
     
    ///defaultTextFieldBackgroundColor...
    @IBInspectable var defaultTextFieldBackgroundColor: UIColor = .white { didSet { updateTextFields() } }
    
    ///selectedTextFieldBackgroundColor..
    @IBInspectable var selectedTextFieldBackgroundColor: UIColor = .white { didSet { updateTextFields() } }
    
    ///
    @IBInspectable var txtCursorColor: UIColor = .black { didSet { updateTextFields() } }
    
     
    //MARK: - Variables...
    
    ///ButtonsstackView...
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = spacing
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    var handleOtpCompletion: ((String) -> Void)?
    
    //MARK: - View Init methods...
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //MARK: - Functions...
    
    ///setup...
    private func setup() {
        insertSubview(stackView, at: 0)
        addCenterToSulerViewConstraints(view: stackView, centerXAnchor: centerXAnchor, centerYAnchor: centerYAnchor); updateTextFields()
    }
    
    ///updateTextFields..
    private func updateTextFields() {
        
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for _ in 1...numberOfFields {
            let textField = OTPTextField()
            addWidthHeightConstraints(view: textField, widthAnchor: txtSize.width, heightAnchor: txtSize.height)
            textField.defaultBorderColor = defaultBorderColor; textField.selectedBorderColor = selectedBorderColor
            textField.defaultTextFieldTextColor = defaultTextFieldTextColor; textField.selectedTextFieldTextColor = selectedTextFieldTextColor
            textField.defaultTextFieldBackgroundColor = defaultTextFieldBackgroundColor; textField.selectedTextFieldBackgroundColor = selectedTextFieldBackgroundColor
            textField.layer.cornerRadius = txtFieldsRadius; textField.tintColor = txtCursorColor
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            textField.addTarget(self, action: #selector(clearTextField(_:)), for: .editingDidBegin)
            textField.addTarget(self, action: #selector(clearTextField(_:)), for: .editingDidBegin)
            stackView.addArrangedSubview(textField)
        }
    }
    
    
    ///textFieldDidChange...
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.count >= 1 {
            guard let currentIndex = stackView.arrangedSubviews.firstIndex(of: textField) else { return }
            if currentIndex < stackView.arrangedSubviews.count - 1 {
                let nextTextField = stackView.arrangedSubviews[currentIndex + 1] as? OTPTextField; let _ = nextTextField?.becomeFirstResponder()
            } else { textField.endEditing(true); handleOtpAction() }
            clearTextFieldBorder(txt: textField)
        }
    }
    
    ///handleOtpAction...
    func handleOtpAction(){
        let otp = stackView.arrangedSubviews.compactMap { ($0 as? OTPTextField)?.text }.joined(); handleOtpCompletion?(otp)
    }
    
    ///otpValidation...
    func otpValidation() -> Bool {
        let nonEmptyTextFields = stackView.arrangedSubviews.compactMap { $0 as? OTPTextField }
            .filter { ($0.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "").isEmpty == false }
        return nonEmptyTextFields.count == stackView.arrangedSubviews.count
    }
    
    ///clearTextField..
    @objc private func clearTextField(_ sender: UITextField) { sender.text?.removeAll() }
    
    ///clearTextFieldBorder...
    @objc private func clearTextFieldBorder(txt: UITextField) { txt.layer.borderColor = UIColor.clear.cgColor }
}
