//
//  OnBoardingCollectionViewCell.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 06/06/2023.
//

import UIKit
import Lottie

class OnBoardingCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets...
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var subHeadingLabel: UILabel!
    @IBOutlet weak var imageHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var imageTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var imageBottomAnchor: NSLayoutConstraint!
    @IBOutlet weak var animationView: LottieAnimationView!
    
    //MARK: - Variables...
    var data: OnBoardingModel? {
        didSet {
            guard let data = data else { return }
            if indexPath?.item == 0 {
                imageView.isHidden = true; animationView.isHidden = false
                animationView.contentMode = .scaleAspectFit
                animationView.loopMode = .loop
                animationView.animationSpeed = 1
                titlelabel.text = data.title
                subHeadingLabel.text = data.subHeading
                animationView.play()
            }
            else {
                imageView.isHidden = false; animationView.isHidden = true
                imageView.image = UIImage(named: data.onBoardImgName)
                titlelabel.text = data.title
                subHeadingLabel.text = data.subHeading
            }
            
        }
    }
    
    var indexPath: IndexPath?
    
    //MARK: - Cell Init Methods...
    
    ///awakeFromNib...
    override func awakeFromNib() {
        super.awakeFromNib()
         setupCell()
    }
    
    
    //MARK: - Functions...
    
    ///setupCell...
    func setupCell(){ checkDeviceModel() }
    
    ///checkDeviceModel...
    func checkDeviceModel() {
        // Usage example...
        let device = UIDevice.current; let modelName = device.modelName
        print(modelName)
        switch modelName {
        case "iPhone SE", "iPhone SE (2nd generation)": imageHeightAnchor.constant = 160
        case "iPhone 6", "iPhone 6s", "iPhone 7", "iPhone 8": imageHeightAnchor.constant = 150
        case "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus": imageHeightAnchor.constant = 160
        case "iPhone X", "iPhone XS", "iPhone 11 Pro": imageHeightAnchor.constant = 170
        case "iPhone XR", "iPhone 11": imageHeightAnchor.constant = 170
        case "iPhone XS Max", "iPhone 11 Pro Max": imageHeightAnchor.constant = 185
        case "iPhone 12 Mini": imageHeightAnchor.constant = 170
        case "iPhone 12", "iPhone 12 Pro": imageHeightAnchor.constant = 175
        case "iPhone 12 Pro Max": imageHeightAnchor.constant = 185
        case "iPhone 13 Mini": imageHeightAnchor.constant = 170
        case "iPhone 13", "iPhone 13 Pro": imageHeightAnchor.constant = 175
        case "iPhone 13 Pro Max": imageHeightAnchor.constant = 185
        case "iPhone 14", "iPhone 14 Pro": imageHeightAnchor.constant = 175
        case "iPhone 14 Pro Max": imageHeightAnchor.constant = 185
        default:
            if UIDevice.current.userInterfaceIdiom == .pad { imageHeightAnchor.constant = 300 }
            else { imageHeightAnchor.constant = 185 }
            
        }
    }
    
    
    //MARK: - Actions...

}
