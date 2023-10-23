//
//  UvCustomView.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 19/10/2023.
//

import UIKit
 
class UvCustomView: UIView {
   
   // MARK: - Variables...
   
   ///scrollView...
   let scrollView: UIScrollView = {
       let scrollView = UIScrollView(); scrollView.alwaysBounceVertical = false; scrollView.showsVerticalScrollIndicator = false
       scrollView.translatesAutoresizingMaskIntoConstraints = false; scrollView.showsHorizontalScrollIndicator = false
       return scrollView
   }()
   
   ///label...
   let label: UILabel = {
       let label = UILabel()
       label.setUpLabel(text: "", font: Constants.applyFonts_DMSans(style: .regular, size: 14), textColor: UIColor(hex: "#808080"), numberOfLines: 0, textBGcolor: .clear)
       return label
   }()
   
   ///spaceView...
   let spaceView: UIView = {
       let view = UIView(); view.backgroundColor = .clear; return view
   }()
   
   ///ButtonsstackView...
   lazy var optionsBtnStackView: UIStackView = {
       let buttonsStackView = UIStackView()
       buttonsStackView.axis = .vertical; buttonsStackView.alignment = .fill; buttonsStackView.distribution = .fill; buttonsStackView.spacing = 16
       return buttonsStackView
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
       
       //Set up optionsBtnStackView Constraints
       addsubViewWithConstraints(subView: scrollView, topAnchor: topAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, bottomAnchor: bottomAnchor)
       scrollView.addSubview(optionsBtnStackView)
       optionsBtnStackView.translatesAutoresizingMaskIntoConstraints = false
       optionsBtnStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
       optionsBtnStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
       optionsBtnStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
       optionsBtnStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
       scrollView.contentSize = CGSize(width: optionsBtnStackView.frame.width, height: optionsBtnStackView.frame.height)
       optionsBtnStackView.axis = .vertical
       
   }
   
   ///updateData...
   func updateData(headerTxt: String, details: [String]){
       
       if headerTxt != "" { label.text = headerTxt; optionsBtnStackView.addArrangedSubview(label) }
       if !details.isEmpty {
           for (index, data) in details.enumerated() {
               
               //MARK: - Variables...
               
               ///headerStackView...
               lazy var headerStackView: UIStackView = {
                   let buttonsStackView = UIStackView()
                   buttonsStackView.axis = .horizontal; buttonsStackView.alignment = .top; buttonsStackView.distribution = .fill; buttonsStackView.spacing = 1
                   return buttonsStackView
               }()
               
               ///dot view...
               let bollViewview: UIView = {
                   let view = UIView();
                   view.backgroundColor = UIColor(hex: "#808080"); view.layer.cornerRadius = 3
                   return view
               }()
               
               ///Dot parent view...
               let view: UIView = {
                   let view = UIView()
                   view.addsubViewWithConstraints(subView: bollViewview, centerXAnchor: view.centerXAnchor, centerYAnchor: view.centerYAnchor, widthAnchor: 6, heightAnchor: 6, centerYAnchorConstant: 2)
                   return view
               }()
               
               ///lineView
               let lineView: UIView = {
                   let view = UIView(); view.layer.cornerRadius = view.frame.height * 0.5; view.backgroundColor = UIColor(hex: "#EBEBEB")
                   return view
               }()
                
               ///lineParentView...
               let lineParentView: UIView = {
                   let view = UIView();
                   view.backgroundColor = .clear; view.layer.cornerRadius = 3
                   view.addsubViewWithConstraints(subView: lineView, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, centerYAnchor: view.centerYAnchor, heightAnchor: 1)
                   return view
               }()
                
               ///detailLabel...
               let detailLabel: UILabel = {
                   let label = UILabel()
                   label.setUpLabel(text: data, font: Constants.applyFonts_DMSans(style: .regular, size: 14), textColor: UIColor(hex: "#808080"), numberOfLines: 0, textBGcolor: .clear)
                   label.attributedText = attributedTextWithMarkdownStyleFormatting(data)
                   return label
               }()
                
               ///Setup view
               lineParentView.heightAnchor.constraint(equalToConstant: 1).isActive = true
               view.widthAnchor.constraint(equalToConstant: 20).isActive = true; view.heightAnchor.constraint(equalToConstant: 20).isActive = true
               headerStackView.addArrangedSubview(view); headerStackView.addArrangedSubview(detailLabel)
               optionsBtnStackView.addArrangedSubview(headerStackView)
               if index < details.count - 1 { optionsBtnStackView.addArrangedSubview(lineParentView) }
           }
       }
         
       optionsBtnStackView.addArrangedSubview(spaceView) /// add space at the end...
         
   }
   
   
   // MARK: - Actions...
      
}

 

