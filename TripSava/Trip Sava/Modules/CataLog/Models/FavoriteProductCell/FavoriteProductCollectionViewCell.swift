//
//  FavoriteProductCollectionViewCell.swift
//  TripsavaApkDesign
//
//  Created by HF on 15/06/2023.
//

import UIKit
import Kingfisher

class FavoriteProductCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets...
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var FavoritHeartBtn: UIButton!
    @IBOutlet weak var productNameLable: UILabel!
    @IBOutlet weak var productDescriptionLable: UILabel!
    
    // MARK: - Variables...
     
    var controller: UIViewController?; var indexPath: IndexPath?
    var selectedTab = appCredentials.catalogSelectedTab?.lowercased()
    
    ///dataForCategoryDetails...
    var dataForCategoryDetails: ProductsResults? {
        didSet {
            guard let data = dataForCategoryDetails else { return }
            if let postImageUrl = URL(string: data.imageUrl ?? "") {
                self.productImage.kf.setImage(with: postImageUrl, placeholder: UIImage(named: "IMGplaceholder"))
            }
            productNameLable.text = data.name; productNameLable.removeSoonLineBreakFromLabel()
            productDescriptionLable.text = data.brand; productDescriptionLable.removeSoonLineBreakFromLabel()
            
            ///check fav...
            if appCredentials.allFavoritesIDs.contains(data.id ?? "") { FavoritHeartBtn.setImage(UIImage(named: "heartSelected"), for: .normal) }
            else { FavoritHeartBtn.setImage(UIImage(named: "Hearth"), for: .normal) }
            
        }
    }
    
    
    // MARK: - InIt Methods...
    
    ///awakeFromNib...
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Functions...
    
    
    // MARK: - Actions... 
    @IBAction func ProductheartBtnAction(_ sender: Any) { updateUserfavourite() }
    
    

}

//MARK: - Network layer...
extension FavoriteProductCollectionViewCell {
    
    ///updateUserfavourite...
    func updateUserfavourite(){
        controller?.showRappleActivity()
        guard let data = dataForCategoryDetails else { self.controller?.hideRappleActivity(); return }
        Constants.tripSavaServcesManager.updateUserfavourite(item: data.id ?? "", type: selectedTab!) { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true { self.handleDidTapSuccessRessponse() } else { self.controller?.hideRappleActivity() }
            case .failure(let error): print(error); self.controller?.hideRappleActivity()
            }
        }
    }
    
    ///handleDidTapSuccessRessponse...
    func handleDidTapSuccessRessponse(){
        guard let data = dataForCategoryDetails else { self.controller?.hideRappleActivity(); return }
         
        if appCredentials.allFavoritesIDs.contains(data.id ?? "") {
            appCredentials.allFavoritesIDs.removeAll(where: { id in  if id == data.id ?? "" { return true } else { return false } })
        } else { appCredentials.allFavoritesIDs.append(data.id ?? "") }
         
        if let featuredProductsController = self.controller as? FeaturedProductsViewController { featuredProductsController.didTapOnHearth(indexPath: indexPath!) }
        if let productsCategoriesViewController = self.controller as? ProductsCategoriesViewController { productsCategoriesViewController.didTapOnHearth(id: data.id ?? "") }
        if let searchViewController = self.controller as? SearchProductsResultsViewController { searchViewController.didTapOnHearth() }
        self.controller?.hideRappleActivity()
        
    }
}
