//
//  CustomPackingView.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 26/06/2023.
//

import UIKit

class CustomPackingView: UIView {
    
    // MARK: - Variables...
    
    var shopBtnAction: ((String) -> Void)?
    var radioBtnAction: ((String) -> Void)?
    var itemId: String = ""
    
    ///radioButton...
    lazy var radioButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "uncheckedTick"), for: .normal)
        btn.addTarget(self, action: #selector(radioButtonAction), for: .touchUpInside)
        return btn
    }()
    
    ///label...
    let label: UILabel = {
        let label = UILabel()
        label.setUpLabel(text: "Get my passport", font: Constants.applyFonts_DMSans(style: .regular, size: 14), textColor: UIColor.init(hex: "#474847", alpha: 0.96), numberOfLines: 2, textBGcolor: .clear)
        return label
    }()
    
    ///buyButton...
    lazy var buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setButtonValues(text: "Shop", cornerRadius: 8, font: Constants.applyFonts_DMSans(style: .Medium, size: 11), textColor: UIColor(hex: "#E26A2B"), BgColor: UIColor(hex: "#E26A2B", alpha: 0.10), tintColor: UIColor(hex: "#E26A2B"))
        button.addTarget(self, action: #selector(shopButtonAction), for: .touchUpInside)
        return button
    }()
    
    
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
        
        //Set up radioButton Constraints
        addsubViewWithConstraints(subView: radioButton, leadingAnchor: leadingAnchor, centerYAnchor: centerYAnchor, widthAnchor: 28, heightAnchor: 28)
        
        addsubViewWithConstraints(subView: buyButton, trailingAnchor: trailingAnchor, centerYAnchor: centerYAnchor, widthAnchor: 45, heightAnchor: 22, trailingAnchorConstant: -2)
        
        addsubViewWithConstraints(subView: label, leadingAnchor: radioButton.trailingAnchor, trailingAnchor: buyButton.leadingAnchor, centerYAnchor: centerYAnchor, leadingAnchorConstant: 16, trailingAnchorConstant: -12)
          
    }
    
    
    // MARK: - Actions...
    
    ///radioButtonAction...
    @objc func radioButtonAction(){ radioBtnAction?(itemId) }
    
    ///shopButtonAction...
    @objc func shopButtonAction() { shopBtnAction?(itemId) }
    
}
 
