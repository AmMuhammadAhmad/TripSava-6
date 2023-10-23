//
//  EmbassiesDetailsViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 03/08/2023.
//

import UIKit

class EmbassiesDetailsViewController: UIViewController {
    
    
    //MARK: - IBOutlets...
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerDetailLabel: UILabel!
    @IBOutlet weak var libraryOptionLabel1: UILabel!
    @IBOutlet weak var libraryOptionLabel2: UILabel!
    @IBOutlet weak var libraryOptionLabel3: UILabel!
    @IBOutlet weak var libraryOptionLabel4: UILabel!
    @IBOutlet weak var libraryOptionBarLabel1: UILabel!
    @IBOutlet weak var libraryOptionBarLabel2: UILabel!
    @IBOutlet weak var libraryOptionBarLabel3: UILabel!
    @IBOutlet weak var libraryOptionBarLabel4: UILabel!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var viewWebsiteBtn: UIButton!
    
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var embassiesTab: UIStackView!
    @IBOutlet weak var consulateTab: UIStackView!
    @IBOutlet weak var missionTab: UIStackView!
    @IBOutlet weak var officesTab: UIStackView!
    
    @IBOutlet weak var libraryOption1: UIButton!
    @IBOutlet weak var libraryOption2: UIButton!
    @IBOutlet weak var libraryOption3: UIButton!
    @IBOutlet weak var libraryOption4: UIButton!
    
    //MARK: - Variables...
    var libraryOptionsLabels: [UILabel] = []
    var libraryOptionsBarLabels: [UILabel] = []
    
    var allEmbassies: [Embassies] = []
    var embassiesList: [Embassies] = []
    var consultantList: [Embassies] = []
    var missionList: [Embassies] = []
    var officesList: [Embassies] = []
    var sourceCountry: Countries?
    var destinationCountry: Countries?
    var stackViewSeprater = "\n-------------\n"
    var libraryBtns: [UIButton] = []
    
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){ updateData(); getSelectedCountryEmbassiesDetails(sourceCountry: sourceCountry?.code ?? "", destinationCountry: destinationCountry?.code ?? "") }
    
    ///updateData..
    func updateData(){
        let countryTxt = "Embassies & Consulates in \(destinationCountry?.name ?? "...")"
        headerDetailLabel.text = countryTxt
        libraryOptionsLabels = [libraryOptionLabel1, libraryOptionLabel2, libraryOptionLabel3, libraryOptionLabel4]
        libraryOptionsBarLabels = [libraryOptionBarLabel1, libraryOptionBarLabel2, libraryOptionBarLabel3, libraryOptionBarLabel4]
        libraryBtns = [libraryOption1, libraryOption2, libraryOption3, libraryOption4]
    }
    
    ///updateLibraryOptionsBtn...
    func updateLibraryOptionsBtn(tag: Int) {
        libraryOptionsLabels.forEach { lbl in
            if lbl.tag == tag { lbl.textColor = UIColor(hex: "#E26A2B") } else { lbl.textColor = UIColor(hex: "#808080") }
        }
        libraryOptionsBarLabels.forEach { lbl in
            if lbl.tag == tag { lbl.isHidden = false } else { lbl.isHidden = true }
        }
        updateTabBarData(tag: tag)
    }
    
    func updateTabBarData(tag: Int){
        ///hide the tab if empty...
        mainStackView.removeFullyAllArrangedSubviews()
        if tag == 1  { updateEmbassiesTabData(embassies: embassiesList, nextLineText: stackViewSeprater) }
        if tag == 2 { updateEmbassiesTabData(embassies: consultantList, nextLineText: stackViewSeprater) }
        if tag == 3  { updateEmbassiesTabData(embassies: missionList, nextLineText: stackViewSeprater) }
        if tag == 4 { updateEmbassiesTabData(embassies: officesList, nextLineText: stackViewSeprater) }
    }
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    
    @IBAction func libraryOptionBtnActions(_ sender: UIButton) { self.updateLibraryOptionsBtn(tag: sender.tag) }
    
    ///viewWebsiteBtnAction...
    @IBAction func viewWebsiteBtnAction(_ sender: Any) {
        
    }
    
}

//MARK: - Network layer...
extension EmbassiesDetailsViewController {
    
