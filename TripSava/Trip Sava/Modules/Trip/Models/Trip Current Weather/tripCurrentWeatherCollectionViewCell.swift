//
//  tripCurrentWeatherCollectionViewCell.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 13/06/2023.
//

import UIKit
import Kingfisher

class tripCurrentWeatherCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlets...
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherConditionImageView: UIImageView!
    @IBOutlet weak var minTemLabel: UILabel!
    @IBOutlet weak var maxTemLabel: UILabel!
    
    
    //MARK: - Variables...
    var data: WeatherData? {
        didSet {
            guard let data = data else { return }
            if let waetherImageUrl = URL(string: "https:" + (data.condition?.icon ?? "")) {
                self.weatherConditionImageView.kf.setImage(with: waetherImageUrl, placeholder: UIImage(named: "IMGplaceholder"))
            }
            cityNameLabel.text = data.location?.name
            dayLabel.text = self.getDayNameAndDate(from: data.date ?? "")
            minTemLabel.text = "\(Int(data.minTem ?? 0.0))º"; maxTemLabel.text = "\(Int(data.maxTem ?? 0.0))º"
        }
    }
   
    ///hoursData...
    var hoursData: HourlyInfo? {
        didSet {
            guard let data = hoursData else { return }
            if let waetherImageUrl = URL(string: "https:" + (data.condition?.icon ?? "")) {
                self.weatherConditionImageView.kf.setImage(with: waetherImageUrl, placeholder: UIImage(named: "IMGplaceholder"))
            }
            
            dayLabel.text = self.extractTimeFromDateTime(dateTimeString: data.time ?? "")
            cityNameLabel.text = ""; minTemLabel.text = "\(Int(data.temp_f ?? 0.0))º"; maxTemLabel.isHidden = true
            
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
