//
//  TripSearchTableViewCell.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 16/06/2023.
//

import UIKit

class TripSearchTableViewCell: UITableViewCell {

    //MARK: - IBOutlets...
    @IBOutlet weak var tripImageView: UIImageView!
    @IBOutlet weak var tripLocation: UILabel!
    @IBOutlet weak var tripDate: UILabel!
     
    //MARK: - Variables...
    var data: Trip? {
        didSet {
            guard let data = data else { return }
            if let postImageUrl = URL(string: data.image ?? "") {
                self.tripImageView.kf.setImage(with: postImageUrl, placeholder: UIImage(named: "IMGplaceholder"))
            }
            let city = data.location?.city ?? "";  let country = data.location?.country ?? ""
            if city == "" && country == "" { tripLocation.text = data.name }
            else { tripLocation.text = "\(data.location?.city ?? ""), \(data.location?.country ?? "")" } 
            tripDate.text = parseDate(from: data.startDate ?? "", withOutputFormat: "MMMM d, yyyy")
               
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
