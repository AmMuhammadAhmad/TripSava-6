//
//  ViewAllCategoriesViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 10/08/2023.
//

import UIKit

class ViewAllCategoriesViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var seeAllCategoriesCollectionView: UICollectionView!
    @IBOutlet weak var mainViewHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var innerView: UIView!
    
    //MARK: - Variables...
    let categoryIdentifier = "MainCategoryCollectionViewCell"
    var primaryCategories: [Categories] = []
    var dissmissCompletionHandler: ((_ categoryId: String, _ categoryId: String) -> Void)?
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    ///viewWillAppear..
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        innerView.animateFromBottom(to: (self.window?.frame.height ?? 600) - self.view.frame.height / 1.2 , duration: 0.5)
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){ updateData(); registerCollectionViewCell() }
    
    ///updateData..
    func updateData(){
        self.mainViewHeightAnchor.constant = self.view.frame.height / 1.2 
    }
    
    ///registerCollectionViewCell...
    func registerCollectionViewCell(){
        seeAllCategoriesCollectionView.register(UINib(nibName: categoryIdentifier, bundle: nil), forCellWithReuseIdentifier: categoryIdentifier)
    }
    
    ///handlePrimaryCategorySelection...
    func handlePrimaryCategorySelection(categoryId: String, categoryName: String){
        DispatchQueue.main.async { self.dissmissCompletionHandler?(categoryId, categoryName)  }
        self.dismiss(animated: false)
    }
    
    
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) {  self.dismiss(animated: false) }
    

}


// MARK: - Collection View DataScorce and Delegate...
extension ViewAllCategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    ///numberOfItemsInSection...
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return primaryCategories.count
    }
    
    ///cellForItemAt...
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryIdentifier, for: indexPath) as! MainCategoryCollectionViewCell
        cell.data = primaryCategories[indexPath.item]
        return cell
    }
    
    ///sizeForItemAt...
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size  = collectionView.frame.size.width - 6
        return CGSize(width: size / 4, height: 100)
    }
    
    ///didSelectItemAt...
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = primaryCategories[indexPath.item]
        handlePrimaryCategorySelection(categoryId: category.id ?? "", categoryName: category.name ?? "Trip Sava")
    }
    
    
}

