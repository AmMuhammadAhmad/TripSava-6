//
//  StartPackingViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 13/06/2023.
//

import UIKit

class  StartPackingViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var packingCollectionView: UICollectionView!
    @IBOutlet weak var packingImg1: UIImageView!
    @IBOutlet weak var packingImg2: UIImageView!
    @IBOutlet weak var packingImg3: UIImageView!
    @IBOutlet weak var packingImg4: UIImageView!
    @IBOutlet weak var packingImg5: UIImageView!
    @IBOutlet weak var packingImg6: UIImageView!
    @IBOutlet weak var packingImg7: UIImageView!
    @IBOutlet weak var packingImg8: UIImageView!
    @IBOutlet weak var packingImg9: UIImageView!
    @IBOutlet weak var packingImg10: UIImageView!
    @IBOutlet weak var packingImg11: UIImageView!
    @IBOutlet weak var packingImg12: UIImageView!
    @IBOutlet weak var packingImg13: UIImageView!
    @IBOutlet weak var packingImg14: UIImageView!
    @IBOutlet weak var packingImg15: UIImageView!
    @IBOutlet weak var packingImg16: UIImageView!
    @IBOutlet weak var packingImg17: UIImageView!
    @IBOutlet weak var packingImg18: UIImageView!
    @IBOutlet weak var packingImg19: UIImageView!
    @IBOutlet weak var packingImg20: UIImageView!
    @IBOutlet weak var packingLabel1: UILabel!
    @IBOutlet weak var packingLabel2: UILabel!
    @IBOutlet weak var packingLabel3: UILabel!
    @IBOutlet weak var packingLabel4: UILabel!
    @IBOutlet weak var packingLabel5: UILabel!
    @IBOutlet weak var packingLabel6: UILabel!
    @IBOutlet weak var packingLabel7: UILabel!
    @IBOutlet weak var packingLabel8: UILabel!
    @IBOutlet weak var packingLabel9: UILabel!
    @IBOutlet weak var packingLabel10: UILabel!
    @IBOutlet weak var packingLabel11: UILabel!
    @IBOutlet weak var packingLabel12: UILabel!
    @IBOutlet weak var packingLabel13: UILabel!
    @IBOutlet weak var packingLabel14: UILabel!
    @IBOutlet weak var packingLabel15: UILabel!
    @IBOutlet weak var packingLabel16: UILabel!
    @IBOutlet weak var packingLabel17: UILabel!
    @IBOutlet weak var packingLabel18: UILabel!
    @IBOutlet weak var packingLabel19: UILabel!
    @IBOutlet weak var packingLabel20: UILabel!
    @IBOutlet weak var packingView1: UIView!
    @IBOutlet weak var packingView2: UIView!
    @IBOutlet weak var packingView3: UIView!
    @IBOutlet weak var packingView4: UIView!
    @IBOutlet weak var packingView5: UIView!
    @IBOutlet weak var packingView6: UIView!
    @IBOutlet weak var packingView7: UIView!
    @IBOutlet weak var packingView8: UIView!
    @IBOutlet weak var packingView9: UIView!
    @IBOutlet weak var packingView10: UIView!
    @IBOutlet weak var packingView11: UIView!
    @IBOutlet weak var packingView12: UIView!
    @IBOutlet weak var packingView13: UIView!
    @IBOutlet weak var packingView14: UIView!
    @IBOutlet weak var packingView15: UIView!
    @IBOutlet weak var packingView16: UIView!
    @IBOutlet weak var packingView17: UIView!
    @IBOutlet weak var packingView18: UIView!
    @IBOutlet weak var packingView19: UIView!
    @IBOutlet weak var packingView20: UIView!
    @IBOutlet weak var packingChildYesBtn: UIButton!
    @IBOutlet weak var packingChildNoBtn: UIButton!
    @IBOutlet weak var packingChildImg1: UIImageView!
    @IBOutlet weak var packingChildImg2: UIImageView!
    @IBOutlet weak var packingChildImg3: UIImageView!
    @IBOutlet weak var packingChildLabel1: UILabel!
    @IBOutlet weak var packingChildLabel2: UILabel!
    @IBOutlet weak var packingChildLabel3: UILabel!
    @IBOutlet weak var packingChildView1: UIView!
    @IBOutlet weak var packingChildView2: UIView!
    @IBOutlet weak var packingChildView3: UIView!
    @IBOutlet weak var packingCubeYesBtn: UIButton!
    @IBOutlet weak var packingCubeNoBtn: UIButton!
    
    
    //MARK: - Variables...
    let cellIndentifier = "CreatepackingCollectionViewCell"
    let name = ["Tennis Shoes", "Balls", "Raquet", "Water bottle", "Ball Boxs"]
    var packingImages: [UIImageView] = []; var packingLabels: [UILabel] = []
    var packingViews: [UIView] = []; var packingChildButtons: [UIButton] = []
    var packingChildImages: [UIImageView] = []; var packingChildLabels: [UILabel] = []
    var packingChildViews: [UIView] = []; var packingCubeButtons: [UIButton] = []
    var activitiesSelectedTags: Set<Int> = []; var selectedChildTags: Set<Int> = []
    var activiesNameKeys: [String] = []; var travellingWithKeys: [String] = []
    var trip: Trip?
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){ setUpCollectionView(); updateData() }
    
    ///setUpCollectionView...
    func setUpCollectionView(){
        packingCollectionView.register(UINib(nibName: cellIndentifier, bundle: nil), forCellWithReuseIdentifier: cellIndentifier)
    }
    
    ///updateData...
    func updateData(){
        packingImages = [packingImg1, packingImg2, packingImg3, packingImg4, packingImg5, packingImg6, packingImg7, packingImg8, packingImg9, packingImg10, packingImg11, packingImg12, packingImg13, packingImg14, packingImg15, packingImg16, packingImg17, packingImg18, packingImg19, packingImg20]
        
        packingLabels = [packingLabel1, packingLabel2, packingLabel3, packingLabel4, packingLabel5, packingLabel6, packingLabel7, packingLabel8, packingLabel9, packingLabel10, packingLabel11, packingLabel12, packingLabel13, packingLabel14, packingLabel15, packingLabel16, packingLabel17, packingLabel18, packingLabel19, packingLabel20]
        
        packingViews = [packingView1, packingView2, packingView3, packingView4, packingView5, packingView6, packingView7, packingView8, packingView9, packingView10, packingView11, packingView12, packingView13, packingView14, packingView15, packingView16, packingView17, packingView18, packingView19, packingView20]
         
        packingChildLabels = [packingChildLabel1, packingChildLabel2, packingChildLabel3]
        packingChildViews = [packingChildView1, packingChildView2, packingChildView3]
        packingChildImages = [packingChildImg1, packingChildImg2, packingChildImg3]
        
        packingChildButtons = [packingChildYesBtn, packingChildNoBtn]; packingCubeButtons = [packingCubeYesBtn, packingCubeNoBtn]
        
        activiesNameKeys = ["camping", "formal_event", "golf", "gym", "beach", "biking", "boating", "bodyboarding", "hiking", "motorcycling", "photography", "road_trip", "running", "skiing", "snorkelling", "snowboarding", "surfing", "swimming"]; travellingWithKeys = ["baby", "toddler", "child"]
    }
    
    ///updatePetSuggestionBtnActions...
    func updatePackingTaskBtnActions(tag: Int){
        if activitiesSelectedTags.contains(tag) {
            activitiesSelectedTags.remove(tag); packingImages[tag - 1].tintColor = UIColor(hex: "#4E4F4E")
            packingLabels[tag - 1].textColor = UIColor(hex: "#474847", alpha: 0.96); packingViews[tag - 1].backgroundColor = .white
        } else {
            activitiesSelectedTags.insert(tag); packingImages[tag - 1].tintColor = .white
            packingLabels[tag - 1].textColor = .white; packingViews[tag - 1].backgroundColor = UIColor(hex: "#003681")
        }
        
    }
    
    ///updatePackingChildTaskBtnActions...
    func updatePackingChildTaskBtnActions(tag: Int){
        if selectedChildTags.contains(tag) {
            selectedChildTags.remove(tag); packingChildImages[tag - 1].tintColor = UIColor(hex: "#4E4F4E")
            packingChildLabels[tag - 1].textColor = UIColor(hex: "#474847", alpha: 0.96); packingChildViews[tag - 1].backgroundColor = .white
        } else {
            selectedChildTags.insert(tag); packingChildImages[tag - 1].tintColor = .white
            packingChildLabels[tag - 1].textColor = .white; packingChildViews[tag - 1].backgroundColor = UIColor(hex: "#003681")
        }
    }
    
    ///updatePackingChildButtonsActions...
    func updatePackingChildButtonsActions(tag: Int){
        packingChildButtons.forEach { btn in
            if btn.tag == tag { btn.backgroundColor = UIColor(hex: "#003681"); btn.setTitleColor(.white, for: .normal) }
            else { btn.backgroundColor =  .white ; btn.setTitleColor(UIColor(hex: "#474847", alpha: 0.96), for: .normal)    }
        }
    }
    
    func updatePackingCubeButtonsActions(tag: Int){
        packingCubeButtons.forEach { btn in
            if btn.tag == tag { btn.backgroundColor = UIColor(hex: "#003681"); btn.setTitleColor(.white, for: .normal) }
            else { btn.backgroundColor =  .white ; btn.setTitleColor(UIColor(hex: "#474847", alpha: 0.96), for: .normal)    }
        }
    }
    
    ///handleCreatePackingList...
    func handleCreatePackingList(){
        if activitiesSelectedTags.isEmpty { self.presentAlert(withTitle: "Alert", message: "Please select your activities") }
        //else if selectedChildTags.isEmpty { self.presentAlert(withTitle: "Alert", message: "Please select your activities") }
        else {
            var activitiesList: [String] = []; var selectedChildList: [String] = []
            guard let trip = trip else { self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " -> Trip Missing"); return }
            activitiesSelectedTags.forEach { tag in  activitiesList.append(activiesNameKeys[tag - 1]) }
            if selectedChildTags.isEmpty { selectedChildList = [] }
            else { selectedChildTags.forEach { tag in  selectedChildList.append(travellingWithKeys[tag - 1]) } }
            self.createPackingList(tripId: trip.id ?? "", activities: activitiesList, travellingWith: selectedChildList)
        }
         
    }
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popToRootViewController() }
    
    ///createMyPakingListBtnAction...
    @IBAction func createMyPakingListBtnAction(_ sender: Any) { handleCreatePackingList() }
    
    ///packingBtnActions...
    @IBAction func packingBtnActions(_ sender: UIButton) { updatePackingTaskBtnActions(tag: sender.tag) }
    
    ///packingChildBtnAction...
    @IBAction func packingChildBtnAction(_ sender: UIButton) { updatePackingChildTaskBtnActions(tag: sender.tag) }
    
    ///packingVChildViewsBtnAction...
    @IBAction func packingVChildViewsBtnAction(_ sender: UIButton) {
        updatePackingChildButtonsActions(tag: sender.tag)
    }
    
    ///packingCubesBtnAction...
    @IBAction func packingCubesBtnAction(_ sender: UIButton) { updatePackingCubeButtonsActions(tag: sender.tag) }
    
}

//MARK: - CollectionView Delegate & DataSource ...
extension StartPackingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    ///numberOfItemsInSection...
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return 5 }
    
    ///cellForItemAt...
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIndentifier, for: indexPath) as! CreatepackingCollectionViewCell
        cell.data = name
        return cell
    }
    
    ///sizeForItemAt...
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.frame.height)
    }
    
    ///didSelectItemAt...
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

//MARK: - Network layer...
extension StartPackingViewController {
    
    ///createPackingList...
    func createPackingList(tripId: String, activities: [String], travellingWith: [String]){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.createPackingList(tripId: tripId, activities: activities, travellingWith: travellingWith) { resultent in
            switch resultent {
            case .success(let response): self.hideRappleActivity()
                if response.status == true { self.handleSuccessResponse()  }
                else { self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " -> \(response.message ?? "")") }
            case .failure(let error):  self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " -> \(error)"); self.hideRappleActivity()
                
            }
        }
    }
    
    ///handleSuccessResponse...
    func handleSuccessResponse(){
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PackingListVC") as! PackingListVC
        controller.trip = trip; self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
