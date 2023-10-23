//
//  PowerAdapterCell.swift
//  TripSava
//
//  Created by Hamza Shahbaz on 16/10/2023.
//

import UIKit

class PowerAdapterCell: UICollectionViewCell {
    
    @IBOutlet weak var powerAdapterImg:UIImageView!
    
    var imgName:String?
    
    func initCell(){
        powerAdapterImg.image = UIImage(named: "type\(imgName ?? "typeA")")
    }
}
