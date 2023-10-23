//
//  SearchProductsResultsViewController.swift
//  TripsavaApkDesign
//
//  Created by HF on 17/06/2023.
//

import UIKit
import Combine

class SearchProductsResultsViewController: UIViewController {
    
    // MARK: - Outlets...
    @IBOutlet weak var searchResultCollectionView: UICollectionView!
    @IBOutlet weak var totalProductsLabel: UILabel!
    @IBOutlet weak var searchTextLabel: UILabel!
    @IBOutlet weak var searchTextField: TextField!
    @IBOutlet weak var noProductFoundView: UIView!
    
    // MARK: - Variables...
    var identifire = "FavoriteProductCollectionViewCell"
    var products: [ProductsResults] = []
    var selectedTab = appCredentials.catalogSelectedTab?.lowercased()
    var isCommingForSearchProduct : Bool = false
    var searchItemText = ""
    
    private var searchCancellable: AnyCancellable?
    private var searchTextSubject = PassthroughSubject<String, Never>()
    
    
    // MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    // MARK: - Functions...
    
    ///setupView...
    func setupView(){ updateData() }
    
    ///updateData...
    func updateData(){
        registerCollectionViewCell()
        searchTextField.placeholder = "Search for a \(selectedTab ?? "")"
        if isCommingForSearchProduct { searchTextField.text = searchItemText; handleSearchTextfieldAction(text: searchItemText.lowercased()) }
        else { noProductFoundView.isHidden = true; totalProductsLabel.isHidden = false; totalProductsLabel.text = "You haven’t searched any \(selectedTab!)s, yet. To search \(selectedTab!)s, enter the \(selectedTab!) name or category name on the above search view." }
        searchTextField.addClearButtonWithExpandedSize(expandedWidth: 20, expandedHeight: 40)
        
    }
    
    ///setUpSearchbarTextField...
    func setUpSearchbarTextField(){
        searchCancellable = searchTextSubject .debounce(for: .milliseconds(500), scheduler: RunLoop.main) .removeDuplicates() .sink { [weak self] text in
            self?.handleSearchTextfieldAction(text: text)
        }
        searchTextField.addTarget(self, action: #selector(searchTextFieldDidChange), for: .editingChanged)
    }
    
    @objc private func searchTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            searchTextSubject.send(text)
        }
    }
    
    @objc func clearButtonTapped() { searchTextField.text = "" }
    
    ///registerCollectionViewCell...
    func registerCollectionViewCell(){ searchResultCollectionView.register(UINib(nibName: identifire, bundle: nil), forCellWithReuseIdentifier: identifire) }
    
    ///handleSearchTextfieldAction...
    func handleSearchTextfieldAction(text: String){
        if !(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
            if isCommingForSearchProduct || selectedTab == "product" { self.getProducts(primaryCategory: "", secondaryCategory: "", name: text, isFeatured: false) }
            else { self.getServices(primaryCategory: "", secondaryCategory: "", name: text, isFeatured: false) }
        } else { self.products = []; self.handleProductSuccessResponse() }
    }
    
    ///handleTapHereEmptySearchBtnAction..
    func handleTapHereEmptySearchBtnAction(){
        let query = searchTextField.trimText()
        let urlQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let amazonURLString = "https://www.amazon.com/s?k=\(urlQuery)"
        SafariViewController.shared.openUrlWith(linkString: amazonURLString, Parentcontroller: self)
    }
    
    
    // MARK: - Button Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    
    ///searchTextFieldDidChnageAction...
    @IBAction func searchTextFieldDidChnageAction(_ sender: UITextField) {
        guard let text = sender.text else { return }; self.handleSearchTextfieldAction(text: text)
    }
    
    ///tapHereBtnAction...
    @IBAction func tapHereBtnAction(_ sender: Any) { handleTapHereEmptySearchBtnAction() }
    
    
    ///didTapOnHearth... cell fav hearth action...
    func didTapOnHearth(){ searchResultCollectionView.reloadData() }
     
}

// MARK: - Collection View DataScorce and Delegate...
extension SearchProductsResultsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    ///numberOfItemsInSection...
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return products.count }
    
    ///cellForItemAt...
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifire, for: indexPath) as! FavoriteProductCollectionViewCell
        cell.controller = self
        cell.dataForCategoryDetails = products[indexPath.item]
        return cell
    }
    
    ///collectionViewLayout...
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size  = collectionView.frame.size.width - 10
        return CGSize(width: size / 2, height: 230)
    }
    
    ///didSelectItemAt...
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        controller.selectedProduct = products[indexPath.item]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
}


//MARK: - Network layer...
extension SearchProductsResultsViewController {
    
    ///getProducts...
    func getProducts(primaryCategory: String, secondaryCategory: String, name: String, isFeatured: Bool){
        //if isCommingForSearchProduct { self.showRappleActivity() }
        Constants.tripSavaServcesManager.getProducts(primaryCategory: primaryCategory, secondaryCategory: secondaryCategory, name: name, isFeatured: isFeatured) { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true { self.products = response.products?.results ?? [] }; self.handleProductSuccessResponse()
            case .failure(_): self.handleProductSuccessResponse()
            }
        }
    }
    //MARK: - getServices...
    func getServices(primaryCategory: String, secondaryCategory: String, name: String, isFeatured: Bool){
        Constants.tripSavaServcesManager.getServices(primaryCategory: primaryCategory, secondaryCategory: secondaryCategory, name: name, isFeatured: isFeatured) { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true { self.products = response.services?.results ?? [] }; self.handleProductSuccessResponse()
            case .failure(let error): print(error); self.handleProductSuccessResponse()
            }
        }
    }
    
    ///handleProductSuccessResponse...
    func handleProductSuccessResponse(){
        if products.isEmpty {
            noProductFoundView.isHidden = false; totalProductsLabel.isHidden = true; searchTextLabel.isHidden = true }
        else {
            noProductFoundView.isHidden = true; totalProductsLabel.isHidden = false; searchTextLabel.isHidden = false
            totalProductsLabel.text = products.count <= 0 ? "No items available yet" : (products.count == 1 ? "1 item" : "\(products.count) items")
            searchTextLabel.text = "All Results for \(searchTextField.trimText())"
        }
        if self.isCommingForSearchProduct { self.hideRappleActivity() }
        self.searchResultCollectionView.reloadData();
    }
    
    
}
