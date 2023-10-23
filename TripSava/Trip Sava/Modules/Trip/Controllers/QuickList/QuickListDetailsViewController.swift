//
//  QuickListDetailsViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 19/06/2023.
//

import UIKit
import Kingfisher

class QuickListDetailsViewController: UIViewController {

    //MARK: - IBOutlets...
   
    
    @IBOutlet weak var editBtnStackView: UIStackView!
    @IBOutlet weak var tripNameLabel: UILabel!
    @IBOutlet weak var tripDateLabel: UILabel!
    @IBOutlet weak var tripImageView: UIImageView!
    @IBOutlet weak var editImg: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
     
    @IBOutlet weak var totaoPackItemsLabel: UILabel!
    @IBOutlet weak var packingPriporityLabel: UILabel!
    @IBOutlet weak var packingToBuyLabel: UILabel!
    @IBOutlet weak var packingPackedLabel: UILabel!
    @IBOutlet weak var packingEmptyMsgLabel: UILabel!
    @IBOutlet weak var packingStackView: UIStackView!
    @IBOutlet weak var packingAddItemsBtn: UIButton!
    @IBOutlet weak var packingOptionStackView: UIStackView!
    
     
    @IBOutlet weak var preparingStackView: UIStackView!
    @IBOutlet weak var totaoPreprationItemsLabel: UILabel!
    @IBOutlet weak var preprationAlertLabel: UILabel!
    @IBOutlet weak var preprationPriporityLabel: UILabel!
    @IBOutlet weak var preprationDoneLabel: UILabel!
    @IBOutlet weak var preprationEmptyMsgLabel: UILabel! 
    @IBOutlet weak var preprationAddTaskBtn: UIButton!
    @IBOutlet weak var preprationOptionStackView: UIStackView!
    
    
    //MARK: - Variables...
    let Packinglist = [ "Tennis Shoes", "Deodorant", "Toothpaste", "Cologne", "Blue jeans", "Travel notebook" ]
    let perpareList = [ "Get my passport", "Learn basic french sentences", "Call Amex about credit report", "Upload photos to Samsung drive" ]
    var trip: Trip?; var isCommingForEditQuickList = false
    
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){ updateData() }
    
    func updateData(){
        //updatePackingAndPreparingNow(Packinglist: Packinglist, perpareList: perpareList)
        if let trip = trip {
            tripNameLabel.text = trip.name
            tripDateLabel.text = trip.startDate?.convertDateFormat(from: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", to: "MMMM d")
            if let postImageUrl = URL(string: trip.image ?? "") { /// set trip image....
                self.tripImageView.kf.setImage(with: postImageUrl, placeholder: UIImage(named: "IMGplaceholder"))
            }
            
            
            if let packing = trip.itemStats?.packing { ///handle packing list
                totaoPackItemsLabel.text = "\(packing.toPackTotal ?? 0) items"
                packingToBuyLabel.text = "\(packing.toBuy ?? 0)"
                packingPriporityLabel.text =  "\(packing.priority ?? 0)"
                packingPackedLabel.text = "\(packing.completedPercentage ?? 0)%"
                if (packing.toPackTotal ?? 0) <= 0 {
                    packingOptionStackView.isHidden = true; packingAddItemsBtn.setTitle("See all items", for: .normal); packingEmptyMsgLabel.isHidden = false
                }
                else {
                    if (packing.seeMore ?? 0) <= 0 { packingAddItemsBtn.setTitle("See all items", for: .normal) }
                    else { packingAddItemsBtn.setTitle("See \(packing.seeMore ?? 0) more", for: .normal); self.addPackingList(packingList: packing.toPackList ?? []) }
                    packingOptionStackView.isHidden = false; packingEmptyMsgLabel.isHidden = true
                }
            }
            
            if let prepration = trip.itemStats?.preparation { ///handle packing list
                totaoPreprationItemsLabel.text = "\(prepration.toPrepareTotal ?? 0) tasks"
                preprationAlertLabel.text = "\(prepration.alert ?? 0)"
                preprationPriporityLabel.text =  "\(prepration.priority ?? 0)"
                preprationDoneLabel.text = "\(prepration.completedPercentage ?? 0)%"
                if (prepration.toPrepareTotal ?? 0) <= 0 {
                    preprationOptionStackView.isHidden = true; preprationAddTaskBtn.setTitle("See all tasks", for: .normal); preprationEmptyMsgLabel.isHidden = false
                }
                else {
                    if (prepration.seeMore ?? 0) <= 0 { preprationAddTaskBtn.setTitle("See all tasks", for: .normal) }
                    else {
                        preprationAddTaskBtn.setTitle("See \(prepration.seeMore ?? 0) more", for: .normal)
                        self.addPrePrationList(perpareList: prepration.toPrepareList ?? [])
                    }
                    preprationOptionStackView.isHidden = false; preprationEmptyMsgLabel.isHidden = true
                }
            }
             
            if trip.status == "completed" { editBtn.isHidden = true; editImg.isHidden = true } else { editBtn.isHidden = false; editImg.isHidden = false }
        }
    }
    
    ///addPerpareList..
    func addPrePrationList(perpareList: [String]){
        perpareList.forEach { name in
            let nameLabel: UILabel = {
                let label = UILabel()
                label.setUpLabel(text: name, font: Constants.applyFonts_DMSans(style: .regular, size: 12), textAlignment: .left, textColor: UIColor(red: 0.28, green: 0.283, blue: 0.279, alpha: 0.8), numberOfLines: 0, textBGcolor: .clear)
                return label
            }()
            //nameLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
            preparingStackView.addArrangedSubview(nameLabel)
        }
    }
    
    ///addPackingList...
    func addPackingList(packingList: [String]){
        ///Update To Packing List
        for i in stride(from: 0, to: packingList.count, by: 2) {
            let first = packingList[i]; let second = (i+1 < packingList.count) ? packingList[i+1] : ""
            let customQLView = QLPackingCustomView()
            customQLView.label.text = first; customQLView.label2.text = second
            packingStackView.addArrangedSubview(customQLView)
        }
    }
    
    func updatePackingAndPreparingNow(Packinglist: [String], perpareList: [String]){
         
        for i in stride(from: 0, to: Packinglist.count, by: 2) {
            let first = Packinglist[i]
            let second = (i+1 < Packinglist.count) ? Packinglist[i+1] : ""
            
            let customQLView = QLPackingCustomView()
            customQLView.label.text = first; customQLView.label2.text = second
            packingStackView.addArrangedSubview(customQLView)
        }
        
       
        perpareList.forEach { name in
            let nameLabel: UILabel = {
                let label = UILabel()
                label.setUpLabel(text: name, font: Constants.applyFonts_DMSans(style: .regular, size: 12), textAlignment: .left, textColor: UIColor(red: 0.28, green: 0.283, blue: 0.279, alpha: 0.8), numberOfLines: 0, textBGcolor: .clear)
                return label
            }()
            preparingStackView.addArrangedSubview(nameLabel)
        }
    }
    
    ///handleArchiveQuickList...
    func handleArchiveQuickList(){
        self.showCustomView(firstBtnTitle: "yes", secondBtntext: "No", message: "Are you sure you want to archive?") {
            if let trip = self.trip { self.archiveQucikListNow(tripId: trip.id ?? "") }
        }
    }
    
    ///handleSuccessResponse...
    func handleSuccessResponse(){
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PackingListVC") as! PackingListVC
        controller.trip = trip; self.navigationController?.pushViewController(controller, animated: true)
    }
    
    ///handleEditTrip...
    func handleEditQuickList(){
        let storyboard = UIStoryboard(name: "Trip", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CreateTripQuickListViewController") as! CreateTripQuickListViewController
        controller.trip = trip; controller.isCommingForEditQuickList = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popToRootViewController() }
    
    ///editQuickListBtnAction...
    @IBAction func editQuickListBtnAction(_ sender: Any) { handleEditQuickList() }
    
    ///archiveBtnAction...
    @IBAction func archiveBtnAction(_ sender: Any) { handleArchiveQuickList() }
    
    ///editBtnAction...
    @IBAction func editBtnAction(_ sender: Any) { editBtnStackView.isHidden.toggle() }
    
    ///packingAddMoreItemsBtnAction...
    @IBAction func packingAddMoreItemsBtnAction(_ sender: Any) { handleSuccessResponse() }
    
    ///preparingAddTaskBtnAction...
    @IBAction func preparingAddTaskBtnAction(_ sender: Any) { handleSuccessResponse() }
    
}


//MARK: - Network layer...
extension QuickListDetailsViewController {
    
    ///archiveQucikListNow...
    func archiveQucikListNow(tripId: String){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.archiveQuicklist(tripId: tripId) { resultent in
            switch resultent {
            case .success(let response): self.hideRappleActivity();
                if response.status == true {
                    self.presentAlertAndBackToRootView(withTitle: "Alert", message: response.message ?? "", controller: self)
                }
                else { self.presentAlert(withTitle: "Alert", message: response.message ?? "") }
            case .failure(let error): self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message:error)
            }
        }
    }
    
}
