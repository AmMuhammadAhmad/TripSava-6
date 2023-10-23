//
//  CheckBox.swift
//  TripSava
//
//  Created by Muneeb Zain on 09/06/2023.
//


import UIKit

class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "check")
    let uncheckedImage = UIImage(named: "uncheck")
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true { self.setImage(checkedImage, for: UIControl.State.normal) }
            else { self.setImage(uncheckedImage, for: UIControl.State.normal) }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}


///CheckBoxImg...
class CheckBoxImg: UIImageView {
    // Images
    let checkedImage = UIImage(named: "check")
    let uncheckedImage = UIImage(named: "uncheck")
    
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                self.image = checkedImage
            } else {
                self.image = uncheckedImage
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTapGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTapGesture()
    }
    
    private func setupTapGesture() {
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        isChecked = !isChecked
    }
}
