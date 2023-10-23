//
//  SignUpDetailsViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 13/06/2023.
//

import UIKit
import DropDown
import ActiveLabel
import IQKeyboardManager

class SignUpDetailsViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var genderTxt: TextField!
    @IBOutlet weak var firstNameTxt: TextField!
    @IBOutlet weak var lastNameTxt: TextField!
    @IBOutlet weak var locationTxt: TextField!
    @IBOutlet weak var dateOfBrithTxt: TextField!
    @IBOutlet weak var travelExperinceTxt: TextField!
    @IBOutlet weak var termAndConditionLabel: ActiveLabel!
    
    
    
    //MARK: - Variables...
    let birthDatePicker = UIDatePicker()
    let genderDropDown = DropDown()
    let experienceDropDown = DropDown()
    let locationDropDown = DropDown()
    var user: userCredentials?
    var city = "", country = ""
    let messageString = "By using TripSava, you agree to our Terms of Use and Privacy Policy."
    let privacyPolicyStr = "Privacy Policy."
    let termsAndConditionStr = "Terms of Use"
    var searchPlaceFromGoogleAllResults = [GeocodingResult]()
    var addressList: [String] = []
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    ///touchesBegan....
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        IQKeyboardManager.shared().resignFirstResponder()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){ setUpData(); setUpTermsAndConditionAttributedString() }
    
    ///setUpTermsAndConditionAttributedString...
    func setUpTermsAndConditionAttributedString() {
        
        let customType = ActiveType.custom(pattern: "\\sTerms of Use\\b")
        let customType1 = ActiveType.custom(pattern: "\\sPrivacy Policy\\b")
        termAndConditionLabel.enabledTypes = [.mention, .hashtag, .url, customType, customType1]
        termAndConditionLabel.text = "By using TripSava, you agree to our Terms of Use and Privacy Policy.      "
        termAndConditionLabel.numberOfLines = 0
        
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor(hex: "#E26A2B"), NSAttributedString.Key.font : Constants.applyFonts_DMSans(style: .Medium, size: 12), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
        
        termAndConditionLabel.customize { label in
            label.configureLinkAttribute = { _, _, _ in  return attributes  }
        }
        
        termAndConditionLabel.textColor = UIColor(hex: "#808080")
        termAndConditionLabel.font = Constants.applyFonts_DMSans(style: .regular, size: 12)
        
        termAndConditionLabel.handleCustomTap(for: customType) { element in
            SafariViewController.shared.openUrlWith(linkString: Constants.Urls.termsAndServicesUrl, Parentcontroller: self)
        }
        
        termAndConditionLabel.handleCustomTap(for: customType1) { element in
            SafariViewController.shared.openUrlWith(linkString: Constants.Urls.privacyAndPolicyUrl, Parentcontroller: self)
        }
        
    }
    
    /// dropdown...
    func setUpData() {
        
        /// Gender...
        genderDropDown.dataSource = ["   Female","   Male", "   Non Binary", "   Prefer not to say"]
        genderDropDown.bottomOffset = CGPoint(x: 0, y: genderTxt.frame.height + 6)
        genderDropDown.anchorView = genderTxt
        genderDropDown.direction = .bottom
        genderDropDown.backgroundColor = .white
        genderDropDown.textColor = UIColor(hex: "#474847")
        genderDropDown.selectedTextColor = UIColor(hex: "#E26A2B")
        genderDropDown.separatorColor = UIColor(hex: "#CBCBCB", alpha: 0.40)
        genderDropDown.textFont = Constants.applyFonts_DMSans(style: .regular, size: 14)
        genderDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            self?.genderTxt.text = String(item.dropFirst(3))
        }
        
        /// experience...
        experienceDropDown.dataSource = ["Novice","Somewhere in the middle", "Expert"]
        experienceDropDown.bottomOffset = CGPoint(x: 0, y: travelExperinceTxt.frame.height + 6)
        experienceDropDown.textFont = Constants.applyFonts_DMSans(style: .regular, size: 14)
        experienceDropDown.anchorView = travelExperinceTxt
        experienceDropDown.direction = .bottom
        experienceDropDown.backgroundColor = .white
        experienceDropDown.textColor = UIColor(hex: "#474847")
        experienceDropDown.selectedTextColor = UIColor(hex: "#E26A2B")
        experienceDropDown.separatorColor = UIColor(hex: "#CBCBCB", alpha: 0.30)
        
        experienceDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            self?.travelExperinceTxt.text = item
        }
        
        ///locationDropDown...
        locationDropDown.bottomOffset = CGPoint(x: 0, y: locationTxt.frame.height + 6)
        locationDropDown.textFont = Constants.applyFonts_DMSans(style: .regular, size: 14)
        locationDropDown.anchorView = locationTxt
        locationDropDown.direction = .bottom
        locationDropDown.backgroundColor = .white
        locationDropDown.textColor = UIColor(hex: "#474847")
        locationDropDown.selectedTextColor = UIColor(hex: "#E26A2B")
        locationDropDown.separatorColor = UIColor(hex: "#CBCBCB", alpha: 0.30)
         
        locationDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            let data = self?.searchPlaceFromGoogleAllResults[index]
            
            data?.address_components?.forEach({ address in
                if let types = address.types { if types.contains("country") { self?.country = address.long_name ?? "" } }
                if let types = address.types { if types.contains("locality") { self?.city = address.long_name ?? "" } }
            }); self?.locationTxt.text = item
        }
        
        /// textfields...
        birthDatePicker.setMaximumAgeInYears(0, textField: dateOfBrithTxt, action: #selector(birthDateDone), picker: birthDatePicker)
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        IQKeyboardManager.shared().keyboardDistanceFromTextField = 30
         
    }
    
    ///birthDateDone...
    @objc func birthDateDone() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateFormat = "MM/yyyy"
        dateOfBrithTxt.text = formatter.string(from: birthDatePicker.date)
        dateOfBrithTxt.resignFirstResponder() // Close the date picker
    }
    
    ///handelSignupBtnAction...
    func handelSignupBtnAction(){
        
        if firstNameTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter first name") }
        else if lastNameTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter last name") }
        else if locationTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter location") }
        else if dateOfBrithTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter date of brith") }
        else if travelExperinceTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter travel experince") }
        else { signUpUserNow(firstName: firstNameTxt.text!, lastName: lastNameTxt.text!, email: user?.email ?? "", gender: genderTxt.text!, city: city, country: country, travelExperience: travelExperinceTxt.text! , password: user?.password ?? "", dob: dateOfBrithTxt.text!) }
    }
    
    ///clearTxt...
    func clearTxt(){
        self.emptyTextField(textFields: [firstNameTxt, lastNameTxt, locationTxt, dateOfBrithTxt, travelExperinceTxt, ])
    }
    
    ///endAllEditingNow...
    func endAllEditingNow(){
        IQKeyboardManager.shared().resignFirstResponder()
        self.view.endEditing(true)
    }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    
    ///signUpBtnAction...
    @IBAction func signUpBtnAction(_ sender: Any) { handelSignupBtnAction() }
    
    ///genderBtnAction...
    @IBAction func genderBtnAction(_ sender: Any) { endAllEditingNow(); genderDropDown.show() }
    
    ///travelExperinceBtnAction...
    @IBAction func travelExperinceBtnAction(_ sender: Any) { endAllEditingNow(); experienceDropDown.show() }
    
    ///locationTxtDidChange...
    @IBAction func locationTxtDidChange(_ sender: TextField) {
        guard let searchText = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        searchPlaceFromGoogle(place: searchText)
    }
    
}

  

