//
//  FeaturedProductsViewController.swift
//  TripsavaApkDesign
//
//  Created by HF on 16/06/2023.
//

import UIKit

class FeaturedProductsViewController: UIViewController {
    
    // MARK: - Outlets...
    @IBOutlet weak var featureProductCollectionView: UICollectionView!
    @IBOutlet weak var safetySecurityCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightAnchor: NSLayoutConstraint! 
    @IBOutlet weak var subCategoryCollectionView: UICollectionView!
    @IBOutlet weak var featureProductView: UIView!
    @IBOutlet weak var mainCategoryProdcutLabel: UILabel!
    @IBOutlet weak var totalProductsLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var featuredProductTotalItemsLabel: UILabel!
    @IBOutlet weak var featuredProductCollectionViewheightAnchor: NSLayoutConstraint!
    @IBOutlet weak var featuredHeaderLabel: UILabel!
    
    // MARK: - Variables...
    var identifire = "FavoriteProductCollectionViewCell"
    let indetifierForSubCategory = "SubCategoryCollectionViewCell"
    var secondaryCategories: [Categories] = []
    var featuredProducts: [ProductsResults] = []
    var products: [ProductsResults] = [] 
    var parentCategoryId = ""
    var categoryName = ""
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
        updateOnViewWillAppear()
    }
    
    ///viewDidLayoutSubviews..
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateHeightOfCollectionView()
    }
     
    
    // MARK: - Functions...
    
    ///setupView...
    func setupView(){
        registerCollectionViewCell(); updateData()
    }
    
    ///updateOnViewWillAppear...
    func updateOnViewWillAppear(){
        featureProductCollectionView.reloadData(); safetySecurityCollectionView.reloadData()
    }
    
    ///updateData...
    func updateData(){
        self.headerLabel.text = categoryName
        self.featuredHeaderLabel.text = "Tripsava Featured \(appCredentials.catalogSelectedTab!)"
        self.getSecondaryCategory(type: selectedTab!, parent: parentCategoryId)
    }
    
    ///registerCollectionViewCell...
    func registerCollectionViewCell(){
        subCategoryCollectionView.register(UINib(nibName: indetifierForSubCategory, bundle: nil), forCellWithReuseIdentifier: indetifierForSubCategory)
        featureProductCollectionView.register(UINib(nibName: identifire, bundle: nil), forCellWithReuseIdentifier: identifire)
        safetySecurityCollectionView.register(UINib(nibName: identifire, bundle: nil), forCellWithReuseIdentifier: identifire)
    }
    
    ///updateHeightOfCollectionView...
    func updateHeightOfCollectionView(){
        DispatchQueue.main.async {
            self.collectionViewHeightAnchor.constant = self.safetySecurityCollectionView.contentSize.height + 100
        }
    }
    
    ///handlesearchBtnAction...
    func handlesearchBtnAction(){
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SearchProductsResultsViewController") as! SearchProductsResultsViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    ///handleBackBtnAction...
    func handleBackBtnAction(){ self.popViewController() }
    
    
    // MARK: - Button Actions...
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { handleBackBtnAction() }
    
    ///searchBtnAction...
    @IBAction func searchBtnAction(_ sender: Any) { handlesearchBtnAction()  }
    
    ///didTapOnHearth...
    func didTapOnHearth(indexPath: IndexPath){ /// cell fav hearth action...
        featureProductCollectionView.reloadItems(at: [indexPath]); safetySecurityCollectionView.reloadItems(at: [indexPath])
    }
    
}

// MARK: - Collection View DataScorce and Delegate...
extension FeaturedProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    ///numberOfItemsInSection...
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 2 { return secondaryCategories.count }
        if collectionView.tag == 1 { return products.count }
        else { return featuredProducts.count }
    }
    
    ///cellForItemAt...
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 { /// Feature product...
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifire, for: indexPath) as! FavoriteProductCollectionViewCell
            cell.controller = self; cell.indexPath = indexPath; cell.dataForCategoryDetails = featuredProducts[indexPath.item]
            return cell
        }
        else if collectionView.tag == 1 { /// Selected category products...
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifire, for: indexPath) as! FavoriteProductCollectionViewCell
            cell.controller = self; cell.indexPath = indexPath; cell.dataForCategoryDetails = products[indexPath.item]
            return cell
        }
        else { /// subcategories collection view that are on top...
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: indetifierForSubCategory, for: indexPath) as! SubCategoryCollectionViewCell
            cell.name = secondaryCategories[indexPath.item].name
            return cell
        }
       
    }
    
    ///collectionViewLayout...
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 2 {
            let name = secondaryCategories[indexPath.item].name ?? ""
            let font = Constants.applyFonts_DMSans(style: .Medium, size: 12)
            return CGSize(width: UILabel.requiredWidth(for: name, with: font), height: collectionView.frame.height)
        }
        else if collectionView.tag == 1 { let size  = collectionView.frame.size.width; return CGSize(width: size / 2, height: 230) }
        else { let size  = collectionView.frame.size.width; return CGSize(width: size / 2, height: 230) }
    }
    
    ///didSelectItemAt...
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 2 { ///subcategories collection selection...
            let subCategory = secondaryCategories[indexPath.item]
            self.mainCategoryProdcutLabel.text = subCategory.name
            if selectedTab == "product" { self.getProducts(primaryCategory: parentCategoryId, secondaryCategory: subCategory.id ?? "", name: "", isFeatured: false, lastCall: true) }
            else { self.getServices(primaryCategory: parentCategoryId, secondaryCategory: subCategory.id ?? "", name: "", isFeatured: false, lastCall: true) }
        }
        else if collectionView.tag == 1 { ///Selected category products selection...
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
            controller.selectedProduct = products[indexPath.item]
            self.navigationController?.pushViewController(controller, animated: true)
        }
        else { /// featured product selection
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
            controller.selectedProduct = featuredProducts[indexPath.item]
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
}

    
    

