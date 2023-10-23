//
//  MainCategoryCollectionViewCell.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 09/08/2023.
//

import UIKit
import Kingfisher

class MainCategoryCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlets...
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    //MARK: - Variables...
    var data: Categories? {
        didSet {
            guard let data = data else { return }
            if let postImageUrl = URL(string: data.icon?.activeIcon ?? "") {
                self.categoryImageView.kf.setImage(with: postImageUrl, placeholder: UIImage(named: "IMGplaceholder"))
            }
            categoryNameLabel.text = data.name
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
    func setupCell(){
        print(categoryImageView.frame)
        let cornerRadius = categoryImageView.frame.width / 2
        categoryImageView.layer.cornerRadius = cornerRadius
    }
    
    
    //MARK: - Actions...


}
