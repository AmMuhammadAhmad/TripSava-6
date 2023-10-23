//
//  PackingPreprationCategoryCell.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 04/10/2023.
//

import UIKit
import Kingfisher

class PackingPreprationCategoryCell: UICollectionViewCell {

    //MARK: - IBOutlets...
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var selecetdCategoryBar: UILabel!
    @IBOutlet weak var gifIcon: UIImageView!
    
    //MARK: - Variables...
    var data: PackingOrPackingCategory? {
        didSet {
            guard let category = data else { return }
            categoryNameLabel.text = category.name
            if let categoryImageUrl = URL(string: data?.icon?.inactiveIcon ?? "") {
                self.categoryImageView.kf.setImage(with: categoryImageUrl, placeholder: UIImage(named: "")); selecetdCategoryBar.isHidden = true
                categoryImageView.contentMode = .scaleAspectFit; gifIcon.isHidden = true; categoryImageView.isHidden = false
            }
        }
    }
    
    ///preprationData...
    var preprationData: PreprationData? {
        didSet {
            guard let data = preprationData else { return }
            categoryNameLabel.text = data.title; categoryImageView.image = UIImage(named: data.imageUrl)
            categoryNameLabel.textColor = UIColor(hex: "#808080"); categoryImageView.tintColor = UIColor(hex: "#808080")
        }
    }
    
    ///isSelected...
    override var isSelected: Bool {
        didSet {
            
            //Sellected State for Perparation
            if let data = preprationData {
                if isSelected { /// if selected sate of collecion view
                    categoryNameLabel.text = data.title; categoryImageView.image = UIImage(named: data.imageUrl)
                    gifIcon.isHidden = true; categoryImageView.isHidden = false; categoryImageView.tintColor = UIColor(hex: "#E26A2B")
                    categoryNameLabel.textColor = UIColor(hex: "#E26A2B"); selecetdCategoryBar.isHidden = false;
                    selecetdCategoryBar.backgroundColor = UIColor(hex: "#E26A2B")
                }
                else {
                    categoryNameLabel.text = data.title; categoryImageView.image = UIImage(named: data.imageUrl)
                    gifIcon.isHidden = true; categoryImageView.isHidden = false; categoryImageView.tintColor = UIColor(hex: "#808080")
                    categoryNameLabel.textColor = UIColor(hex: "#808080"); selecetdCategoryBar.isHidden = true
                }
            }
             
            //Sellected State for Packing...
            else {
                if isSelected { /// if selected sate of collecion view
                    guard let category = data else { return }
                    if let categoryImageUrl = URL(string: data?.icon?.gif ?? "") {
                        self.gifIcon.kf.setImage(with: categoryImageUrl, placeholder: UIImage(named: ""), options: [.transition(.fade(0.2))])
                        gifIcon.contentMode = .scaleAspectFit; gifIcon.isHidden = false; categoryImageView.isHidden = true
                        categoryNameLabel.textColor = UIColor(hex: "#000000"); selecetdCategoryBar.isHidden = false
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                            if let newImageURL = URL(string: self.data?.icon?.activeIcon ?? "") {
                                self.categoryImageView.kf.setImage(with: newImageURL, placeholder: UIImage(named: ""))
                                self.categoryImageView.isHidden = false; self.gifIcon.isHidden = true
                            }
                        }
                    }
                }
                else {
                    if let categoryImageUrl = URL(string: data?.icon?.inactiveIcon ?? "") {
                        self.categoryImageView.kf.setImage(with: categoryImageUrl, placeholder: UIImage(named: ""), options: [.transition(.fade(0.2))])
                        categoryImageView.contentMode = .scaleAspectFit; gifIcon.isHidden = true; categoryImageView.isHidden = false
                        categoryNameLabel.textColor = UIColor(hex: "#808080"); selecetdCategoryBar.isHidden = true
                    }
                }
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
    func setupCell(){
        //self.backgroundColor = .red
    }
    
    
    //MARK: - Actions...


}
