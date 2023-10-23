//
//  CreatepackingCollectionViewCell.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 13/06/2023.
//

import UIKit

class CreatepackingCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlets...
    @IBOutlet weak var checkButton: UIButton! 
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var listStackView: UIStackView!
    
    //MARK: - Variables...
    
    var data: [String]? {
        didSet {
            guard let names = data else { return }
            listStackView.removeFullyAllArrangedSubviews()
            for (index, name) in names.enumerated() {
                if index <= 3 {
                    let nameLabel: UILabel = {
                        let label = UILabel()
                        label.setUpLabel(text: name, font: Constants.applyFonts_DMSans(style: .regular, size: 12), textAlignment: .left, textColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.4), numberOfLines: 0, textBGcolor: .clear)
                        return label
                    }()
                    nameLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
                    listStackView.addArrangedSubview(nameLabel)
                }
            }
            if names.count > 3 {
                uploadButton.heightAnchor.constraint(equalToConstant: 12).isActive = true
                listStackView.addArrangedSubview(uploadButton)
            }
            
        }
    }
    
    
    lazy var uploadButton: UIButton = {
        var button = UIButton(type: .system)
        button.setButtonValues(text: "See 6 more", font: Constants.applyFonts_DMSans(style: .Medium, size: 13), textColor: UIColor(red: 0, green: 0.212, blue: 0.506, alpha: 1), BgColor: UIColor.clear, tintColor: UIColor(red: 0, green: 0.212, blue: 0.506, alpha: 1))
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    //MARK: - Cell Init Methods...
    
    ///awakeFromNib...
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    
    //MARK: - Functions...
    
    ///setupCell...
    func setupCell(){ }
    
    
    //MARK: - Actions...


}
