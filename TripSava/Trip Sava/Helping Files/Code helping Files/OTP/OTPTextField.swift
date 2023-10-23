//
//  OTPTextField.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 12/07/2023.
//

import UIKit

@IBDesignable
class OTPTextField: UITextField {
    
    //MARK: - IBInspectable...
    
    ///defaultBorderColor...
    @IBInspectable var defaultBorderColor: UIColor = .red { didSet { updateBorder() } }
    
    ///selectedBorderColor...
    @IBInspectable var selectedBorderColor: UIColor = .blue { didSet { updateBorder() } }
    
    ///defaultTextFieldTextColor...
    @IBInspectable var defaultTextFieldTextColor: UIColor = .white { didSet { updateTextFieldColor() } }
    
    ///selectedTextFieldTextColor...
    @IBInspectable var selectedTextFieldTextColor: UIColor = .lightGray { didSet { updateTextFieldColor() } }
    
    ///defaultTextFieldBackgroundColor...
    @IBInspectable var defaultTextFieldBackgroundColor: UIColor = .lightGray { didSet { updateBackgroundColor() } }
    
    ///selectedTextFieldBackgroundColor...
    @IBInspectable var selectedTextFieldBackgroundColor: UIColor = .lightGray { didSet { updateBackgroundColor() } }
    
    
    //MARK: - View Init Methods...
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    ///becomeFirstResponder...
    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        updateBorder()
        updateTextFieldColor()
        return result
    }
    
    ///resignFirstResponder...
    override func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        updateBorder()
        updateTextFieldColor()
        return result
    }
    
    ///layoutSubviews...
    override func layoutSubviews() {
        super.layoutSubviews()
        updateBorder()
    }
    
    
    //MARK: - Functions...
    
    ///setup...
    private func setup() {
        layer.borderWidth = 1.0; layer.cornerRadius = 5.0
        textAlignment = .center; keyboardType = .numberPad
        clipsToBounds = true; updateBorder(); updateTextFieldColor()
    }
    
    ///updateBorder...
    private func updateBorder() {
        layer.borderColor = isFirstResponder ? selectedBorderColor.cgColor : defaultBorderColor.cgColor
        if !isFirstResponder { layer.borderColor = defaultBorderColor.cgColor }
    }
    
    ///updateTextFieldColor..
    private func updateTextFieldColor() {
        textColor = isFirstResponder ? selectedTextFieldTextColor : defaultTextFieldTextColor
    }
    
    ///updateBackgroundColor...
    private func updateBackgroundColor(){
        backgroundColor = isFirstResponder ? defaultTextFieldBackgroundColor : selectedTextFieldBackgroundColor
    }
    
}
