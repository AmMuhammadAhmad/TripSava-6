//
//  ProductDetailsViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 19/06/2023.
//

import UIKit
import Kingfisher

class ProductDetailsViewController: UIViewController {
    
    //MARK: - IBOutlets...
    @IBOutlet weak var recommendedByTripSavaBtn: UIButton!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var isFavButton: UIButton!
    @IBOutlet weak var recommendedMessageLabel: UILabel!
    @IBOutlet weak var recommendMessageView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var aboutThisProductLabel: UILabel!
    @IBOutlet weak var addToShoppingListBtn: UIButton!
    @IBOutlet weak var shopBtn: UIButton!
    @IBOutlet weak var onAmazonBtn: UIButton!
    
    //MARK: - Variables...
    var selectedProduct: ProductsResults?
    var selectedTab = appCredentials.catalogSelectedTab?.lowercased()
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){ updateData() }
    
    ///updateData...
    func updateData(){
        guard let product = selectedProduct else { return }
        if let postImageUrl = URL(string: product.imageUrl ?? "") {
            self.productImageView.kf.setImage(with: postImageUrl, placeholder: UIImage(named: "IMGplaceholder"))
        }
         
        if appCredentials.allFavoritesIDs.contains(product.id ?? "") { isFavButton.setImage(UIImage(named: "heartSelected"), for: .normal) }
        else { isFavButton.setImage(UIImage(named: "heart"), for: .normal) }
        
        productNameLabel.text = product.name ?? "Trip sava"
        recommendedByTripSavaBtn.isHidden = !(product.isRecommended ?? false)
        
        if product.isRecommended ?? false { recommendMessageView.isHidden = false; recommendedMessageLabel.text = product.recommendationText }
        else { recommendMessageView.isHidden = true }
        
        if selectedTab == "product" { addToShoppingListBtn.isHidden = false; shopBtn.setTitle("Shop", for: .normal); onAmazonBtn.isHidden = false }
        else { addToShoppingListBtn.isHidden = true; shopBtn.setTitle("Learn More", for: .normal); onAmazonBtn.isHidden = true }
        
        aboutThisProductLabel.isUserInteractionEnabled = true
        aboutThisProductLabel.appendReadLess(after: product.description ?? "", trailingContent: .readless)
        aboutThisProductLabel.appendReadmore(after: product.description ?? "", trailingContent: .readmore)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLabel))
        aboutThisProductLabel.isUserInteractionEnabled = true
        aboutThisProductLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapLabel(_ sender: UITapGestureRecognizer) {
        guard let product = selectedProduct, let text = aboutThisProductLabel.text else { return }
        let readmore = (text as NSString).range(of: TrailingContent.readmore.text)
        let readless = (text as NSString).range(of: TrailingContent.readless.text)
        if sender.didTap(label: aboutThisProductLabel, inRange: readmore) {
            aboutThisProductLabel.appendReadLess(after: product.description ?? "", trailingContent: .readless)
        } else if  sender.didTap(label: aboutThisProductLabel, inRange: readless) {
            aboutThisProductLabel.appendReadmore(after: product.description ?? "", trailingContent: .readmore)
        } else { return }
    }
     
    ///handleAddToShoppingListBtnAction...
    func handleAddToShoppingListBtnAction(){
        guard let product = selectedProduct else { return }
        self.addNewItemIntoShoppingList(trip: "", product: product.id!, name: product.name!, isCustom: false)
    }
    
    ///handleShopBtnAction...
    func handleShopBtnAction(){
        guard let product = selectedProduct, let shopUrl = product.directUrl else {
            self.presentAlert(withTitle: "Alert", message: "This product does not have a URL link."); return }
        SafariViewController.shared.openUrlWith(linkString: shopUrl, Parentcontroller: self)
    }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    
    ///productLikeBtnAction...
    @IBAction func productLikeBtnAction(_ sender: Any) { self.updateUserfavourite() }
    
    ///addToShoppingListBtnAction...
    @IBAction func addToShoppingListBtnAction(_ sender: Any) { self.handleAddToShoppingListBtnAction() }
    
    ///shopBtnAction...
    @IBAction func shopBtnAction(_ sender: Any) { handleShopBtnAction() }
    
}




//MARK: - Network layer...
extension ProductDetailsViewController {
    
    ///updateUserfavourite...
    func updateUserfavourite(){
        self.showRappleActivity()
        guard let data = selectedProduct else { self.hideRappleActivity(); return }
        Constants.tripSavaServcesManager.updateUserfavourite(item: data.id ?? "", type: selectedTab!) { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true { self.handleDidTapSuccessRessponse() } else { self.hideRappleActivity() }
            case .failure(_): self.hideRappleActivity()
            }
        }
    }
    
    ///handleDidTapSuccessRessponse...
    func handleDidTapSuccessRessponse(){
        guard let data = selectedProduct else { self.hideRappleActivity(); return }
        if appCredentials.allFavoritesIDs.contains(data.id ?? "") {
            appCredentials.allFavoritesIDs.removeAll(where: { id in  if id == data.id ?? "" { return true } else { return false } })
        } else { appCredentials.allFavoritesIDs.append(data.id ?? "") }
        if appCredentials.allFavoritesIDs.contains(data.id ?? "") { isFavButton.setImage(UIImage(named: "heartSelected"), for: .normal) }
        else { isFavButton.setImage(UIImage(named: "heart"), for: .normal) }
        self.hideRappleActivity()
        
    }
    
    ///updateShoppingListItem...
    func updateShoppingListItem(name: String, isChecked: Bool, shoppingListId: String, itemId: String){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.updateShoppingListItem(name: name, isChecked: isChecked, shoppingListId: shoppingListId, itemId: itemId) { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true {
                    self.presentAlert(withTitle: "Alert", message: "Item added successfully to the shopping list")
                }
                else {
                    self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " Item Not update please try again")
                    self.hideRappleActivity()
                }
                
            case .failure(_):
                self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " Item Not updated please try again")
                self.hideRappleActivity()
            }
        }
    }
    
    ///addNewItemIntoShoppingList...
    func addNewItemIntoShoppingList(trip: String, product: String, name: String, isCustom: Bool){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.addNewItemIntoShoppingList(trip: trip, product: product, name: name, isCustom: isCustom) { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true {
                    self.hideRappleActivity()
                    self.presentAlert(withTitle: "Alert", message: "Item added successfully to the shopping list")
                }
                else {
                    self.hideRappleActivity()
                    self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " Item Not update please try again")
                }
                
            case .failure(_):
                self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " Item Not updated please try again")
                self.hideRappleActivity()
            }
        }
    }
    
    
    
    
}
