//
//  EditProfileViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 19/06/2023.
//

import UIKit
import DropDown
import IQKeyboardManager

class EditProfileViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var addressTxt: TextField!
    @IBOutlet weak var dateofBrithTxt: UITextField!
    @IBOutlet weak var genderTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    
    //MARK: - Variables...
    var city = ""
    var country = ""
    let birthDatePicker = UIDatePicker()
    let genderDropDown = DropDown()
    let locationDropDown = DropDown()
    var searchPlaceFromGoogleAllResults = [GeocodingResult]()
    var addressList: [String] = []
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
    }
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){
        setUpDropDown()
    }
    
    ///updateData...
    func updateData(){
        let userProfile = UserDefaults.standard.retrieve(object: SignupModel.self, fromKey: Constants.profileModelStr)?.user
        country = userProfile?.address?.country ?? ""; city = userProfile?.address?.city ?? ""
        firstNameTxt.text = userProfile?.firstName
        lastNameTxt.text = userProfile?.lastName
        addressTxt.text = "\(userProfile?.address?.city ?? ""), \(userProfile?.address?.country ?? "")"
        dateofBrithTxt.text = userProfile?.dob
        genderTxt.text = userProfile?.gender
        emailTxt.text = userProfile?.email
    
    }
    
    ///setUpDropDown...
    func setUpDropDown() {
        
        IQKeyboardManager.shared().keyboardDistanceFromTextField = 100.0
        locationDropDown.textFont = Constants.applyFonts_DMSans(style: .regular, size: 14)
        locationDropDown.anchorView = addressTxt
        locationDropDown.direction = .bottom
        locationDropDown.backgroundColor = .white
        locationDropDown.textColor = UIColor(hex: "#474847")
        locationDropDown.selectedTextColor = UIColor(hex: "#E26A2B")
        locationDropDown.separatorColor = UIColor(hex: "#CBCBCB", alpha: 0.30)
        locationDropDown.bottomOffset = CGPoint(x: 0, y: addressTxt.frame.height + 6)
        
        locationDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            let data = self?.searchPlaceFromGoogleAllResults[index]
            data?.address_components?.forEach({ address in
                if let types = address.types { if types.contains("country") { self?.country = address.long_name ?? "" } }
                if let types = address.types { if types.contains("locality") { self?.city = address.long_name ?? "" } }
            }); self?.addressTxt.text = item
        }
        
        /// Gender...
        genderDropDown.dataSource = ["   Female","   Male", "   Non Binary", "   Prefer not to say"]
        genderDropDown.textFont = Constants.applyFonts_DMSans(style: .regular, size: 14)
        genderDropDown.anchorView = genderTxt
        genderDropDown.direction = .bottom
        genderDropDown.backgroundColor = .white
        genderDropDown.textColor = UIColor(hex: "#474847")
        genderDropDown.selectedTextColor = UIColor(hex: "#E26A2B")
        genderDropDown.separatorColor = UIColor(hex: "#CBCBCB", alpha: 0.30)
        
        genderDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            self?.genderTxt.text = String(item.dropFirst(3))
        }
          
        /// textfields...
        birthDatePicker.setMaximumAgeInYears(0, textField: dateofBrithTxt, action: #selector(birthDateDone), picker: birthDatePicker)
        
        
    }
    
    @objc func birthDateDone() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateFormat = "MM/yyyy"
        dateofBrithTxt.text = formatter.string(from: birthDatePicker.date)
        dateofBrithTxt.resignFirstResponder() // Close the date picker
    }
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    
    ///saveBtnAction...
    @IBAction func saveBtnAction(_ sender: Any) {
        if firstNameTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter first name") }
        else if lastNameTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter last name") }
        else if addressTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter location") }
        else if dateofBrithTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter date of brith") }
        else if genderTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter travel experince") }
        else { updateProfileNow() }
    }
    
    ///emailEditBtnAction...
    @IBAction func emailEditBtnAction(_ sender: Any) {
        self.pushViewController(storyboard: "Profile", identifier: "ChangeEmailViewController")
    }
    
    ///genderBtnAction...
    @IBAction func genderBtnAction(_ sender: Any) { genderDropDown.show() }
    
    ///addressBtnAction...
    @IBAction func locationTxtDidChange(_ sender: UITextField) {
        guard let searchText = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        searchPlaceFromGoogle(place: searchText)
    }
    
}

//MARK: - Network layer...
extension EditProfileViewController {
    
    ///updateProfileNow...
    func updateProfileNow(){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.updateProfile(firstName: firstNameTxt.text!, lastName: lastNameTxt.text!, dob: dateofBrithTxt.text!, gender: genderTxt.text!, city: city, country: country) { resultent in
            switch resultent {
            case .success(let responseUser):
                if responseUser.status == true {
                    UserDefaults.standard.save(customObject: responseUser, inKey: Constants.profileModelStr); self.updateData()
                    self.presentAlert(withTitle: "Alert", message: responseUser.message ?? "User Updated successfully"); self.hideRappleActivity()
                }
                else { self.presentAlert(withTitle: "Alert", message: responseUser.message ?? Constants.errorMsg); self.hideRappleActivity() }
            case .failure(let error): self.presentAlert(withTitle: "Alert", message: error); self.hideRappleActivity()
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
        print(searchPlaceFromGoogleAllResults)
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
        }; locationDropDown.dataSource = addressList
        
        
        DispatchQueue.main.async {
            self.locationDropDown.reloadAllComponents(); self.locationDropDown.show()
            self.locationDropDown.width = self.addressTxt.frame.width
        }
    }
    
    
    
    
    
}
