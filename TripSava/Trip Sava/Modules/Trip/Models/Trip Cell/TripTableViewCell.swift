//
//  TripTableViewCell.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 08/06/2023.
//

import UIKit
import Kingfisher

class TripTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets...
    @IBOutlet weak var tripImageView: UIImageView!
    @IBOutlet weak var tripName: UILabel!
    @IBOutlet weak var tripTitleImage: UIImageView!
    @IBOutlet weak var quickListView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var endInDaysView: UIView!
    @IBOutlet weak var endInDaysLabel: UILabel!
    @IBOutlet weak var archiveView: UIView!
    @IBOutlet weak var packedLabel: UILabel!
    @IBOutlet weak var toBuyLabel: UILabel!
    @IBOutlet weak var taskLeftLabel: UILabel!
    @IBOutlet weak var beachImageView: UIImageView!
    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var statsViewHeightAnchor: NSLayoutConstraint!
    
   
    //MARK: - Variables...
    var data: Trip? {
        didSet {
            guard let data = data else { return }
            tripName.text = data.name
            if let postImageUrl = URL(string: data.image ?? "") {
                self.tripImageView.kf.setImage(with: postImageUrl, placeholder: UIImage(named: "IMGplaceholder"))
            }
            locationLabel.text = "\(data.location?.city ?? ""), \(data.location?.country ?? "")"
            if data.tripType == "quicklist" { dateLabel.text =  getMonthNameAndDate(from: data.startDate ?? "") }
            else { dateLabel.text = self.formatDateWithFromToAndDays(startDateString: data.startDate ?? "", endDateString: data.endDate ?? "") }
            
            let startDate = parseDate(from: data.startDate ?? "", withOutputFormat: "yyyy-MM-dd")
            let endDate = parseDate(from: data.endDate ?? "", withOutputFormat: "yyyy-MM-dd")
            let currentDate = Date().formattedString(with: "yyyy-MM-dd")
              
            if startDate > currentDate { /// upcomming trip...
                endInDaysLabel.text = calculateTimesToGo(startDateString: currentDate, endDateString: startDate)
                statsView.isHidden = false; statsViewHeightAnchor.constant = 60
                toBuyLabel.text = "\(data.itemStats?.packing?.toBuy ?? 0)"
                packedLabel.text = "\(data.itemStats?.packing?.completedPercentage ?? 0)%"
                taskLeftLabel.text = "\(data.itemStats?.preparation?.toPrepareTotal ?? 0)"
            }
            
            if startDate <= currentDate && currentDate <= endDate { /// active Trip...
                endInDaysLabel.text = calculateDaysBetween(startDateString: Date().formattedString(with: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"), endDateString: data.endDate ?? "")
                statsView.isHidden = true; statsViewHeightAnchor.constant = 0
            }
            
            if startDate < currentDate && endDate < currentDate {  /// past trip
                endInDaysLabel.isHidden = true; statsView.isHidden = true; statsViewHeightAnchor.constant = 0
            }
            
            ///handle purpose img...
            if let purpose = data.tripStats?.purposes {
                print("PURPOSES are: \(purpose)")
                if purpose.contains("Business") && purpose.contains("Leisure") { tripTitleImage.isHidden = false; beachImageView.isHidden = false }
                else if purpose.contains("Business") { tripTitleImage.isHidden = false; beachImageView.isHidden = true }
                else if purpose.contains("Leisure") { tripTitleImage.isHidden = true; beachImageView.isHidden = false }
            }
             
            if data.tripType == "quicklist" {
                tripTitleImage.isHidden = true; 
                beachImageView.isHidden = true
                archiveView.isHidden = false;
                endInDaysView.isHidden = true
                quickListView.isHidden = false;
                tripTitleImage.isHidden = true;
                locationLabel.isHidden = true
            }
            else {
                print("4")
                quickListView.isHidden = true;
                //tripTitleImage.isHidden = true;
                locationLabel.isHidden = false;
                archiveView.isHidden = true; 
                endInDaysView.isHidden = false
            }
            
        }
    }
    
    
    //MARK: - Cell Init Methods...

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //MARK: - Functions...
    
    
    //MARK: - Actions...
    
}

//MARK: -


