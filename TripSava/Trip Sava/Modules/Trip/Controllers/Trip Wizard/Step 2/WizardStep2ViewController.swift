//
//  WizardStep2ViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 19/06/2023.
//

import UIKit

class WizardStep2ViewController: UIViewController {
    
    //MARK: - IBOutlets...
    @IBOutlet weak var accommodationImg1: UIImageView!
    @IBOutlet weak var accommodationImg2: UIImageView!
    @IBOutlet weak var accommodationImg3: UIImageView!
    @IBOutlet weak var accommodationImg4: UIImageView!
    @IBOutlet weak var accommodationImg5: UIImageView!
    @IBOutlet weak var accommodationImg6: UIImageView!
    @IBOutlet weak var accommodationImg7: UIImageView!
    @IBOutlet weak var accommodationImg8: UIImageView!
    @IBOutlet weak var accommodationImg9: UIImageView!
    @IBOutlet weak var accommodationLabel1: UILabel!
    @IBOutlet weak var accommodationLabel2: UILabel!
    @IBOutlet weak var accommodationLabel3: UILabel!
    @IBOutlet weak var accommodationLabel4: UILabel!
    @IBOutlet weak var accommodationLabel5: UILabel!
    @IBOutlet weak var accommodationLabel6: UILabel!
    @IBOutlet weak var accommodationLabel7: UILabel!
    @IBOutlet weak var accommodationLabel8: UILabel!
    @IBOutlet weak var accommodationLabel9: UILabel!
    @IBOutlet weak var transportaionImg1: UIImageView!
    @IBOutlet weak var transportaionImg2: UIImageView!
    @IBOutlet weak var transportaionImg3: UIImageView!
    @IBOutlet weak var transportaionImg4: UIImageView!
    @IBOutlet weak var transportaionImg5: UIImageView!
    @IBOutlet weak var transportaionImg6: UIImageView!
    @IBOutlet weak var transportaionImg7: UIImageView!
    @IBOutlet weak var transportaionImg8: UIImageView!
    @IBOutlet weak var transportaionImg9: UIImageView!
    @IBOutlet weak var transportaionLabel1: UILabel!
    @IBOutlet weak var transportaionLabel2: UILabel!
    @IBOutlet weak var transportaionLabel3: UILabel!
    @IBOutlet weak var transportaionabel4: UILabel!
    @IBOutlet weak var transportaionLabel5: UILabel!
    @IBOutlet weak var transportaionLabel6: UILabel!
    @IBOutlet weak var transportaionLabel7: UILabel!
    @IBOutlet weak var transportaionLabel8: UILabel!
    @IBOutlet weak var transportaionLabel9: UILabel!
    @IBOutlet weak var personalBtn: UIButton!
    @IBOutlet weak var rentalBtn: UIButton!
    @IBOutlet weak var customTransportationTxt: TextField!
    @IBOutlet weak var transportaionBtnView: UIView!
    @IBOutlet weak var transportaionCustomTxtView: UIView!
    @IBOutlet weak var addressTxt: TextField!
    @IBOutlet weak var tripNameTxt: TextField!
    @IBOutlet weak var dateTxt: TextField!
    @IBOutlet weak var purposeTxt: TextField!
    @IBOutlet weak var daysAndNightlabel: UILabel!
    @IBOutlet weak var purposeView: UIView!
    @IBOutlet weak var purposeBtn2: UIButton!
    @IBOutlet weak var purposeBtn1: UIButton!
    @IBOutlet weak var accommodationErrorView: UIView!
    @IBOutlet weak var transportationErrorView: UIView!
    @IBOutlet weak var rentalAndPersonalView: UIView!
    @IBOutlet weak var rentalAndPersonalViewForAccomodation: UIView!
    @IBOutlet weak var AccomodationPersonalBtn: UIButton!
    @IBOutlet weak var AccomodationRentalBtn: UIButton!
    
     
    //MARK: - Variables...
    let backBtnMsg = "Are you sure you want to exit the Trip Wizard?\n\nYour information will not be saved."
    var accommodationImges: [UIImageView] = []; var accommodationLabels: [UILabel] = []
    var transportaionImges: [UIImageView] = []; var transportaionLabels: [UILabel] = []
    var personalAndRentalBtns: [UIButton] = []; var accommodationSelectedTags: [Int] = []
    var accommodationSelecetdImages: [String] = []; var accommodationDefaultImages: [String] = []
    var tripData: TripData?; var isBusinessSelected = false, isLeisureSelected = false
    var transportationSelecetdImages: [String] = []; var transportationDefaultImages: [String] = []
    var transportationSelectedTags: [Int] = []; var personalAndRentalBtnsForAccomodations: [UIButton] = []
    var transportationOptionsSelectedTags: [Int: [Int]] = [:];  var accomodationOptionsSelectedTags: [Int: [Int]] = [:]
    var transportationKeys: [Int: String] = [:]; var accomodationKeys: [Int: String] = [:]
    var isCommingForTripUpdate: Bool = false; var trip: Trip?
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){
        updateData()
        updateViews()
        checkIsCommingForEditTrip()
    }
    
    ///updateViews...
    func updateViews() {
        if let setpOneData = tripData?.tripWizardStep1 {
            dateTxt.text = self.getDateFormatedString(startDate: setpOneData.tripStratDate ?? Date(), endDate: setpOneData.tripEndData ?? Date())
            daysAndNightlabel.text = getDaysAndNightsString(datesRange: setpOneData.dateRanges ?? [])
            addressTxt.text = "\(setpOneData.city ?? "") \(setpOneData.country ?? "")"; tripNameTxt.text = setpOneData.tripName
        }
    }
    
    ///checkIsCommingForEditTrip...
    func checkIsCommingForEditTrip(){
        if isCommingForTripUpdate {
            if let trip = trip {
                
                ///update purposee...
                if let purpose = trip.tripStats?.purposes {
                    if purpose.contains("Business") && purpose.contains("Leisure") { isBusinessSelected = true; isLeisureSelected = true }
                    else if purpose.contains("Business") { isBusinessSelected = true; isLeisureSelected = false }
                    else if purpose.contains("Leisure") { isBusinessSelected = false; isLeisureSelected = true }
                    if isBusinessSelected { purposeBtn1.setImage(UIImage(named: "CheckPurpose"), for: .normal) }
                    else { purposeBtn1.setImage(UIImage(named: "PurPoseCheckBox"), for: .normal) }
                    if isLeisureSelected { purposeBtn2.setImage(UIImage(named: "CheckPurpose"), for: .normal) }
                    else { purposeBtn2.setImage(UIImage(named: "PurPoseCheckBox"), for: .normal) }
                    handlePurposeDoneBtnAction()
                }
                
                ///Update transportaion selected tag...
                trip.tripStats?.transportModes?.forEach({ transport in
                    if let indexValue = transport.key, let key = findKey(forValue: indexValue, inDictionary: transportationKeys) {
                        updateTransportation(tag: key)
                        if [2,5,6].contains(key){
                            if (transport.isPersonal ?? false) { updateTransportaionButton(tag: key, isOptionBtnClick: true, optionBtnTag: 1) }
                            if (transport.isRental ?? false) { updateTransportaionButton(tag: key, isOptionBtnClick: true, optionBtnTag: 2) }
                        }
                    }
                })
                
                /// now update accommodation selected tag... 
                trip.tripStats?.accommodations?.forEach({ accomodation in
                    if let indexValue = accomodation.key, let key = findKey(forValue: indexValue, inDictionary: accomodationKeys) {
                        updateAccomodation(tag: key)
                        if [5,7].contains(key){
                            if (accomodation.isPersonal ?? false) {
                                 updateAccomodationButton(tag: key, isOptionBtnClick: true, optionBtnTag: 1) }
                            if (accomodation.isRental ?? false) {
                                 updateAccomodationButton(tag: key, isOptionBtnClick: true, optionBtnTag: 2) }
                        }
                    }
                })
                rentalAndPersonalViewForAccomodation.isHidden = true; rentalAndPersonalView.isHidden = true
                customTransportationTxt.text = trip.tripStats?.customTransportMode /// update custom transportation txt...
            }
        }
    }
    
    ///updateData...
    func updateData(){
        accommodationSelecetdImages = ["AccommodationBlue-01", "AccommodationBlue-02", "AccommodationBlue-03", "AccommodationBlue-04", "AccommodationBlue-05", "AccommodationBlue-06", "AccommodationBlue-06", "AccommodationBlue-08", "AccommodationBlue-10"]
        accommodationDefaultImages = ["AccommodationGrey-04", "AccommodationGrey-03", "AccommodationGrey-08", "AccommodationGrey-07", "AccommodationGrey-02" , "AccommodationGrey-06", "AccommodationGrey-01", "AccommodationGrey-05", "AccommodationGrey-10"]
        
        transportationSelecetdImages = ["PlanBlue", "CarBlue", "TranBlue", "BusBlue", "BikeBlue" , "BoatBlue", "MotorcycleBlue", "OthersBlue", "AccommodationBlue-10"]
        transportationDefaultImages = ["PlaneGray", "CarGray", "TrainGray", "BusGray", "BikeGray" , "BoatGray", "MotorcycleGray", "OthersGary", "AccommodationGrey-10"]
        
        accommodationImges = [accommodationImg1, accommodationImg2, accommodationImg3, accommodationImg4, accommodationImg5, accommodationImg6, accommodationImg7, accommodationImg8, accommodationImg9]
        
        accommodationLabels = [accommodationLabel1, accommodationLabel2, accommodationLabel3, accommodationLabel4, accommodationLabel5, accommodationLabel6, accommodationLabel7, accommodationLabel8, accommodationLabel9]
        
        transportaionImges = [transportaionImg1, transportaionImg2, transportaionImg3, transportaionImg4, transportaionImg5, transportaionImg6, transportaionImg7, transportaionImg8, transportaionImg9]
        
        transportaionLabels = [transportaionLabel1, transportaionLabel2, transportaionLabel3, transportaionabel4, transportaionLabel5, transportaionLabel6, transportaionLabel7, transportaionLabel8, transportaionLabel9]
        
        personalAndRentalBtns = [personalBtn, rentalBtn]; personalAndRentalBtnsForAccomodations = [AccomodationPersonalBtn, AccomodationRentalBtn]
        transportationOptionsSelectedTags = [2: [], 5: [], 6: []]; accomodationOptionsSelectedTags = [5: [], 7: []]
        
        accomodationKeys = [1: "hotel", 2: "rental", 3: "friends_family", 4: "second_home", 5: "camping", 6: "cruise", 7: "rv", 8: "other", 9: "not_decided"]
        transportationKeys = [1: "plane", 2: "car", 3: "train", 4: "bus", 5: "bike", 6: "boat", 7: "motorcycle", 8: "other", 9: "not_decided"]
    }
    
    
    ///handlePurposeOptionBtnAction..
    func handlePurposeOptionBtnAction(sender: UIButton){
        if sender.tag == 0 {
            isBusinessSelected.toggle()
            if isBusinessSelected { purposeBtn1.setImage(UIImage(named: "CheckPurpose"), for: .normal) }
            else { purposeBtn1.setImage(UIImage(named: "PurPoseCheckBox"), for: .normal) }
        }
        else if sender.tag == 1 {
            isLeisureSelected.toggle()
            if isLeisureSelected { purposeBtn2.setImage(UIImage(named: "CheckPurpose"), for: .normal) }
            else { purposeBtn2.setImage(UIImage(named: "PurPoseCheckBox"), for: .normal) }
        }
    }
    
    ///handlePurposeDoneBtnAction...
    func handlePurposeDoneBtnAction(){
        if isBusinessSelected && isLeisureSelected { purposeTxt.text = "Business & Leisure" }
        else if isBusinessSelected && !isLeisureSelected { purposeTxt.text = "Business" }
        else if !isBusinessSelected && isLeisureSelected { purposeTxt.text = "Leisure" }
        else { purposeTxt.text = "" }; self.purposeView.isHidden = true
    }
    
    
    
    ///updateAccomodation...
    func updateAccomodation(tag: Int) {
        if [5,7].contains(tag) { updatePersonalAndRentalBtnsForAccomodations(buttonTag: tag); rentalAndPersonalViewForAccomodation.isHidden = false; rentalAndPersonalViewForAccomodation.tag = tag }
        else { rentalAndPersonalViewForAccomodation.isHidden = true; updateAccomodationButton(tag: tag, isOptionBtnClick: false, optionBtnTag: 0) }
    }
    
    ///handleAccomodationOptionBtnAction...
    func handleAccomodationOptionBtnAction(sender: UIButton){
        if sender.tag == 1 { rentalAndPersonalViewForAccomodation.isHidden = true; updateAccomodationButton(tag: rentalAndPersonalViewForAccomodation.tag, isOptionBtnClick: true, optionBtnTag: 1) }
        else if sender.tag == 2 { rentalAndPersonalViewForAccomodation.isHidden = true; updateAccomodationButton(tag: rentalAndPersonalViewForAccomodation.tag, isOptionBtnClick: true, optionBtnTag: 2) }
    }
    
    ///updateTransportaion..
    func updateAccomodationButton(tag: Int, isOptionBtnClick: Bool, optionBtnTag: Int) {
        
        if isOptionBtnClick { /// when tag 2,5,6 clicked
            
            let labelText = accommodationLabels[tag - 1].text?.lowercased().removing(substringsToRemove: ["personal & rental", "personal", "rental"])
            if accomodationOptionsSelectedTags[tag]!.contains(optionBtnTag) {
                accomodationOptionsSelectedTags[tag]!.removeAll { tag in if tag == optionBtnTag { return true } else { return false } }
            } else { accomodationOptionsSelectedTags[tag]!.append(optionBtnTag) }
            
            
            if accomodationOptionsSelectedTags[tag]!.isEmpty {
                if accommodationSelectedTags.contains(tag) { if let index = accommodationSelectedTags.firstIndex(of: tag) { accommodationSelectedTags.remove(at: index) } }
                accommodationLabels[tag - 1].text = labelText?.capitalized
                accommodationImges[tag - 1].image = UIImage(named: accommodationDefaultImages[tag - 1])
                accommodationLabels[tag - 1].textColor  = UIColor(hex: "#474847")
            }
            else {
                if !accommodationSelectedTags.contains(tag) { accommodationSelectedTags.append(tag) }; var text  = ""
                if accomodationOptionsSelectedTags[tag]!.contains(1) && accomodationOptionsSelectedTags[tag]!.contains(2) { text = "Personal & Rental \(labelText?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")" }
                else if accomodationOptionsSelectedTags[tag]!.contains([1]) { text = "Personal \(labelText?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")" }
                else if accomodationOptionsSelectedTags[tag]!.contains([2]) { text = "Rental \(labelText?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")" }
                accommodationLabels[tag - 1].text = text
                accommodationImges[tag - 1].image = UIImage(named: accommodationSelecetdImages[tag - 1])
                accommodationLabels[tag - 1].textColor = UIColor(hex: "#003681")
            }; updatePersonalAndRentalBtnsForAccomodations(buttonTag: tag)
        }
        else {
            if tag == 9 { /// when tag 9 is selcetd...
                accomodationOptionsSelectedTags = [5: [], 7: []]
                if accommodationSelectedTags.contains(tag) { if let index = accommodationSelectedTags.firstIndex(of: tag) { accommodationSelectedTags.remove(at: index) } }
                else { accommodationSelectedTags.append(tag) }
                accommodationSelectedTags.removeAll { tag in if tag != 9 { return true } else { return false } }
            }
            else { /// all other btn actions handle here...
                if accommodationSelectedTags.contains(9) { accommodationSelectedTags.removeAll { tag in if tag == 9 { return true } else { return false } } }
                if accommodationSelectedTags.contains(tag) { if let index = accommodationSelectedTags.firstIndex(of: tag) { accommodationSelectedTags.remove(at: index) } }
                else { accommodationSelectedTags.append(tag) }
            }
            
            /// Update the images and labels based on selectedTags array
            for (index, img) in accommodationImges.enumerated() {
                if accommodationSelectedTags.contains(index + 1) {
                    img.image = UIImage(named: accommodationSelecetdImages[index]); accommodationLabels[index].textColor = UIColor(hex: "#003681")
                } else { img.image = UIImage(named: accommodationDefaultImages[index]); accommodationLabels[index].textColor = UIColor(hex: "#474847") }
            }
        }
    }
    
    
    ///updateAccommodation...
    func updatePersonalAndRentalBtnsForAccomodations(buttonTag: Int){
        for (_, btn) in personalAndRentalBtnsForAccomodations.enumerated() {
            if accomodationOptionsSelectedTags[buttonTag]!.contains(btn.tag) {
                btn.backgroundColor = UIColor(hex: "#003681"); btn.setTitleColor(.white, for: .normal)
            } else { btn.backgroundColor =  .white ; btn.setTitleColor(UIColor(hex: "#474847", alpha: 0.96), for: .normal) }
        }
    }
    
    
    
    ///updateTransportation...
    func updateTransportation(tag: Int) {
        if [2,5,6].contains(tag) { updatePersonalAndRentalBtns(buttonTag: tag); rentalAndPersonalView.isHidden = false; rentalAndPersonalView.tag = tag }
        else { rentalAndPersonalView.isHidden = true; updateTransportaionButton(tag: tag, isOptionBtnClick: false, optionBtnTag: 0) }
    }
    
    ///handleTransportationOptionBtnAction...
    func handleTransportationOptionBtnAction(sender: UIButton){
        if sender.tag == 1 { rentalAndPersonalView.isHidden = true; updateTransportaionButton(tag: rentalAndPersonalView.tag, isOptionBtnClick: true, optionBtnTag: 1) }
        else if sender.tag == 2 { rentalAndPersonalView.isHidden = true; updateTransportaionButton(tag: rentalAndPersonalView.tag, isOptionBtnClick: true, optionBtnTag: 2) }
    }
    
    ///updateTransportaion..
    func updateTransportaionButton(tag: Int, isOptionBtnClick: Bool, optionBtnTag: Int) {
        
        if isOptionBtnClick { /// when tag 2,5,6 clicked
            
            let labelText = transportaionLabels[tag - 1].text?.lowercased().removing(substringsToRemove: ["personal & rental", "personal", "rental"])
            if transportationOptionsSelectedTags[tag]!.contains(optionBtnTag) {
                transportationOptionsSelectedTags[tag]!.removeAll { tag in if tag == optionBtnTag { return true } else { return false } }
            } else { transportationOptionsSelectedTags[tag]!.append(optionBtnTag) }
            
            
            if transportationOptionsSelectedTags[tag]!.isEmpty {
                if transportationSelectedTags.contains(tag) { if let index = transportationSelectedTags.firstIndex(of: tag) { transportationSelectedTags.remove(at: index) } }
                transportaionLabels[tag - 1].text = labelText?.capitalized
                transportaionImges[tag - 1].image = UIImage(named: transportationDefaultImages[tag - 1])
                transportaionLabels[tag - 1].textColor  = UIColor(hex: "#474847")
            }
            else {
                if !transportationSelectedTags.contains(tag) { transportationSelectedTags.append(tag) }; var text  = ""
                if transportationOptionsSelectedTags[tag]!.contains(1) && transportationOptionsSelectedTags[tag]!.contains(2) { text = "Personal & Rental \(labelText?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")" }
                else if transportationOptionsSelectedTags[tag]!.contains([1]) { text = "Personal \(labelText?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")" }
                else if transportationOptionsSelectedTags[tag]!.contains([2]) { text = "Rental \(labelText?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")" }
                transportaionLabels[tag - 1].text = text
                transportaionImges[tag - 1].image = UIImage(named: transportationSelecetdImages[tag - 1])
                transportaionLabels[tag - 1].textColor = UIColor(hex: "#003681")
            }; updatePersonalAndRentalBtns(buttonTag: tag)
        }
        else {
            if tag == 9 { /// when tag 9 is selcetd...
                transportationOptionsSelectedTags = [2: [], 5: [], 6: []]
                if transportationSelectedTags.contains(tag) { if let index = transportationSelectedTags.firstIndex(of: tag) { transportationSelectedTags.remove(at: index) } }
                else { transportationSelectedTags.append(tag) }
                transportationSelectedTags.removeAll { tag in if tag != 9 { return true } else { return false } }
            }
            else { /// all other btn actions handle here...
                if transportationSelectedTags.contains(9) { transportationSelectedTags.removeAll { tag in if tag == 9 { return true } else { return false } } }
                if transportationSelectedTags.contains(tag) { if let index = transportationSelectedTags.firstIndex(of: tag) { transportationSelectedTags.remove(at: index) } }
                else { transportationSelectedTags.append(tag) }
            }
            
            /// Update the images and labels based on selectedTags array
            for (index, img) in transportaionImges.enumerated() {
                if transportationSelectedTags.contains(index + 1) {
                    img.image = UIImage(named: transportationSelecetdImages[index]); transportaionLabels[index].textColor = UIColor(hex: "#003681")
                } else { img.image = UIImage(named: transportationDefaultImages[index]); transportaionLabels[index].textColor = UIColor(hex: "#474847") }
            }
        }
        
    }
    
    ///updateAccommodation...
    func updatePersonalAndRentalBtns(buttonTag: Int){
        for (_, btn) in personalAndRentalBtns.enumerated() {
            if transportationOptionsSelectedTags[buttonTag]!.contains(btn.tag) {
                btn.backgroundColor = UIColor(hex: "#003681"); btn.setTitleColor(.white, for: .normal)
            }
            else { btn.backgroundColor =  .white ; btn.setTitleColor(UIColor(hex: "#474847", alpha: 0.96), for: .normal) }
        }
    }
    
    
    ///handleNextBtnAction...
    func handleNextBtnAction(){
        var purpose: [String] = []; var transportationList: [TransportMode] = []; var accomodationList: [TransportMode] = [];
        if isBusinessSelected && isLeisureSelected { purpose = ["Business", "Leisure"] }
        else if isBusinessSelected { purpose = ["Business"] }
        else if isLeisureSelected { purpose = ["Leisure"] }
        
        transportationSelectedTags.forEach { transportationTag in
            if [2,5,6].contains(transportationTag) {
                let isPersonal = transportationOptionsSelectedTags[transportationTag]?.contains(1) ?? false
                let isRental = transportationOptionsSelectedTags[transportationTag]?.contains(2) ?? false
                let selectedItemKey = transportationKeys[transportationTag]
                transportationList.append(TransportMode(key: selectedItemKey ?? "", isPersonal: isPersonal, isRental: isRental))
            }
            else { transportationList.append(TransportMode(key: transportationKeys[transportationTag] ?? "", isPersonal: false, isRental: false)) }
        }
        
        
        accommodationSelectedTags.forEach { accomodationTag in
            if [5,7].contains(accomodationTag) {
                let isPersonal = accomodationOptionsSelectedTags[accomodationTag]?.contains(1) ?? false
                let isRental = accomodationOptionsSelectedTags[accomodationTag]?.contains(2) ?? false
                let selectedItemKey = accomodationKeys[accomodationTag]
                accomodationList.append(TransportMode(key: selectedItemKey ?? "", isPersonal: isPersonal, isRental: isRental))
            }
            else { accomodationList.append(TransportMode(key: accomodationKeys[accomodationTag] ?? "", isPersonal: false, isRental: false)) }
        }
        
        
        if purpose.isEmpty { self.presentAlert(withTitle: "Alert", message: "Please Select Your Purpose") }
        else if accommodationSelectedTags.isEmpty { self.presentAlert(withTitle: "Alert", message: "Please Select Your accommodation"); accommodationErrorView.isHidden = false }
        else if transportationSelectedTags.isEmpty { self.presentAlert(withTitle: "Alert", message: "Please Select Your transportation");
            transportationErrorView.isHidden = false; accommodationErrorView.isHidden = true }
        else {
            let step2Data = TripWizardStep2(purpose: purpose, accommodation: accomodationList, transportation: transportationList, customTransportation: customTransportationTxt.trimText())
            self.tripData?.tripWizardStep2 = step2Data
            
            let controller = storyboard?.instantiateViewController(withIdentifier: "WizardStep3ViewController") as! WizardStep3ViewController
            controller.tripData = tripData; controller.trip = trip; controller.isCommingForTripUpdate = isCommingForTripUpdate
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        
    }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.showCustomView(firstBtnTitle: "Yes", secondBtntext: "No", message: backBtnMsg) { self.popToRootViewController() } }
    
    ///nextBtnAction...
    @IBAction func nextBtnAction(_ sender: Any) { handleNextBtnAction() }
    
    ///accommodationBtnAction....
    @IBAction func accommodationBtnAction(_ sender: UIButton) { updateAccomodation(tag: sender.tag) }
    
    ///transportationBtnAction...
    @IBAction func transportationBtnAction(_ sender: UIButton) { updateTransportation(tag: sender.tag) }
    
    ///purposeViewCloseBtnAction...
    @IBAction func purposeViewCloseBtnAction(_ sender: Any) { self.purposeView.isHidden = true }
    
    ///purposeOptionBtnAction...
    @IBAction func purposeOptionBtnAction(_ sender: UIButton) { handlePurposeOptionBtnAction(sender: sender) }
    
    ///showPurposeBtnAction...
    @IBAction func showPurposeBtnAction(_ sender: Any) { self.purposeView.isHidden = false }
    
    ///purposeDoneBtnAction...
    @IBAction func purposeDoneBtnAction(_ sender: Any) { handlePurposeDoneBtnAction() }
    
    ///transportationOptionBtnAction...
    @IBAction func transportationOptionBtnAction(_ sender: UIButton) { handleTransportationOptionBtnAction(sender: sender) }
    
    @IBAction func accomodationsOptionBtnAction(_ sender: UIButton) { handleAccomodationOptionBtnAction(sender: sender) }
    
}


