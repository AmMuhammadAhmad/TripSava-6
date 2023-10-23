//
//  ProductsCategoriesViewController.swift
//  TripsavaApkDesign
//
//  Created by HF on 15/06/2023.
//

import UIKit

class ProductsCategoriesViewController: UIViewController {
    
    // MARK: - Outlets...
    @IBOutlet weak var mainCategoryCollectionViewHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var productCategoriesCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var mainCategoryCollectionView: UICollectionView!
    @IBOutlet weak var seeAllBtn: UIButton!
    @IBOutlet weak var favouriteCollectionEmptyView: UIView!
    @IBOutlet weak var favouriteHeaderLabel: UILabel!
    @IBOutlet weak var favouriteEmptyMsgLabel: UILabel!
    
    // MARK: - Variables...
    let identifire = "FavoriteProductCollectionViewCell"
    let categoryIdentifier = "MainCategoryCollectionViewCell"
    var primaryCategories: [Categories] = []
    var favoriteProducts: [Favourite] = []
    var selectedTab = appCredentials.catalogSelectedTab?.lowercased()
    
    
    // MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    ///viewWillAppear...
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getFavoriteProducts(type: self.selectedTab!)
    }
     
    ///viewDidLayoutSubviews..
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewDidLayoutSubviews()
    }
    
    
    
    // MARK: - Functions...
    
    ///setupView...
    func setupView(){ registerCollectionViewCell(); updateData()  }
    
    ///updateData...
    func updateData() {
        getPrimaryCategory(type: selectedTab!, parent: ""); favouriteHeaderLabel.text = "Favorite \(appCredentials.catalogSelectedTab!)s"
        favouriteEmptyMsgLabel.text = "You haven’t selected any favorite \(selectedTab!), yet. To add \(selectedTab!) to your favorites list, tap the heart on any \(selectedTab!)."
    }
    
    ///updateViewDidLayoutSubviews...
    func updateViewDidLayoutSubviews(){
        DispatchQueue.main.async {
            if self.favoriteProducts.isEmpty { self.collectionViewHeightContraint.constant = 420 }
            else { self.collectionViewHeightContraint.constant = self.productCategoriesCollectionView.contentSize.height + 70 }
            self.mainCategoryCollectionViewHeightAnchor.constant = self.mainCategoryCollectionView.contentSize.height
        }
    }
    
    ///registerCollectionViewCell...
    func registerCollectionViewCell(){
        mainCategoryCollectionView.register(UINib(nibName: categoryIdentifier, bundle: nil), forCellWithReuseIdentifier: categoryIdentifier)
        productCategoriesCollectionView.register(UINib(nibName: identifire, bundle: nil), forCellWithReuseIdentifier: identifire)
    }
    
    ///handlePrimaryCategorySelection...
    func handlePrimaryCategorySelection(parentId: String, categoryName: String){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "FeaturedProductsViewController") as! FeaturedProductsViewController
        controller.parentCategoryId = parentId; controller.categoryName = categoryName;
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    ///didTapOnHearth...
    func didTapOnHearth(id: String){
        favoriteProducts.removeAll { favProduct in  if favProduct.item?.id == id { return true } else { return false }  }
        DispatchQueue.main.async { self.handleFavoriteResponse() }
    }
    
    ///seeAllBtnAction..
    func seeAllBtnAction(){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ViewAllCategoriesViewController") as! ViewAllCategoriesViewController
        controller.modalPresentationStyle = .overFullScreen; controller.modalTransitionStyle = .crossDissolve
        controller.primaryCategories = primaryCategories
        controller.dissmissCompletionHandler = { (categoryId, categoryName) in
            self.handlePrimaryCategorySelection(parentId: categoryId, categoryName: categoryName)
        }; self.present(controller, animated: true, completion: nil)
    }
    
    
    // MARK: - Button Actions...
    
    ///seeAllBtnAction...
    @IBAction func seeAllBtnAction(_ sender: Any) { seeAllBtnAction() }
    
}

// MARK: - Collection View DataScorce and Delegate...
extension ProductsCategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    ///numberOfItemsInSection...
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            if primaryCategories.count < 8 { return primaryCategories.count } else { return 8 }
        }
        return favoriteProducts.count
    }
    
    ///cellForItemAt...
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryIdentifier, for: indexPath) as! MainCategoryCollectionViewCell
            cell.data = primaryCategories[indexPath.item]
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifire, for: indexPath) as! FavoriteProductCollectionViewCell
            cell.controller = self; cell.dataForCategoryDetails = favoriteProducts[indexPath.item].item
            return cell
        }
    }
    
    ///sizeForItemAt...
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            let size  = collectionView.frame.size.width - 6
            return CGSize(width: size / 4, height: 100)
        }
        else {
            let size = collectionView.frame.size.width
            return CGSize(width: size / 2, height: 230)
        }
    }
    
    ///didSelectItemAt...
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            let category = primaryCategories[indexPath.item]
            handlePrimaryCategorySelection(parentId: category.id ?? "", categoryName: category.name ?? "Trip Sava") }
        else {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
            controller.selectedProduct = favoriteProducts[indexPath.item].item
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}



//MARK: - Network layer...
extension ProductsCategoriesViewController {
    
    ///getPrimaryCategory...
    func getPrimaryCategory(type: String, parent: String){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.getCategories(type: type, parent: parent) { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true {
                    self.getFavoriteProducts(type: self.selectedTab!)
                    self.primaryCategories = response.categories ?? []; self.updatePrimarySuccessRequest()
                }
                else { self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " " + "Please close and reopen your app") }
            case .failure(_): self.getFavoriteProducts(type: self.selectedTab!)
                self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " " + "Please close and reopen your app")
            }
        }
    }
    
    ///updatePrimarySuccessRequest...
    func updatePrimarySuccessRequest(){
        self.mainCategoryCollectionView.reloadData();
        if self.primaryCategories.count <= 8 { self.seeAllBtn.isHidden = true } else { self.seeAllBtn.isHidden = false }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { self.updateViewDidLayoutSubviews() }
    }
    
    ///getFavoriteProducts...
    func getFavoriteProducts(type: String){
        Constants.tripSavaServcesManager.getFavourites(type: type) { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true { self.favoriteProducts = response.favourites?.results ?? [] }; self.handleFavoriteResponse()
            case .failure(let error): print(error); self.handleFavoriteResponse()
            }
        }
    }
    
    ///handleFavoriteResponse...
    func handleFavoriteResponse(){
        if favoriteProducts.isEmpty { favouriteCollectionEmptyView.isHidden = false } else { favouriteCollectionEmptyView.isHidden = true }
        productCategoriesCollectionView.reloadData();
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { self.updateViewDidLayoutSubviews(); self.hideRappleActivity() }
    }

    
}


