//
//  WizardStep3ViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 19/06/2023.
//

import UIKit

class WizardStep3ViewController: UIViewController {
    
    //MARK: - IBOutlets...
    @IBOutlet weak var laundryYesBtn: UIButton!
    @IBOutlet weak var laundryNoBtn: UIButton! 
    @IBOutlet weak var laundryView: UIView!
    
    @IBOutlet weak var petYesBtn: UIButton!
    @IBOutlet weak var petNoBtn: UIButton!
    
    @IBOutlet weak var petTravellingOption1CheckImg1: UIImageView!
    @IBOutlet weak var petTravellingOption1CheckImg2: UIImageView!
    @IBOutlet weak var petTravellingOption1CheckImg3: UIImageView!
    
    @IBOutlet weak var preparationTaskImg1: UIImageView!
    @IBOutlet weak var preparationTaskImg2: UIImageView!
    @IBOutlet weak var preparationTaskImg3: UIImageView!
    
    @IBOutlet weak var preparationTaskLabel1: UILabel!
    @IBOutlet weak var preparationTaskLabel2: UILabel!
    @IBOutlet weak var preparationTaskLabel3: UILabel!
    
    @IBOutlet weak var preparationTaskDetailLabel1: UILabel!
    @IBOutlet weak var preparationTaskDetailLabel2: UILabel!
    @IBOutlet weak var preparationTaskDetailLabel3: UILabel!
    
    @IBOutlet weak var preparationTaskView1: UIView!
    @IBOutlet weak var preparationTaskView2: UIView!
    @IBOutlet weak var preparationTaskView3: UIView!
    
    @IBOutlet weak var finishBtn: UIButton!
    
