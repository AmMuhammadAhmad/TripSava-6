//
//  CreateTripQuickListViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 19/06/2023.
//

import UIKit
import ActiveLabel

class CreateTripQuickListViewController: UIViewController {
    
    //MARK: - IBOutlets...
    @IBOutlet weak var topMessagelabel: ActiveLabel!
    @IBOutlet weak var impoertQuicklistTableView: UITableView!
    @IBOutlet weak var importTableViewHeghtAnchor: NSLayoutConstraint!
    @IBOutlet weak var importtripMainView: UIView!
    @IBOutlet weak var tableViewBottomAnchor: NSLayoutConstraint!
    @IBOutlet weak var tripImportView: UIView!
    @IBOutlet weak var importpackingDetailView: UIView!
    @IBOutlet weak var tripDateTxt: TextField!
    @IBOutlet weak var tripNameTxt: TextField!
    @IBOutlet weak var qucikListImg1: UIImageView!
    @IBOutlet weak var qucikListImg2: UIImageView!
    @IBOutlet weak var qucikListImg3: UIImageView!
    @IBOutlet weak var qucikListImg4: UIImageView!
    @IBOutlet weak var qucikListImg5: UIImageView!
    @IBOutlet weak var qucikListImg6: UIImageView!
    @IBOutlet weak var qucikListImg7: UIImageView!
    @IBOutlet weak var qucikListImg8: UIImageView!
    @IBOutlet weak var qucikListImg9: UIImageView!
    @IBOutlet weak var qucikListImg10: UIImageView!
    @IBOutlet weak var qucikListImg11: UIImageView!
    @IBOutlet weak var qucikListImg12: UIImageView!
    @IBOutlet weak var qucikListImg13: UIImageView!
    @IBOutlet weak var qucikListImg14: UIImageView!
    @IBOutlet weak var qucikListImg15: UIImageView!
    @IBOutlet weak var qucikListImg16: UIImageView!
    @IBOutlet weak var qucikListImg17: UIImageView!
    @IBOutlet weak var qucikListImg18: UIImageView!
    @IBOutlet weak var doneOrUpdateBtn: UIButton!
    
