//
//  LibraryViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 16/06/2023.
//

import UIKit

class LibraryViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var blogsCollectionView: UICollectionView!
    @IBOutlet weak var libraryOptionImg1: UIImageView!
    @IBOutlet weak var libraryOptionImg2: UIImageView!
    @IBOutlet weak var libraryOptionImg3: UIImageView! 
    @IBOutlet weak var libraryOptionImg4: UIImageView!
    @IBOutlet weak var libraryOptionLabel1: UILabel!
    @IBOutlet weak var libraryOptionLabel2: UILabel!
    @IBOutlet weak var libraryOptionLabel3: UILabel!
    @IBOutlet weak var libraryOptionLabel4: UILabel!
    @IBOutlet weak var libraryOptionBarLabel1: UILabel!
    @IBOutlet weak var libraryOptionBarLabel2: UILabel!
    @IBOutlet weak var libraryOptionBarLabel3: UILabel!
    @IBOutlet weak var libraryOptionBarLabel4: UILabel!
    @IBOutlet weak var blogView: UIView!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var checkListView: UIView!
    @IBOutlet weak var switchHeightAnchor: NSLayoutConstraint! 
    @IBOutlet weak var blogsCollectionFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var blogsCollectionViewheightAnchor: NSLayoutConstraint!
    @IBOutlet weak var bottomEmptyView: UIView!
    @IBOutlet weak var checkListCollectionView: UICollectionView!
    @IBOutlet weak var checkListCollectionFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var noBlogsEmptyMsgView: UIView!
    
    //MARK: - Variables...
    let cellIdentifier = "LibraryCollectionViewCell"
    let cellIdentifierFor = "CheckListCollectionViewCell"
    var libraryOptionsImages: [UIImageView] = []
    var libraryOptionsLabels: [UILabel] = []
    var libraryOptionsBarLabels: [UILabel] = []
    var switchViews: [UIView] = []
    var isBlogsViewVerticle = false
    var blogsDatasource: [BlogResults] = []
    var checkListData: [CheckListModel] = []
    var isCheckListViewVerticle = false
    
     
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){ setUpCollectionView(); updateData();updateCheckListData() ; getBlogs() }
    
    ///updateData...
    func updateData(){
        switchViews = [blogView, informationView, checkListView]
        libraryOptionsImages = [libraryOptionImg1, libraryOptionImg2, libraryOptionImg3, libraryOptionImg4]
        libraryOptionsLabels = [libraryOptionLabel1, libraryOptionLabel2, libraryOptionLabel3, libraryOptionLabel4]
        libraryOptionsBarLabels = [libraryOptionBarLabel1, libraryOptionBarLabel2, libraryOptionBarLabel3, libraryOptionBarLabel4]
    }
    
    ///setUpCollectionView...
    func setUpCollectionView(){
        blogsCollectionView.addPullToRefresh(target: self, action: #selector(refreshCollectionView))
        checkListCollectionView.register(UINib(nibName: cellIdentifierFor, bundle: nil), forCellWithReuseIdentifier: cellIdentifierFor)
        blogsCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    ///refreshCollectionView...
    @objc private func refreshCollectionView() { getBlogs(); DispatchQueue.main.async { self.checkListCollectionView.endPullToRefresh() } }
    
    ///updateCheckListData...
    func updateCheckListData(){
        checkListData.append(CheckListModel(name: "Pet Sitter",imgName: "ChecklistsCard1", pdfFileName: "Pet Sitter Checklist", index: 0))
        
        checkListData.append(CheckListModel(name: "House Sitter",imgName: "ChecklistsCard2", pdfFileName: "House Sitter Checklist", index: 1))
        
        checkListData.append(CheckListModel(name: "Car Rental",imgName: "ChecklistsCard3", pdfFileName: "Car Rental Checklist", index: 2))
        
        checkListData.append(CheckListModel(name: "Motercycle Readiness",imgName: "ChecklistsCard4", pdfFileName: "Motorcycle Pre-Ride Checklist", index: 3))
        
        checkListData.append(CheckListModel(name: "Accommodation",imgName: "ChecklistsCard5", pdfFileName: "Accommodation Checklist", index: 4))
        
        checkListData.append(CheckListModel(name: "RV Readiness",imgName: "ChecklistsCard6", pdfFileName: "RV Readiness Checklist", index: 5))
        
        checkListData.append(CheckListModel(name: "Boat Readiness",imgName: "ChecklistsCard7", pdfFileName: "Boat Rental Checklist", index: 6))
        
        checkListData.append(CheckListModel(name: "Camping Equipment",imgName: "ChecklistsCard8", pdfFileName: "Camping Checklist", index: 7))
        
        checkListData.append(CheckListModel(name: "Bicycle Readiness",imgName: "ChecklistsCard9", pdfFileName: "Bicycle Checklist", index: 8))
        
        checkListData.append(CheckListModel(name: "Road Trip",imgName: "ChecklistsCard10", pdfFileName: "Road Trip Checklist", index: 8))
    }
    
    ///updateLibraryOptionsBtn...
    func updateLibraryOptionsBtn(tag: Int) {
        
        libraryOptionsImages.forEach { img in
            if img.tag == tag { img.tintColor = UIColor(hex: "#E26A2B") } else { img.tintColor = UIColor(hex: "#BBBBBB") }
        }
        
        libraryOptionsLabels.forEach { lbl in
            if lbl.tag == tag { lbl.textColor = UIColor(hex: "#E26A2B") } else { lbl.textColor = UIColor(hex: "#808080") }
        }
        
        libraryOptionsBarLabels.forEach { lbl in
            if lbl.tag == tag { lbl.isHidden = false } else { lbl.isHidden = true }
        }
         
    }
    
    ///updateTabViews...
    func updateTabViews(tag: Int){
        switchViews.forEach { view in
            if tag == 1 {
                blogView.isHidden = false; informationView.isHidden = false;  checkListView.isHidden = false
                isBlogsViewVerticle = false;  isCheckListViewVerticle = false
                blogsCollectionFlowLayout.scrollDirection = .horizontal;
                blogsCollectionViewheightAnchor.constant = 284; bottomEmptyView.isHidden = false
                checkListCollectionFlowLayout.scrollDirection = .horizontal; switchHeightAnchor.constant = 220
            }
            else {
                if view.tag == tag {
                    view.isHidden = false
                    if tag == 4 {
                        isCheckListViewVerticle = true; bottomEmptyView.isHidden = true
                        checkListCollectionFlowLayout.scrollDirection = .vertical
                        switchHeightAnchor.constant = UIWindow().frame.height - 270
                    }
                    else {
                        if tag == 2 {
                            isBlogsViewVerticle = true; blogsCollectionFlowLayout.scrollDirection = .vertical;
                            blogsCollectionViewheightAnchor.constant = UIWindow().frame.height - 300; bottomEmptyView.isHidden = true
                        }
                        else {
                            isBlogsViewVerticle = false; blogsCollectionFlowLayout.scrollDirection = .horizontal; blogsCollectionViewheightAnchor.constant = 284
                            bottomEmptyView.isHidden = false
                            
                        }
                    }
                }
                else { view.isHidden = true }
            }
        }
    }
    
    
    //MARK: - Actions...
   
    ///libraryOptionBtnActions...
    @IBAction func libraryOptionBtnActions(_ sender: UIButton) { self.updateLibraryOptionsBtn(tag: sender.tag); updateTabViews(tag: sender.tag) }
    
    ///ebbassyBtnActions...
    @IBAction func ebbassyBtnActions(_ sender: UIButton) {
        self.pushViewController(storyboard: "Library", identifier: "EmbassiesViewController")
    }
    
    ///didTapOnCheckListBtn...
    func didTapOnCheckListBtn(data: CheckListModel) { /// That action call form collection view cell....
        let pdfViewerVC = UIStoryboard(name: "Alert", bundle: nil).instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        if let pdfFileURL = Bundle.main.url(forResource: data.pdfFileName, withExtension: "pdf") {
            pdfViewerVC.webLink = pdfFileURL.absoluteString; pdfViewerVC.headerText = data.name
            navigationController?.pushViewController(pdfViewerVC, animated: true)
        } else { print("PDF file not found in the bundle.") }
         
    }
    
}

//MARK: - CollectionView Delegate & DataSource ...
extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    ///numberOfItemsInSection...
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            if isBlogsViewVerticle { if blogsDatasource.count < 3 { return blogsDatasource.count } else { return 3 } }
            else { return blogsDatasource.count }
        } else { return checkListData.count }
    }
    
    ///cellForItemAt...
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! LibraryCollectionViewCell
            cell.data = blogsDatasource[indexPath.item]
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierFor, for: indexPath) as! CheckListCollectionViewCell
            cell.data = checkListData[indexPath.item]; 
            cell.delegate = self
            return cell
        }
    }
    
    ///sizeForItemAt...
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            if isBlogsViewVerticle { return CGSize(width: (collectionView.frame.width) / 2, height: 250) }
            else { return CGSize(width: (collectionView.frame.width) / 2, height: 250) }
        }
        else {
            if isCheckListViewVerticle { let size = (collectionView.frame.width - 16) / 2; return CGSize(width: size, height: size) }
            else { return CGSize(width: 168, height: 168) }
        }
        
    }
    
    ///didSelectItemAt...
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            let data = blogsDatasource[indexPath.item]
            if let url = data.url {
                SafariViewController.shared.openUrlWith(linkString: url, Parentcontroller: self)
            }
            else { self.presentAlert(withTitle: "Alert", message: Constants.errorMsg) }
        }
    }
     
}


//MARK: - Network layer...
extension LibraryViewController {
    
    ///getBlogs...
    func getBlogs(){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.getBlogs { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true {
                    self.blogsDatasource = []; self.blogsDatasource = response.blogs?.results ?? []; self.blogsCollectionView.reloadData()
                } else { self.blogView.isHidden = true }
                if self.blogsDatasource.isEmpty { self.blogsCollectionViewheightAnchor.constant = 55; self.noBlogsEmptyMsgView.isHidden = false }
                else { self.noBlogsEmptyMsgView.isHidden = true }; self.hideRappleActivity()
            case .failure(_): self.hideRappleActivity()
            }
        }
    }
}
