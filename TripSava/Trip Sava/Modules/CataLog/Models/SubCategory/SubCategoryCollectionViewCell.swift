//
//  SubCategoryCollectionViewCell.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 10/08/2023.
//

import UIKit

class SubCategoryCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlets...
    @IBOutlet weak var subCategoryNameLabel: UILabel!
    @IBOutlet weak var selectedBar: UILabel!
    
    
    //MARK: - Variables...
    
    ///name...
    var name: String? {
        didSet {
            guard let name = name else { return }
            subCategoryNameLabel.text = name
        }
    }
    
    ///isSelected...
    override var isSelected: Bool {
        didSet {
            if isSelected {
                selectedBar.isHidden = false; subCategoryNameLabel.textColor = UIColor(hex: "#E26A2B")
                subCategoryNameLabel.font = Constants.applyFonts_DMSans(style: .Medium, size: 12)
            }
            else {
                selectedBar.isHidden = true; subCategoryNameLabel.textColor = UIColor(hex: "#808080")
                subCategoryNameLabel.font = Constants.applyFonts_DMSans(style: .regular, size: 12)
            }
        }
    }
    
    
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