    //MARK: - Variables...
    let backBtnMsg = "Are you sure you want to exit the Trip Wizard?\n\nYour information will not be saved."
    var isLaundry = false; var isPetTravelling = false; var petSuggestion = 99; var isOptionalPreparationTask = 99
    var laundryBtns: [UIButton] = []
    var petTravellingBtns: [UIButton] = []
    var petSuggestionListImgs: [UIImageView] = []
    var preparationTaskImages: [UIImageView] = []
    var preparationTaskLabels: [UILabel] = []
    var preparationTaskDetailsLabels: [UILabel] = []
    var preparationTaskViews: [UIView] = []; var selectedPetOptionalTags: [Int] = []
    var selectedStates: [Bool] = [false, false, false]
    var tripData: TripData?; var isCommingForTripUpdate: Bool = false; var trip: Trip?
    
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    ///viewDidDisappear...
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        setUpViewDidApear()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){ updateData() }
    
    ///setUpViewDidApear...
    func setUpViewDidApear(){ self.navigationController?.tabBarController?.tabBar.isHidden = false }
    
    ///updateData...
    func updateData(){
        laundryBtns = [laundryYesBtn, laundryNoBtn]
        petTravellingBtns = [petYesBtn, petNoBtn]
        petSuggestionListImgs = [petTravellingOption1CheckImg1, petTravellingOption1CheckImg2, petTravellingOption1CheckImg3]
        preparationTaskImages = [preparationTaskImg1, preparationTaskImg2, preparationTaskImg3]
        preparationTaskLabels = [preparationTaskLabel1, preparationTaskLabel2, preparationTaskLabel3]
        preparationTaskDetailsLabels = [preparationTaskDetailLabel1, preparationTaskDetailLabel2, preparationTaskDetailLabel3]
        preparationTaskViews = [preparationTaskView1, preparationTaskView2, preparationTaskView3]
        checkIsCommingForEditTrip(); self.navigationController?.tabBarController?.tabBar.isHidden = true
        if let tripData { if tripData.tripWizardStep1?.dateRanges?.count ?? 0 < 5 { laundryView.isHidden = true } }
    }
    
    ///checkIsCommingForEditTrip...
    func checkIsCommingForEditTrip(){
        if isCommingForTripUpdate {
            if let trip = trip {
                finishBtn.setTitle("Update", for: .normal)
                isLaundry = trip.tripStats?.requiresLaundry ?? false
                if isLaundry == true { updateLaundryBtnActions(tag: 1) } else { updateLaundryBtnActions(tag: 2) }
                isPetTravelling = trip.tripStats?.hasPets ?? false
                if isPetTravelling == true { updatePetTravellingBtnActions(tag: 1) } else { updatePetTravellingBtnActions(tag: 2) }
                if let petCateTask = trip.tripStats?.petCareTasks {
                    if petCateTask == 1 { updatePetSuggestionBtnActions(tag: 0 ) }
                    else if petCateTask == 2 { updatePetSuggestionBtnActions(tag: 1 ) }
                    else if petCateTask == 3 { updatePetSuggestionBtnActions(tag: 2 ) }
                    else if petCateTask == 4 { updatePetSuggestionBtnActions(tag: 0); updatePetSuggestionBtnActions(tag: 1) }
                }
                if let additionalTask = trip.tripStats?.additionalTasks { additionalTask.forEach { tag in  updatePreparationTaskBtnActions(tag: tag ) } }
            }
        }
    }
    
    ///updateLaundryBtnActions...
    func updateLaundryBtnActions(tag: Int){
        laundryBtns.forEach { btn in
            if btn.tag == tag { btn.backgroundColor = UIColor(hex: "#003681"); btn.setTitleColor(.white, for: .normal) }
            else { btn.backgroundColor =  .white ; btn.setTitleColor(UIColor(hex: "#474847", alpha: 0.96), for: .normal)    }
        }
        if tag == 1 { isLaundry = true } else { isLaundry = false }
    }
    
    ///updatePetTravellingBtnActions...
    func updatePetTravellingBtnActions(tag: Int){
        petTravellingBtns.forEach { btn in
            if btn.tag == tag { btn.backgroundColor = UIColor(hex: "#003681"); btn.setTitleColor(.white, for: .normal) }
            else { btn.backgroundColor =  .white ; btn.setTitleColor(UIColor(hex: "#474847", alpha: 0.96), for: .normal)    }
        }
        if tag == 1 { isPetTravelling = true } else { isPetTravelling = false }
    }
    
    ///updatePetSuggestionBtnActions...
    func updatePetSuggestionBtnActions(tag: Int){
        let index = tag; selectedStates[index] = !selectedStates[index]
        let imageName = selectedStates[index] ? "checkBoxSelected" : "checkBoxUnSelected"
        petSuggestionListImgs[index].image = UIImage(named: imageName)
         
        if index == 2 && (selectedStates[0] || selectedStates[1]) {
            selectedStates[0] = false; selectedStates[1] = false
            petSuggestionListImgs[0].image = UIImage(named: "checkBoxUnSelected")
            petSuggestionListImgs[1].image = UIImage(named: "checkBoxUnSelected")
        }
        else if selectedStates[0] || selectedStates[1] { selectedStates[2] = false; petSuggestionListImgs[2].image = UIImage(named: "checkBoxUnSelected") }
         
        if selectedStates[0] == true && selectedStates[1] == false  { petSuggestion = 1 }
        else if selectedStates[0] == false && selectedStates[1] == true  { petSuggestion = 2 }
        else if selectedStates[2] == true { petSuggestion = 3 }
        else if selectedStates[0] && selectedStates[1]  { petSuggestion = 4 }
        else { petSuggestion = 99 }
    }
    
    ///updatePetSuggestionBtnActions...
    func updatePreparationTaskBtnActions(tag: Int) {
        if selectedPetOptionalTags.contains(tag) { if let index = selectedPetOptionalTags.firstIndex(of: tag) { selectedPetOptionalTags.remove(at: index) } }
        else { selectedPetOptionalTags.append(tag) }

        /// Now update the UI based on the selectedTags array
        preparationTaskImages.forEach { img in
            if selectedPetOptionalTags.contains(img.tag) { img.backgroundColor = UIColor(hex: "#003681"); img.tintColor = .white }
            else { img.backgroundColor = .white; img.tintColor = UIColor(hex: "#4E4F4E") }
        }
        
        preparationTaskLabels.forEach { lbl in
            if selectedPetOptionalTags.contains(lbl.tag) { lbl.textColor = .white } else { lbl.textColor = UIColor(hex: "#474847", alpha: 0.96) }
        }
        
        preparationTaskDetailsLabels.forEach { lbl in
            if selectedPetOptionalTags.contains(lbl.tag) { lbl.textColor = .white.withAlphaComponent(0.90) } else { lbl.textColor = UIColor(hex: "#474847", alpha: 0.80) }
        }
        
        preparationTaskViews.forEach { view in
            if selectedPetOptionalTags.contains(view.tag) { view.backgroundColor = UIColor(hex: "#003681") } else { view.backgroundColor = .white }
        }
    }
    
     
    ///handleFinishBtnAction..
    func handleFinishBtnAction(){
        if petSuggestion == 99 { presentAlert(withTitle: "Alert", message: "Please select pet traveling with you or not") }
        else if selectedPetOptionalTags.count <= 0 { presentAlert(withTitle: "Alert", message: "Please select pet traveling with you or not") }
        else {
            let step3 = TripWizardStep3(laundryPlan: isLaundry, petsTraveling: isPetTravelling, packingAndPreparingListForPet: petSuggestion, optionalPreparationTasksList: selectedPetOptionalTags); tripData?.tripWizardStep3 = step3
            if let data = tripData { createTripWizard(tripData: data) } else { presentAlert(withTitle: "Alert", message: Constants.errorMsg) }
        }
    }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.showCustomView(firstBtnTitle: "Yes", secondBtntext: "No", message: backBtnMsg) { self.popToRootViewController() } }
    
    ///finishBtnAction...
    @IBAction func finishBtnAction(_ sender: Any) { handleFinishBtnAction() }
    
    ///laundryBtnsAction...
    @IBAction func laundryBtnsAction(_ sender: UIButton) { updateLaundryBtnActions(tag: sender.tag) }
    
    ///petTravellingOptionBtnAction..
    @IBAction func petTravellingOptionBtnAction(_ sender: UIButton) { updatePetTravellingBtnActions(tag: sender.tag) }
    
    ///petSuggestionBtnAction...
    @IBAction func petSuggestionBtnAction(_ sender: UIButton) { updatePetSuggestionBtnActions(tag: sender.tag) }
    
    
    @IBAction func preparationTaskBtnAction(_ sender: UIButton) { updatePreparationTaskBtnActions(tag: sender.tag) }
    
    
}


