//
//  CubeDetailsViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 18/06/2023.
//

import UIKit

class CubeDetailsViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var cubeDetailsCollectionView: UICollectionView!
    
    //MARK: - Variables...
    let cellIdentifier = "CubeDetailsCollectionViewCell"
    let headerIdentifier = "CubeHeaderCollectionReusableView"
    
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){ setUpCollectionView() }
    
    ///setUpCollectionView...
    func setUpCollectionView(){
        cubeDetailsCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        cubeDetailsCollectionView.register(UINib(nibName: headerIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    

}

//MARK: - CollectionView Delegate & DataSource ...
extension CubeDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    ///numberOfSections...
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    ///viewForSupplementaryElementOfKind...
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! CubeHeaderCollectionReusableView
        return view
    }
    
    ///referenceSizeForHeaderInSection...
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize { return .init(width: collectionView.frame.width, height: 26) }
    
    ///numberOfItemsInSection...
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return 3 }
    
    ///cellForItemAt...
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CubeDetailsCollectionViewCell
        return cell
    }
    
    ///sizeForItemAt...
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    ///didSelectItemAt...
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}