    //MARK: - Variables...
    let messageString = "Quicklists are ideal for single activities or if you are taking a day trip. If you want a more curated experience then Create a trip."
    let backBtnMsg = "Are you sure you want to exit?\n\nIf you exit now, your data will not be saved."
    let cellIdentifier = "ImportQuickListTableViewCell"; var isAnyImageSelected: Bool = false; var selectedImgTag: Int?; var isDateSelecetd = false
    let birthDatePicker = UIDatePicker();  var quickListImages: [UIImageView] = []; var quickListData: [QuickListImages] = []
    var trip: Trip?; var isCommingForEditQuickList: Bool = false
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){
        setUpTableView(); setUpTermsAndConditionAttributedString(); updateData()
        self.DatePicker(textField: tripDateTxt, mode: .date, action: #selector(birthDateDone), picker: birthDatePicker)
        
        quickListImages.append(qucikListImg1); quickListImages.append(qucikListImg2); quickListImages.append(qucikListImg3); quickListImages.append(qucikListImg4)
        quickListImages.append(qucikListImg5); quickListImages.append(qucikListImg6); quickListImages.append(qucikListImg7); quickListImages.append(qucikListImg8)
        quickListImages.append(qucikListImg9); quickListImages.append(qucikListImg10); quickListImages.append(qucikListImg11); quickListImages.append(qucikListImg12)
        quickListImages.append(qucikListImg13); quickListImages.append(qucikListImg14); quickListImages.append(qucikListImg15); quickListImages.append(qucikListImg16)
        quickListImages.append(qucikListImg17); quickListImages.append(qucikListImg18)
        
        ///update url links...
        quickListData.append(QuickListImages(tag: 0, url: "https://res.cloudinary.com/chirptech123/image/upload/v1694803191/General_Trip_default_qbrzkr.jpg"))
        quickListData.append(QuickListImages(tag: 1, url: "https://res.cloudinary.com/chirptech123/image/upload/v1694803175/Flags_jua59l.jpg"))
        quickListData.append(QuickListImages(tag: 2, url: "https://res.cloudinary.com/chirptech123/image/upload/v1694803164/Plane_Trip_jfegxr.jpg"))
        quickListData.append(QuickListImages(tag: 3, url: "https://res.cloudinary.com/chirptech123/image/upload/v1694803162/Photography_otlhm5.jpg"))
        quickListData.append(QuickListImages(tag: 4, url: "https://res.cloudinary.com/chirptech123/image/upload/v1694803147/Languages_khxe7r.jpg"))
        quickListData.append(QuickListImages(tag: 5, url: "https://res.cloudinary.com/chirptech123/image/upload/v1694803142/Meditation_Religious_Trip_t9zdqa.jpg"))
        quickListData.append(QuickListImages(tag: 6, url: "https://res.cloudinary.com/chirptech123/image/upload/v1694803135/Road_Trip_zgbosj.jpg"))
        quickListData.append(QuickListImages(tag: 7, url: "https://res.cloudinary.com/chirptech123/image/upload/v1694803133/Luggage_Tags_qetru1.jpg"))
        quickListData.append(QuickListImages(tag: 8, url: "https://res.cloudinary.com/chirptech123/image/upload/v1694803132/Sports_Trip_tymqnk.jpg"))
        quickListData.append(QuickListImages(tag: 9, url: "https://res.cloudinary.com/chirptech123/image/upload/v1694803085/World_Images_az5h2r.jpg"))
        quickListData.append(QuickListImages(tag: 10, url: "https://res.cloudinary.com/chirptech123/image/upload/v1694803080/Romantic_Trip_iwzaqt.jpg"))
        quickListData.append(QuickListImages(tag: 11, url: "https://res.cloudinary.com/chirptech123/image/upload/v1694803078/Family_Trip_n2jhyd.jpg"))
        quickListData.append(QuickListImages(tag: 12, url: "https://res.cloudinary.com/chirptech123/image/upload/v1694803077/Winter_Trip_rzqd7z.jpg"))
        quickListData.append(QuickListImages(tag: 13, url: "https://res.cloudinary.com/chirptech123/image/upload/v1694803070/Party_Celebration_Trip_lyijbb.jpg"))
        quickListData.append(QuickListImages(tag: 14, url: "https://res.cloudinary.com/chirptech123/image/upload/v1694803057/Bike_Trip_ckbqzd.jpg"))
        quickListData.append(QuickListImages(tag: 15, url: "https://res.cloudinary.com/chirptech123/image/upload/v1694803050/Summer_Trip_uhnogt.jpg"))
        quickListData.append(QuickListImages(tag: 16, url: "https://res.cloudinary.com/chirptech123/image/upload/v1694803043/Picnic_ayfl5b.jpg"))
        quickListData.append(QuickListImages(tag: 17, url: "https://res.cloudinary.com/chirptech123/image/upload/v1694803032/Work_Trip_ayfpyh.jpg"))
        checkIsCommingForEditQuickList()
         
    }
    
    ///isCommingForEditQuickList...
    func checkIsCommingForEditQuickList(){
        if let trip = trip {
            tripNameTxt.text = trip.name
            isAnyImageSelected = true
            for (index, item) in quickListData.enumerated() { if item.url == trip.image { selectedImgTag = index; handleChooseImageBtnAction(tag: index) } }
            isDateSelecetd = true; tripDateTxt.text = trip.startDate?.convertDateFormat(from: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", to: "dd MMM yyyy")
            doneOrUpdateBtn.setTitle("Update", for: .normal)
        }
    }
    
    ///setUpTableView...
    func setUpTableView(){
        impoertQuicklistTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    ///updateData...
    func updateData(){ importTableViewHeghtAnchor.constant = view.frame.height / 2 + 20 }
    
    ///birthDateDone...
    @objc func birthDateDone() {
        isDateSelecetd = true
        let formatter = DateFormatter(); formatter.dateStyle = .medium; formatter.dateFormat = "dd MMM yyyy"
        tripDateTxt.text = formatter.string(from: birthDatePicker.date); tripDateTxt.resignFirstResponder()
    }
    
    ///setUpTermsAndConditionAttributedString...
    func setUpTermsAndConditionAttributedString() {
        
        let customType = ActiveType.custom(pattern: "\\sCreate a trip\\b")
        topMessagelabel.enabledTypes = [.mention, .hashtag, .url, customType]
        topMessagelabel.text = "Quicklists are ideal for single activities or if you are taking a day trip. If you want a more curated\nexperience then Create a trip.   "
        topMessagelabel.numberOfLines = 0
        
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor(hex: "#E26A2B"), NSAttributedString.Key.font : Constants.applyFonts_DMSans(style: .Medium, size: 14)] as [NSAttributedString.Key : Any]
        
        topMessagelabel.customize { label in
            label.configureLinkAttribute = { _, _, _ in  return attributes  }
        }
        
        topMessagelabel.textColor = UIColor(hex: "#808080")
        topMessagelabel.font = Constants.applyFonts_DMSans(style: .regular, size: 14)
        
        topMessagelabel.handleCustomTap(for: customType) { element in
            self.pushViewController(storyboard: "Trip", identifier: "WizardStep1ViewController")
            self.removeSpecificControllerForNavigationStack(wantedToDeleteThatController: CreateTripQuickListViewController.self, fromNavigationController: self.navigationController!)
            
        }
    }
    
    ///handelDoneBtnAction...
    func handelDoneBtnAction(){
        if tripNameTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter trip name") }
        else if isAnyImageSelected == false { self.presentAlert(withTitle: "Alert", message: "Choose an image for trip") }
        else {
            let selectedImage = quickListData[selectedImgTag ?? 0]
            var startDate = ""; var endDate = ""
            if isDateSelecetd { startDate = tripDateTxt.trimText(); endDate = self.nextDate(from: tripDateTxt.trimText(), with: "dd MMM yyyy") }
            else { startDate = Date().formattedString(with: "dd MMM yyyy"); endDate = Date().addingOneDayFormatted(with: "dd MMM yyyy") }
            
            if isCommingForEditQuickList {
                if let trip = trip {
                    updateQuickList(tripId: trip.id ?? "", name: tripNameTxt.trimText(), image: selectedImage.url, startDate: startDate, endDate: endDate) }
            } else { createAnQuickListNow(name: tripNameTxt.trimText(), image: selectedImage.url, startDate: startDate, endDate: endDate) }
        }
        
    }
    
    ///handleChooseImageBtnAction...
    func handleChooseImageBtnAction(tag: Int){
        quickListImages.forEach { imageView in
            if imageView.tag == tag { imageView.layer.borderColor = UIColor(hex: "#003681").cgColor; imageView.layer.borderWidth = 2; isAnyImageSelected = true; selectedImgTag = tag }
            else { imageView.layer.borderColor = UIColor.systemGray3.cgColor; imageView.layer.borderWidth = 0.7  }
        }
    }
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.showCustomView(firstBtnTitle: "Yes", secondBtntext: "No", message: backBtnMsg) { self.popViewController() } }
    
    ///doneBtnAction...
    @IBAction func doneBtnAction(_ sender: Any) { handelDoneBtnAction() }
    
    ///importTripCloseBtnAction...
    @IBAction func importTripCloseBtnAction(_ sender: Any) { tripImportView.animateHideToBottom(duration: 0.2) { self.importtripMainView.isHidden = true } }
    
    ///importPackingListBtnAction...
    @IBAction func importPackingListBtnAction(_ sender: Any) {
        self.importtripMainView.isHidden = false; tripImportView.animateFromBottom(to: view.bounds.height - 470, duration: 0.5)
    }
    
    ///chooseImageBtnAction...
    @IBAction func chooseImageBtnAction(_ sender: UIButton) { handleChooseImageBtnAction(tag: sender.tag) }
    
    
}