//MARK: - Network layer...
extension WizardStep3ViewController {
    
    ///createTripWizard..
    func createTripWizard(tripData: TripData){
        self.showRappleActivity()
        let step1 = tripData.tripWizardStep1; let step2 = tripData.tripWizardStep2; let step3 = tripData.tripWizardStep3
        var accommodations: [[String: Any]] = [];  var transportModes: [[String: Any]] = []
        
        if let accommodation = step2?.accommodation { /// get all accomodation
            for mode in accommodation {
                let accommodationDict: [String: Any] = [ "key": mode.key, "isPersonal": mode.isPersonal, "isRental": mode.isRental ]
                accommodations.append(accommodationDict)
            }
        }
        if let transportation = step2?.transportation { ///get All transportationMode...
            for mode in transportation {
                let transportationDict: [String: Any] = [ "key": mode.key, "isPersonal": mode.isPersonal, "isRental": mode.isRental ]
                transportModes.append(transportationDict)
            }
        }
        
        let parameters: [String: Any] = [
            "location": [ "country": step1?.country ?? "", "city": step1?.city ?? "", "lat": step1?.lat ?? 0, "lng": step1?.long ?? 0 ] as [String : Any],
            "name": step1?.tripName ?? "", "startDate": step1?.tripStratDate?.formattedString(with: "yyyy-MM-dd") ?? "", "endDate": step1?.tripEndData?.formattedString(with: "yyyy-MM-dd") ?? "",
            "purposes": step2?.purpose ?? [], "accommodations": accommodations, "transportModes":  transportModes, "customTransportMode": step2?.customTransportation ?? "",
            "requiresLaundry": step3?.laundryPlan ?? false, "hasPets": step3?.petsTraveling ?? false,
            "petCareTasks": step3?.packingAndPreparingListForPet ?? 99, "additionalTasks": step3?.optionalPreparationTasksList ?? 99
        ]
        
        if isCommingForTripUpdate { if let trip = trip { updateTrip(tripId: trip.id ?? "", parameters: parameters) } }
        else { createTripWizardNow(parameters: parameters) }
        
    
    }
    
    ///createTripWizardNow...
    func createTripWizardNow(parameters: [String: Any]){
        ///Now call the api...
        Constants.tripSavaServcesManager.createTripWizard(params: parameters) { resultent in
            switch resultent {
            case .success(let response):
                print(response)
                if response.status == true {
                    if let trip = response.trip { self.goToWeatherScreen(trip: trip) }
                    else { self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " ") }
                }
                else { self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " ") }
            case .failure(let error):
                print(error)
                self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " " + error)
            }
        }
    }
    
    ///goToWeatherScreen...
    func goToWeatherScreen(trip: Trip){
        self.hideRappleActivity()
        let controller = storyboard?.instantiateViewController(withIdentifier: "TripWeatherDetailsViewController") as! TripWeatherDetailsViewController
        controller.trip = trip; self.navigationController?.pushViewController(controller, animated: true)
    }
    
    ///updateTrip...
    func updateTrip(tripId: String, parameters: [String: Any]){
        print(parameters)
        Constants.tripSavaServcesManager.updateTrip(tripId: tripId, params: parameters) { resultent in
            switch resultent {
            case .success(let response): self.hideRappleActivity();
                print(response)
                if response.status == true {
                    self.presentAlertAndBackToRootView(withTitle: "Alert", message: "Trip Updated successfully", controller: self)
                    
                }
                else { self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " ") }
            case .failure(let error): self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " " + error)
            }
        }
    }
}
