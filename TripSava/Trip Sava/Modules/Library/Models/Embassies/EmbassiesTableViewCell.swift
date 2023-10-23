//
//  EmbassiesTableViewCell.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 01/08/2023.
//

import UIKit
import Kingfisher

class EmbassiesTableViewCell: UITableViewCell {

    //MARK: - IBOutlets...
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK: - Variables...
    var data: Countries? {
        didSet {
            guard let data = data else { return }
            if let postImageUrl = URL(string: data.flag ?? "") {
                self.flagImageView.kf.setImage(with: postImageUrl, placeholder: UIImage(named: "IMGplaceholder"))
            }
            nameLabel.text = data.name
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