//MARK: - TableView delegate and Datasource...
extension CreateTripQuickListViewController: UITableViewDelegate, UITableViewDataSource {
    
    ///numberOfRowsInSection...
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 10 }
    
    ///cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ImportQuickListTableViewCell
        cell.setUpBGView()
        return cell
    }
    
    ///didSelectRowAt..
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showCustomView(firstBtnTitle: "Yes", secondBtntext: "No", message: "Are you sure want to import this saved packing list?") {
            self.importpackingDetailView.isHidden = false
            self.tripImportView.animateHideToBottom(duration: 0.2) { self.importtripMainView.isHidden = true }
        }
    }
}

//MARK: - Network layer...
extension CreateTripQuickListViewController {
    
    ///createAnQuickListNow...
    func createAnQuickListNow(name: String, image: String, startDate: String, endDate: String){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.createQuickList(name: name, image: image, startDate: startDate, endDate: endDate) { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true { self.hideRappleActivity(); self.handleSuccessResponse(trip: response.trip) }
                else { self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: Constants.errorMsg) }
            case .failure(let error): self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " -> \(error)")
            }
        }
    }
    
    ///handleSuccessResponse...
    func handleSuccessResponse(trip: Trip?){
        if let trip = trip {
            let storyboard = UIStoryboard(name: "Trip", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "QuickListDetailsViewController") as! QuickListDetailsViewController
            controller.trip = trip; controller.isCommingForEditQuickList = isCommingForEditQuickList
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    ///updateQuickList...
    func updateQuickList(tripId: String, name: String, image: String, startDate: String, endDate: String) {
        self.showRappleActivity()
        Constants.tripSavaServcesManager.updateQuickList(tripId: tripId, name: name, image: image, startDate: startDate, endDate: endDate) { resultent in
            switch resultent {
            case .success(let response): self.hideRappleActivity()
                if response.status == true {
                    self.presentAlertAndBackToRootView(withTitle: "Alert", message: "Quicklist updated successfully", controller: self)
                } else { self.presentAlert(withTitle: "Alert", message: Constants.errorMsg) }
            case .failure(let error): self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " -> " + error)
            }
        }
    }
    
}
