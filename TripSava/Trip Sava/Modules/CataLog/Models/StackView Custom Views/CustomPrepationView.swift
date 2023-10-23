//
//  CustomPrepationView.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 26/06/2023.
//

import UIKit

class CustomPrepationView: UIView {
    
    // MARK: - Variables...
    
    ///radioButton...
    lazy var radioButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "uncheckedTick"), for: .normal)
        btn.addTarget(self, action: #selector(radioButtonAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var itemDetailsButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(itemDetailsButtonAction), for: .touchUpInside)
        return btn
    }()
    
    ///label...
    let label: UILabel = {
        let label = UILabel()
        label.setUpLabel(text: "Get My Pasport.", font: Constants.applyFonts_DMSans(style: .regular, size: 14), textColor: UIColor.init(hex: "#474847", alpha: 0.80), numberOfLines: 0)
        return label
    }()
    
    ///DescriptionLable...
    let DescriptionLable: UILabel = {
        let desLable = UILabel()
        desLable.setUpLabel(text: "", font: Constants.applyFonts_DMSans(style: .regular, size: 13), textColor: UIColor.init(hex: "#474847", alpha: 0.50), numberOfLines: 0)
        
        return desLable
    }()
    
    ///lineLable...
    let lineLable: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(hex: "#EBEBEB")
        return label
    }()
    
    ///bulbButton...
    let bulbButton: UIButton = {
        let bulbBtn = UIButton(type: .system)
        bulbBtn.setImage(UIImage(named: "bulb"), for: .normal)
        bulbBtn.setButtonValues(tintColor: UIColor(hex: "#A3A3A3"))
        return bulbBtn
    }()
    
    //bellButton...
   lazy var bellButton: UIButton = {
        let bellBtn = UIButton(type: .system)
        bellBtn.setImage(UIImage(named: "basket"), for: .normal)
        bellBtn.setButtonValues(cornerRadius: 8,tintColor: UIColor(hex: "#A3A3A3"))
        return bellBtn
    }()
    
    ///flagButton...
   lazy var flagButton: UIButton = {
        let flagBtn = UIButton(type: .system)
        flagBtn.setImage(UIImage(named: "flagTag"), for: .normal)
        flagBtn.setButtonValues(tintColor: UIColor(hex: "#E26A2B"))
        return flagBtn
    }()
    
    lazy var numberBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setButtonValues(text: "1", cornerRadius: 4, font: Constants.applyFonts_DMSans(style: .bold, size: 12), textColor: UIColor.white, BgColor: UIColor(hex: "#A3A3A3"), tintColor: UIColor.white)
        return button
    }()
    
    ///ButtonsstackView...
    lazy var optionsBtnStackView: UIStackView = {
        let buttonsStackView = UIStackView()
        buttonsStackView.axis = .horizontal
        buttonsStackView.alignment = .fill
        buttonsStackView.distribution = .fill
        buttonsStackView.spacing = 3
        return buttonsStackView
    }()
    
    
    var didTapItemBtnAction: ((PackingItem) -> Void)?
    var radioBtnAction: ((String) -> Void)?
    var itemId: String = ""; var item: PackingItem?
    
    var isproirty = false; var isShoppingList = false; var isProtips = false; var isQuantity = false
    
  
    
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
        
        addWidthHeightConstraints(view: flagButton, widthAnchor: 22, heightAnchor: 22)
        addWidthHeightConstraints(view: numberBtn, widthAnchor: 16, heightAnchor: 16)
        addWidthHeightConstraints(view: bellButton, widthAnchor: 22, heightAnchor: 22)
        addWidthHeightConstraints(view: bulbButton, widthAnchor: 22, heightAnchor: 22)
          
        addsubViewWithConstraints(subView: radioButton, leadingAnchor: leadingAnchor, centerYAnchor: centerYAnchor, widthAnchor: 22, heightAnchor: 22, topAnchorConstant: -4, leadingAnchorConstant: 6)
        
        addsubViewWithConstraints(subView: optionsBtnStackView, topAnchor: radioButton.topAnchor, trailingAnchor: trailingAnchor, trailingAnchorConstant: -8)
        
        addsubViewWithConstraints(subView: label, topAnchor: radioButton.topAnchor, leadingAnchor: radioButton.trailingAnchor, trailingAnchor: optionsBtnStackView.leadingAnchor, topAnchorConstant: 2, leadingAnchorConstant: 12, trailingAnchorConstant: -12)
        
        addsubViewWithConstraints(subView: DescriptionLable, topAnchor: label.bottomAnchor, leadingAnchor: label.leadingAnchor, trailingAnchor: optionsBtnStackView.trailingAnchor, topAnchorConstant: 12)
        
        addsubViewWithConstraints(subView: lineLable, topAnchor: DescriptionLable.bottomAnchor, leadingAnchor: DescriptionLable.leadingAnchor, trailingAnchor: DescriptionLable.trailingAnchor, bottomAnchor: bottomAnchor, heightAnchor: 1, topAnchorConstant: 0, bottomAnchorConstant: 0)
        
        
        addsubViewWithConstraints(subView: itemDetailsButton, topAnchor: topAnchor, leadingAnchor: label.leadingAnchor, trailingAnchor: trailingAnchor, bottomAnchor: bottomAnchor, bottomAnchorConstant: -6, insertAt: 3)
         
    }
    
    ///updateTags..
    func updateTags(){
        if isQuantity { optionsBtnStackView.addArrangedSubview(numberBtn) }
        if isProtips { optionsBtnStackView.addArrangedSubview(bulbButton) }
        if isShoppingList { optionsBtnStackView.addArrangedSubview(bellButton) }
        if isproirty { optionsBtnStackView.addArrangedSubview(flagButton) }
    }
    
    
    // MARK: - Actions...
    
    // MARK: - Actions...
    
    ///radioButtonAction...
    @objc func radioButtonAction(){ radioBtnAction?(itemId) }
    
    ///itemDetailsButtonAction..
    @objc func itemDetailsButtonAction(){ if let item = item { didTapItemBtnAction?(item) } }
     
    
}
