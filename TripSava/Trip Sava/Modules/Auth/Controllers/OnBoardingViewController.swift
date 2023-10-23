//
//  OnBoardingViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 06/06/2023.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    //MARK: - IBOutlets...
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var onBoardingCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var ellispeTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var ellipseImageView: UIImageView!
    
    
    //MARK: - Variables...
    let cellIdentifier = "OnBoardingCollectionViewCell"
    var onBoardingDataSource: [OnBoardingModel] = []
    
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){ checkIsFirstLunchedOrNot() }
    
    ///checkIsFirstLunchedOrNot...
    func checkIsFirstLunchedOrNot(){
        if !appCredentials.isFirstTimeLunch {
            self.checkDeviceModel(); updateData(); setUpCollectionView()
        }
        else {
            if appCredentials.isUserLogin { self.setNewRootViewController(storyboard: "Tabbar", identifier: "TabBarVC") }
            else { self.pushViewController(storyboard: "Auth", identifier: "GetStartedViewController") }
        }
    }
    
    ///updateData...
    func updateData(){
        onBoardingDataSource.append(OnBoardingModel(bgImgName: "OnboradingBg1", onBoardImgName: "OnBoardingImg1", title: "Welcome to TripSava!", subHeading: "No matter what kind of trip you’re taking, we’ll help you experience your best trip.", buttonTxtColor:  UIColor(hex: "#003681")))
        onBoardingDataSource.append(OnBoardingModel(bgImgName: "OnboradingBg2", onBoardImgName: "OnBoardingImg2", title: "Keep Calm and Carry On", subHeading: "Reduce your stress and have a more enjoyable travel experience by using our tailored tips and tools curated by travel experts.", buttonTxtColor: UIColor(hex: "#6FAF16")))
        onBoardingDataSource.append(OnBoardingModel(bgImgName: "OnboradingBg3", onBoardImgName: "OnBoardingImg3", title: "TripSava Magic", subHeading: "When you give us information about your upcoming trip – a bit about you, your destination, and what you have in mind – we will provide you with personalized packing lists, tasks to do, recommendations, and more!", buttonTxtColor: UIColor(hex: "#E26A2B")))
        onBoardingDataSource.append(OnBoardingModel(bgImgName: "OnboradingBg4", onBoardImgName: "OnBoardingImg4", title: "Best of the Best", subHeading: "We’ve curated a selection of the best travel products and services for your individual needs. You can find them through TripSava!", buttonTxtColor: UIColor(hex: "#3720A2")))
        pageController.numberOfPages = 4
        
    }
    
    ///setUpCollectionView...
    func setUpCollectionView(){
        onBoardingCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    ///handleBgImage...
    func handleBgImage(index: Int ,img: String) {
        let targetImage = UIImage(named: img)
        
        UIView.transition(with: bgImageView, duration: 0.3, options: .transitionCrossDissolve) {
            self.bgImageView.image = targetImage
            let targetSignupBtnTxt = self.onBoardingDataSource[index].buttonTxtColor
            self.signupButton.setTitleColor(targetSignupBtnTxt, for: .normal)
        } completion: { isComplected in
            print(index)
            //self.onBoardingCollectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
        }

        
        UIView.transition(with: bgImageView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            
        }, completion: nil)
        pageController.currentPage = index
        
    }
    
    ///checkDeviceModel...
    func checkDeviceModel() {
        // Usage example...
        let device = UIDevice.current; let modelName = device.modelName
        switch modelName {
        case "iPhone SE", "iPhone SE (2nd generation)": ellispeTopAnchor.constant = -250
        case "iPhone 6", "iPhone 6s", "iPhone 7", "iPhone 8": ellispeTopAnchor.constant = -250
        case "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus": ellispeTopAnchor.constant = -220
        case "iPhone X", "iPhone XS", "iPhone 11 Pro": ellispeTopAnchor.constant = -180
        case "iPhone XR", "iPhone 11": ellispeTopAnchor.constant = -140
        case "iPhone XS Max", "iPhone 11 Pro Max": ellispeTopAnchor.constant = -150
        case "iPhone 12 Mini": ellispeTopAnchor.constant = -180
        case "iPhone 12", "iPhone 12 Pro": ellispeTopAnchor.constant = -180
        case "iPhone 12 Pro Max": ellispeTopAnchor.constant = -130
        case "iPhone 13 Mini": ellispeTopAnchor.constant = -180
        case "iPhone 13", "iPhone 13 Pro": ellispeTopAnchor.constant = -160
        case "iPhone 13 Pro Max": ellispeTopAnchor.constant = -120
        case "iPhone 14", "iPhone 14 Pro": ellispeTopAnchor.constant = -150
        case "iPhone 14 Pro Max": ellispeTopAnchor.constant = -160
        default:
            if UIDevice.current.userInterfaceIdiom == .pad {
                ellispeTopAnchor.constant = 0 }
            else {
                ellispeTopAnchor.constant = -160 }
        }
    }
    
    
    //MARK: - Actions...
    
    ///signUpBtnAction...
    @IBAction func signUpBtnAction(_ sender: Any) { self.pushViewController(storyboard: "Auth", identifier: "GetStartedViewController")  }
    
    ///loginBtnAction...
    @IBAction func loginBtnAction(_ sender: Any) { self.pushViewController(storyboard: "Auth", identifier: "LoginViewController") }
    
}


//MARK: - CollectionView Delegate & DataSource ...
extension OnBoardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    ///numberOfItemsInSection...
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return onBoardingDataSource.count }
    
    ///cellForItemAt...
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! OnBoardingCollectionViewCell
        cell.indexPath = indexPath
        cell.data = onBoardingDataSource[indexPath.item]
        return cell
    }
    
    ///sizeForItemAt...
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let data = onBoardingDataSource[indexPath.item]
        let yourText = data.subHeading
        let font = Constants.applyFonts_DMSans(style: .regular, size: 15)
        let width = UIScreen.main.bounds.width - 60 // Use your desired width

        let estimatedHeight = estimatedTextHeight(for: yourText, font: font, width: width)
        print("Estimated Height:", estimatedHeight)
        var height = estimatedHeight
        if UIDevice.current.userInterfaceIdiom == .pad { height = 600 }
        else if UIDevice.current.userInterfaceIdiom == .phone { height = 310 + estimatedHeight }
        return CGSize(width: collectionView.frame.width, height: height)
    }
     
    
    ///didSelectItemAt...
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { }
    
    
}

//MARK: - UIScrollViewDelegate...
extension OnBoardingViewController: UIScrollViewDelegate {
    
    ///scrollViewWillEndDragging...
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let targetOffset = targetContentOffset.pointee
        let targetRect = CGRect(origin: targetOffset, size: onBoardingCollectionView.bounds.size)
        let targetPoint = CGPoint(x: targetRect.midX, y: targetRect.midY)
        
        if let indexPath = onBoardingCollectionView.indexPathForItem(at: targetPoint) {
            let targetPage = indexPath.item // Current page index
            if indexPath.item == 0 { ellipseImageView.isHidden = true; } else { ellipseImageView.isHidden = false }
            // Update the main view's background color based on the current page index
            if targetPage < onBoardingDataSource.count {
                handleBgImage(index: targetPage, img: onBoardingDataSource[targetPage].bgImgName)
            }
        }
    }
}



