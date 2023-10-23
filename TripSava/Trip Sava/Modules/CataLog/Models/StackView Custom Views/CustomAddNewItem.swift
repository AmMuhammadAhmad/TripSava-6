//
//  CustomAddNewItem.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 19/08/2023.
//

import UIKit

class CustomAddNewItem: UIView {
    
    // MARK: - Variables...
    
    ///buyButton...
    lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setButtonValues(text: "Add", cornerRadius: 8, font: Constants.applyFonts_DMSans(style: .Medium, size: 11), textColor: UIColor(hex: "#E26A2B"), BgColor: UIColor(hex: "#E26A2B", alpha: 0.10), tintColor: UIColor(hex: "#E26A2B"))
        button.addTarget(self, action: #selector(addItemBtnAction), for: .touchUpInside)
        return button
    }()
    
    ///textField...
    let addTextField: TextField = {
        let textfield = TextField()
        textfield.insetX = 16; textfield.placeholder = "Enter Item name"; textfield.textColor = UIColor(hex: "#474847", alpha: 0.96)
        textfield.backgroundColor = UIColor.systemGray6; textfield.layer.cornerRadius = 8
        return textfield
    }()
     
    ///AddBtnAction...
    var AddBtnAction: ((String) -> Void)?
    
    
    // MARK: - Cell init Methods...
    
    ///overrideInit...
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCellInitMethod()
    }
    
    ///requiredInit...
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Functions...
    
    ///setUpCellInitMethod...
    func setUpCellInitMethod(){
        self.tag = 100; addsubViewWithConstraints(subView: addButton, trailingAnchor: trailingAnchor, centerYAnchor: centerYAnchor, widthAnchor: 55, heightAnchor: 34, trailingAnchorConstant: -2)
        
        addsubViewWithConstraints(subView: addTextField, topAnchor: addButton.topAnchor, leadingAnchor: leadingAnchor, trailingAnchor: addButton.leadingAnchor, bottomAnchor: addButton.bottomAnchor, leadingAnchorConstant: 6, trailingAnchorConstant: -20)
        
    }
    
    
    // MARK: - Actions...
    
    ///addItemBtnAction...
    @objc func addItemBtnAction(){
        if !addTextField.isEmptyTextField() {
            AddBtnAction?(addTextField.text!)
        }
    }
}