//MARK: - Network layer...
extension SignUpDetailsViewController {
    
    ///signupUserNow...
    func signUpUserNow(firstName: String, lastName: String, email: String, gender: String, city: String, country: String, travelExperience: String, password: String, dob: String) {
        self.showRappleActivity()
        Constants.tripSavaServcesManager.signUp(firstName: firstName, lastName: lastName, email: email, gender: gender, city: city, country: country, travelExperience: travelExperience, password: password, dob: dob) { resultent in
            switch resultent {
            case .success(let response): self.hideRappleActivity()
                if response.status == true {
                    appCredentials.isFirstTimeLunch = true; appCredentials.isFirstTimeOpenHome = true
                    appCredentials.isUserLogin = true; appCredentials.accessToken = response.tokens?.accessToken?.token;
                    UserDefaults.standard.save(customObject: response, inKey: Constants.profileModelStr)
                    self.setNewRootViewController(storyboard: "Tabbar", identifier: "TabBarVC")
                }
                else { self.presentAlert(withTitle: "Alert", message: response.message ?? Constants.errorMsg) }
            case .failure(let error): self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: error)
            }
        }
    }
    
    /// getAdddressFromCordinates...
    func searchPlaceFromGoogle(place: String) {
        Constants.tripSavaServcesManager.searchPlaceFromGoogle(place: place) { (Resultent) in
            switch Resultent {
            case .success(let response):
                if response.status == "OK" {
                    self.searchPlaceFromGoogleAllResults = response.results ?? []
                    self.handleSearchPlaceFromGoogle()
                }
                else { self.locationDropDown.hide() }
            case .failure(_): self.locationDropDown.hide()
            }
        }
    }
    
    ///handleSearchPlaceFromGoogle...
    func handleSearchPlaceFromGoogle(){
        addressList.removeAll()
        for result in searchPlaceFromGoogleAllResults {
            if let addressComponents = result.address_components {
                var city: String?; var country: String?
                for component in addressComponents {
                    if let types = component.types {
                        if types.contains("locality") { city = component.long_name ?? component.short_name ?? "" }
                        if types.contains("country") { country = component.long_name ?? component.short_name ?? "" }
                    }
                    if let city = city, let country = country { let cityCountry = "\(city), \(country)"; addressList.append(cityCountry); break }
                }
            }
        };
        
        locationDropDown.dataSource = addressList
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.locationDropDown.reloadAllComponents(); self.locationDropDown.show()
            self.locationDropDown.width = self.locationTxt.frame.width
        }
    }
    
}