    ///getSelectedCountryEmbassiesDetails..
    func getSelectedCountryEmbassiesDetails(sourceCountry: String, destinationCountry: String){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.getSelectedCountryEmbassiesDetails(sourceCountry: sourceCountry, destinationCountry: destinationCountry) { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true { self.allEmbassies = response.data?.embassies ?? []; self.handleSuccessResponse() }
                else { self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: Constants.errorMsg) }
                self.hideRappleActivity()
            case .failure(let error): self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: error)
            }
        }
    }
    
    ///handleSuccessResponse...
    fileprivate func handleSuccessResponse(){
        
        
        
        ///filter the data into each list speratly...
        allEmbassies.forEach { embassy in
            if embassy.locationType == Constants.EmbassiesData.embassy { embassiesList.append(embassy) }
            if embassy.locationType == Constants.EmbassiesData.consultant { consultantList.append(embassy) }
            if embassy.locationType == Constants.EmbassiesData.mission { missionList.append(embassy) }
            if embassy.locationType == Constants.EmbassiesData.office { officesList.append(embassy) }
        }
        
        ///hide the tab if empty...
        if officesList.isEmpty {officesTab.isHidden = true; libraryBtns[3].isHidden = true } else { updateLibraryOptionsBtn(tag: 4) }
        if missionList.isEmpty {missionTab.isHidden = true;  libraryBtns[2].isHidden = true } else { updateLibraryOptionsBtn(tag: 3) }
        if consultantList.isEmpty {consulateTab.isHidden = true;  libraryBtns[1].isHidden = true } else { updateLibraryOptionsBtn(tag: 2) }
        if embassiesList.isEmpty {embassiesTab.isHidden = true;  libraryBtns[0].isHidden = true } else { updateLibraryOptionsBtn(tag: 1) }
        
    }
    
    
    ///updateEmbassiesTabData...
    func updateEmbassiesTabData(embassies: [Embassies], nextLineText: String){
        var embassiesCounter = embassies.count
        headerStackView.isHidden = false
        mainStackView.removeFullyAllArrangedSubviews()
        
        embassies.forEach { embassy in
            
            ///update address data...
            if let address = embassy.address, !address.isEmpty {
                let locationView = EmbassiesDetailsCustomView()
                locationView.setUpViews(icon: UIImage(named: "EmbassiesLocation"), workingHours: [address], tag: 0)
                mainStackView.addArrangedSubview(locationView); addEmptyView()
            }
            
            ///Contacts...
            if let contacts = embassy.phoneNumbers, !contacts.isEmpty {
                let contactsView = EmbassiesDetailsCustomView()
                contactsView.setUpViews(icon: UIImage(named: "EmbassiesLCall"), workingHours: contacts, tag: 1)
                mainStackView.addArrangedSubview(contactsView); addEmptyView()
            }
            
            ///Emails...
            if let emails = embassy.emails, !emails.isEmpty {
                let emailsView = EmbassiesDetailsCustomView()
                emailsView.setUpViews(icon: UIImage(named: "EmbassiesLMail"), workingHours: emails, tag: 2)
                mainStackView.addArrangedSubview(emailsView); addEmptyView()
            }
            
            
            /// Hours...
            if let hours = embassy.hours, !hours.isEmpty {
                let hoursView = EmbassiesDetailsCustomView()
                hoursView.setUpViews(icon: UIImage(named: "EmbassiesLClock"), workingHours: hours, tag: 3)
                mainStackView.addArrangedSubview(hoursView); addEmptyView()
            }
            
            
            ///linkView...
            if let webLink = embassy.websiteUrl, webLink != "" {
                addEmptyView()
                
                let stackView = UIStackView()
                stackView.axis = .horizontal
                stackView.alignment = .leading
                stackView.distribution = .fill
                
                let view1 = UIView()
                view1.backgroundColor = UIColor.clear
                view1.widthAnchor.constraint(equalToConstant: 5).isActive = true
                
                let button = UIButton(type: .custom)
                button.setTitle("Visit Website", for: .normal)
                
                button.translatesAutoresizingMaskIntoConstraints = false
                button.frame = CGRect(x: 0, y: 0, width: 125, height: 40)
                button.widthAnchor.constraint(equalToConstant: 125).isActive = true
                button.heightAnchor.constraint(equalToConstant: 40).isActive = true
              
                button.cornerRadius = 8
                button.backgroundColor = UIColor(hex: "#003681")
                button.setTitleColor(UIColor.white, for: .normal)

                button.titleLabel?.font = UIFont(name: "DMSans-Regular", size: 14)
                
                button.clipsToBounds = true
                button.addAction(UIAction{_ in
                    if let url = URL(string: "\(webLink)") {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
                                print("Cannot open URL")
                            }
                        }
                }, for: .touchUpInside)
                
                stackView.addArrangedSubview(view1)
                stackView.addArrangedSubview(button)
                mainStackView.addArrangedSubview(stackView); addEmptyView()
                
//                let linkView = EmbassiesDetailsCustomView()
//                linkView.setUpViews(icon: UIImage(named: "link"), workingHours: [webLink], tag: 4)
//                mainStackView.addArrangedSubview(linkView); addEmptyView()
            }
            
            
            embassiesCounter = embassiesCounter - 1
            ///Enter Second Value
            if embassiesCounter >= 1 {
                let emptyView = EmbassiesDetailsCustomView()
                emptyView.setUpViews(icon: UIImage(named: ""), workingHours: [nextLineText], tag: 5)
                mainStackView.addArrangedSubview(emptyView)
            }
            
        }
    }
    
    ///addEmptyView...
    func addEmptyView(){
        let emptyView = EmbassiesDetailsCustomView()
        emptyView.setUpViews(icon: UIImage(named: ""), workingHours: [""], tag: 5)
        mainStackView.addArrangedSubview(emptyView)
    }
    
    
}

