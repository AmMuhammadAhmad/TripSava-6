//
//  QLPackingCustomView.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 10/07/2023.
//

import UIKit

class QLPackingCustomView: UIView {
    
    // MARK: - Variables...
    
    ///label...
    lazy var label: UILabel = {
        let label = UILabel()
        label.setUpLabel(text: "", font: Constants.applyFonts_DMSans(style: .regular, size: 12), textColor: UIColor.init(hex: "#474847", alpha: 0.80), numberOfLines: 1,textBGcolor: .clear)
        return label
    }()
    
    ///label2...
    lazy var label2: UILabel = {
        let label2 = UILabel()
        label2.setUpLabel(text: "", font: Constants.applyFonts_DMSans(style: .regular, size: 12), textColor: UIColor.init(hex: "#474847", alpha: 0.80), numberOfLines: 1, textBGcolor: .clear)
        return label2
    }()
    
    ///labelsStackView...
    lazy var labelsStackView: UIStackView = {
        let labelsStack = UIStackView(arrangedSubviews: [label, label2])
        labelsStack.axis = .horizontal
        labelsStack.alignment = .fill
        labelsStack.distribution = .fillEqually
        labelsStack.spacing = 4
        labelsStack.backgroundColor = .clear
        return labelsStack
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
        self.backgroundColor = UIColor.clear
        addsubViewWithConstraints(subView: labelsStackView, topAnchor: topAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, bottomAnchor: bottomAnchor)
    }
    
    
    // MARK: - Actions...
    
    
}




