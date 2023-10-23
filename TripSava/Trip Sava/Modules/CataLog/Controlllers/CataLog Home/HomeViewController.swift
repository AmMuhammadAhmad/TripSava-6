//
//  HomeViewController.swift
//  TripsavaApkDesign
//
//  Created by HF on 08/06/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Outlets...
    @IBOutlet weak var shopingSegmentControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var bottomLinksLabel: UILabel!
    @IBOutlet weak var shoppingTermsAndConfitionsView: UIView!
    @IBOutlet weak var searchTextField: TextField!
    @IBOutlet weak var searchViewHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var searchViewTopAnchor: NSLayoutConstraint!
    
    // MARK: - Variables...
    let readMoreMessage = "Disclaimer: All products and services featured are independently selected, reviewed and tested by the TripSava team. Some of our recommended products & services are not available outside the United States. Check individual retailers for international shipping or local product availability. Also, full disclosure, we may earn affiliate income from your purchases through our partnerships with retailers."
    let identifeir = "ShopingListTableViewCell"
    let headerIdentifier = "HeaderTableViewCell"
    let footerIdentifire = "ShopingListFooterTableViewCell"
    let customCellIdentifire = "CustomCell"
    let messageString = "Disclaimer: this shopping list contains affiliate links. Read our Learn more."
    let disclaimer = "Disclaimer:"
    let linkString = "Learn more."
    var favProductIds:[String] = []
    
    // MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
   
    
    // MARK: - Functions...
    
    ///setupView...
    func setupView(){ UpdateData() }
    
    ///UpdateData...
    func UpdateData() {
        getAllFavoriteIDs()
        let firstViewController = storyboard?.instantiateViewController(withIdentifier: "ShopingListViewController") as? ShopingListViewController
        self.addChildViewController(firstViewController!, toView: containerView)
        setupSegmentController(); setUpTermsAndConditionAttributedString()
        if !appCredentials.isFirstTimeOpenShpoingList { shoppingTermsAndConfitionsView.isHidden = false; appCredentials.isFirstTimeOpenShpoingList = true }
        else { shoppingTermsAndConfitionsView.isHidden = true }
       
    }
     
    ///setupSegmentController...
    func setupSegmentController(){
        let textAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(hex: "#8A8A8A")  ]
        shopingSegmentControl.setTitleTextAttributes(textAttributes, for: .normal)
        shopingSegmentControl.selectedSegmentTintColor = UIColor.white
        shopingSegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
    }
    
    ///setUpTermsAndConditionAttributedString...
    func setUpTermsAndConditionAttributedString(){
        
        let msg = messageString
        let attributedString = NSMutableAttributedString(string: msg)
        
        let completetxtrange = (msg as NSString).range(of: msg)
        attributedString.addAttributes([NSAttributedString.Key.font : Constants.applyFonts_DMSans(style: .regular, size: 12), NSAttributedString.Key.foregroundColor : UIColor(hex: "#929292")], range: completetxtrange)
        
        let range = (msg as NSString).range(of: disclaimer)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(hex: "#474847", alpha: 0.60), NSAttributedString.Key.font : Constants.applyFonts_DMSans(style: .Medium, size: 12)], range: range)
        
        let rangeForLink = (msg as NSString).range(of: linkString)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(hex: "#E26A2B"), NSAttributedString.Key.font : Constants.applyFonts_DMSans(style: .Medium, size: 12)], range: rangeForLink)
        
        attributedString.append(NSAttributedString(string: ".aa   s   aa.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.clear, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]))
        
        bottomLinksLabel.isUserInteractionEnabled = true;
        DispatchQueue.main.async { self.bottomLinksLabel.attributedText = attributedString }
        bottomLinksLabel.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(handleMsgTapGesture(getsture:))))
    }
    
    ///handleMsgTapGesture...
    @objc func handleMsgTapGesture(getsture: UITapGestureRecognizer) {
        let range = (bottomLinksLabel.text! as NSString).range(of: linkString)
        if getsture.didTapAttributedTextInLabell(label: bottomLinksLabel, inRange: range) {
            
            let attributedString = getAttributedString(message: readMoreMessage, msgColor: UIColor(hex: "#474847", alpha: 0.60), msgFont: Constants.applyFonts_DMSans(style: .regular, size: 14), boldTextList: [disclaimer], boldTextColorsList: [UIColor(hex: "#929292")], boldTextFontsList: [Constants.applyFonts_DMSans(style: .Medium, size: 14)])
            shoppingTermsAndConfitionsView.isHidden = true; self.showCustomMessageView(attributedString: attributedString) { }
        }
    }
    
    
    
    // MARK: - Button Actions...
    
    ///searchBtnAction...
    @IBAction func searchBtnAction(_ sender: Any) {
        self.pushViewController(storyboard: "Home", identifier: "SearchProductsResultsViewController")
    }
    
    ///segmentControlValueChanged...
    @IBAction func segmentControlValueChanged(_ sender: CustomSegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            searchTextField.placeholder = "Search travel products..."; searchViewHeightAnchor.constant = 0; searchViewTopAnchor.constant = 0
            headerLabel.text = "Shopping List"; searchView.isHidden = true; appCredentials.catalogSelectedTab = "Shoping List"
            let firstViewController = storyboard?.instantiateViewController(withIdentifier: "ShopingListViewController") as? ShopingListViewController
            switchToViewController(viewController: firstViewController!, containerView: containerView)
        } else if sender.selectedSegmentIndex == 1 {
            searchTextField.placeholder = "Search travel products..."; searchViewHeightAnchor.constant = 50; searchViewTopAnchor.constant = 20
            headerLabel.text = "Products"; searchView.isHidden = false; appCredentials.catalogSelectedTab = "Product"
            let secondViewController = storyboard?.instantiateViewController(withIdentifier: "ProductsCategoriesViewController") as? ProductsCategoriesViewController
            switchToViewController(viewController: secondViewController!, containerView: containerView)
        }
        else {
            searchTextField.placeholder = "Search travel service..."; searchViewHeightAnchor.constant = 50; searchViewTopAnchor.constant = 20
            headerLabel.text = "Services"; searchView.isHidden = false; appCredentials.catalogSelectedTab = "Service"
            let secondViewController = storyboard?.instantiateViewController(withIdentifier: "ProductsCategoriesViewController") as? ProductsCategoriesViewController
            switchToViewController(viewController: secondViewController!, containerView: containerView)
        }
    }
    
    ///shoppingTermsAndConditionsCloseBtnAction...
    @IBAction func shoppingTermsAndConditionsCloseBtnAction(_ sender: Any) { shoppingTermsAndConfitionsView.isHidden = true }
     
}

//MARK: - Network layer...
extension HomeViewController {
    
    ///getFavoriteProducts...
    func getAllFavoriteIDs(){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.getFavoritesIDs() { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true {  self.favProductIds.removeAll();
                    response.favourites?.forEach { product in self.favProductIds.append(product.item ?? "") }
                    appCredentials.allFavoritesIDs = self.favProductIds
                }; self.hideRappleActivity()
            case .failure(let error): self.hideRappleActivity(); print(error)
            }
        }
    }
    
    
}
