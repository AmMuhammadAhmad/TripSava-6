//
//  LibraryCollectionViewCell.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 16/06/2023.
//

import UIKit
import Kingfisher

class LibraryCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlets...
    @IBOutlet weak var blogImageView: UIImageView!
    @IBOutlet weak var blogTitleLabel: UILabel!
    
    
    //MARK: - Variables...
    var data: BlogResults? {
        didSet {
            guard let data = data else { return }
            if let postImageUrl = URL(string: data.thumbnail ?? "") {
                self.blogImageView.kf.setImage(with: postImageUrl, placeholder: UIImage(named: "IMGplaceholder"))
            }
            blogTitleLabel.text = data.name
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