//MARK: - Network layer...
extension FeaturedProductsViewController {
    
    ///getPrimaryCategory...
    func getSecondaryCategory(type: String, parent: String){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.getCategories(type: type, parent: parent) { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true {
                    self.secondaryCategories = response.categories ?? []; self.subCategoryCollectionView.reloadData();
                    self.mainCategoryProdcutLabel.text = self.secondaryCategories.first?.name
                    self.handleSubCategoriesSuccessResponse()
                }
                else { self.handleSubCategoriesSuccessResponse(); self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " " + "Please close and reopen your app") }
            case .failure(let error): print(error)
                self.handleSubCategoriesSuccessResponse()
                self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " " + "Please close and reopen your app")
            }
        }
    }
    
    ///handleSubCategoriesSuccessResponse...
    func handleSubCategoriesSuccessResponse(){
        if selectedTab == "product" {
            if let firstSubCategory = secondaryCategories.first {
                subCategoryCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
                self.getProducts(primaryCategory: parentCategoryId, secondaryCategory: firstSubCategory.id ?? "", name: "", isFeatured: false, lastCall: false)
                self.getProducts(primaryCategory: parentCategoryId, secondaryCategory: firstSubCategory.id ?? "", name: "", isFeatured: true, lastCall: true)
            }
            else {
                self.getProducts(primaryCategory: parentCategoryId, secondaryCategory: "", name: "", isFeatured: false, lastCall: false)
                self.getProducts(primaryCategory: parentCategoryId, secondaryCategory: "", name: "", isFeatured: true, lastCall: true)
            }
        }
        else {
            if let firstSubCategory = secondaryCategories.first {
                subCategoryCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
                self.getServices(primaryCategory: parentCategoryId, secondaryCategory: firstSubCategory.id ?? "", name: "", isFeatured: false, lastCall: false)
                self.getServices(primaryCategory: parentCategoryId, secondaryCategory: firstSubCategory.id ?? "", name: "", isFeatured: true, lastCall: true)
            }
            else {
                self.getServices(primaryCategory: parentCategoryId, secondaryCategory: "", name: "", isFeatured: false, lastCall: false)
                self.getServices(primaryCategory: parentCategoryId, secondaryCategory: "", name: "", isFeatured: true, lastCall: true)
            }
        }
    }
    
    ///getProducts...
    func getProducts(primaryCategory: String, secondaryCategory: String, name: String, isFeatured: Bool, lastCall: Bool){
        Constants.tripSavaServcesManager.getProducts(primaryCategory: primaryCategory, secondaryCategory: secondaryCategory, name: name, isFeatured: isFeatured) { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true {
                    if isFeatured { self.featuredProducts = response.products?.results ?? []; self.handleFeaturedProductSuccessResponse(lastCall: lastCall) }
                    else { self.products = response.products?.results ?? []; self.handleProductSuccessResponse(lastCall: lastCall) }
                }
                else {
                    if isFeatured { self.handleFeaturedProductSuccessResponse(lastCall: lastCall) } else { self.handleProductSuccessResponse(lastCall: lastCall) }
                }
            case .failure(_):
                if isFeatured { self.handleFeaturedProductSuccessResponse(lastCall: lastCall) } else { self.handleProductSuccessResponse(lastCall: lastCall) }
            }
        }
    }
    
    ///getServices...
    func getServices(primaryCategory: String, secondaryCategory: String, name: String, isFeatured: Bool, lastCall: Bool){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.getServices(primaryCategory: primaryCategory, secondaryCategory: secondaryCategory, name: name, isFeatured: isFeatured) { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true {
                    if isFeatured { self.featuredProducts = response.services?.results ?? []; self.handleFeaturedProductSuccessResponse(lastCall: lastCall) }
                    else { self.products = response.services?.results ?? []; self.handleProductSuccessResponse(lastCall: lastCall) }
                }
                else {
                    if isFeatured { self.handleFeaturedProductSuccessResponse(lastCall: lastCall) } else { self.handleProductSuccessResponse(lastCall: lastCall) }
                }
            case .failure(let error):
                print(error)
                self.hideRappleActivity()
            }
        }
    }
    
    ///handleProductSuccessResponse...
    func handleProductSuccessResponse(lastCall: Bool){
        totalProductsLabel.text = products.count <= 0 ? "No items available yet" : (products.count == 1 ? "1 item" : "\(products.count) items")
        self.safetySecurityCollectionView.reloadData()
        self.viewDidLayoutSubviews(); self.updateHeightOfCollectionView()
        if lastCall { self.hideRappleActivity() }
    }
    
    ///handleFeaturedProductSuccessResponse
    func handleFeaturedProductSuccessResponse(lastCall: Bool){
        if featuredProducts.isEmpty {
            featuredProductCollectionViewheightAnchor.constant = 0
            featureProductCollectionView.isHidden = true; featuredProductTotalItemsLabel.text = "No featured items available yet"
        }
        else {
            featureProductCollectionView.isHidden = false; featuredProductCollectionViewheightAnchor.constant = 240
            featuredProductTotalItemsLabel.text = featuredProducts.count == 1 ? "1 item" : "\(featuredProducts.count) items"
        }
        featureProductCollectionView.reloadData()
        if lastCall { self.hideRappleActivity() }
        
    }
     
}
