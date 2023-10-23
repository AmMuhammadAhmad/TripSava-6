//
//  BasicInfoViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 15/10/2023.
//

import UIKit
import Alamofire
import RappleProgressHUD

class BasicInfoViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var titleLbl:UILabel!
    @IBOutlet weak var languagesLbl:UILabel!
    @IBOutlet weak var currencyLbl:UILabel!
    @IBOutlet weak var drivingSideLbl:UILabel!
    @IBOutlet weak var emergencyContactLbl:UILabel!
    @IBOutlet weak var countryCodeLbl:UILabel!
    @IBOutlet weak var waterQualityLbl:UILabel!
    @IBOutlet weak var powerTypeLbl:UILabel!
    @IBOutlet weak var powerCollectionView:UICollectionView!

    @IBOutlet weak var poloceNumberLabel: UILabel!
    @IBOutlet weak var ambulanceNumberLabel: UILabel!
    @IBOutlet weak var fireNumberLabel: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var emergencyNumberView: UIView!
    
    @IBOutlet weak var languageSpokenView: UIView!
    @IBOutlet weak var languaheHeader: UILabel!
    @IBOutlet weak var labguageStackView: UIStackView!
    
    
    //MARK: - Variables...
    var tripLocation: TripLocation?; var trip: Trip?; var UvData: [UvInfo] = []
    var powerAdapters = [String]()
    var handleUvData: [String] = []
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        
        print("Country name is: \(tripLocation?.country ?? "")")
        getBasicInfo()
    }
    
 
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){
        titleLbl.text = "Basic Information about \(tripLocation?.country ?? "")"
        powerCollectionView.dataSource = self
        powerCollectionView.delegate = self
         
    
    }
    
    func setupBasicInfoData(basicInfo:BasicInfo?){
        let array = basicInfo?.destination.languages ?? ["English"]
        let commaSeparatedString = array.joined(separator: ", ")
        self.languagesLbl.text = commaSeparatedString
        
        self.currencyLbl.text = "\(basicInfo?.destination.currency.name ?? "USD") (\(basicInfo?.destination.currency.symbol ?? "$"))"
        
        let drivingReq = basicInfo?.destination.drivingRequirements ?? "RHT"
        
        if drivingReq == "RHT"{
            self.drivingSideLbl.text = "Right"
        }else{
            self.drivingSideLbl.text = "Left"
        }
        
        self.countryCodeLbl.text = "+\(basicInfo?.destination.country.countryCode ?? "1")"
        print(basicInfo?.destination.currency ?? "")
        
        let waterQuality = basicInfo?.destination.hasWaterSafety ?? true
        if waterQuality == true{
            self.waterQualityLbl.text = "Safe to drink"
        }else{
            self.waterQualityLbl.text = "Not safe to drink"
        }
        
        self.powerTypeLbl.text = "Voltage: \(basicInfo?.destination.electricPower.voltage ?? "220 V") · \(basicInfo?.destination.electricPower.frequency ?? "50 Hz")"
        self.powerAdapters = basicInfo?.destination.electricPower.powerAdapters ?? [String]()
        
        //Edit here...
        if let emergencyInfoo = basicInfo?.destination.emergencyInfo {
            poloceNumberLabel.text = "15"; ambulanceNumberLabel.text = "15"; fireNumberLabel.text = "15"
        }
        
        /// Languages setup here....
        let language = basicInfo?.destination.languages ?? ["English"]
        let languagesPerRow = 3; var currentRowStackView: UIStackView?
        
        for (index, language) in language.enumerated() {
            if index % languagesPerRow == 0 {
                currentRowStackView = UIStackView()
                currentRowStackView?.axis = .horizontal; currentRowStackView?.distribution = .fillEqually
                currentRowStackView?.alignment = .leading; currentRowStackView?.spacing = 6
                labguageStackView.addArrangedSubview(currentRowStackView!)
            }
            let languageLabel = UILabel();
            languageLabel.text = language; languageLabel.textAlignment = .left; languageLabel.font = Constants.applyFonts_DMSans(style: .regular, size: 14)
            languageLabel.backgroundColor = UIColor.clear; currentRowStackView?.addArrangedSubview(languageLabel)
        }
        labguageStackView.addArrangedSubview(UIView()) /// add for remove end spac...
           
        self.powerCollectionView.reloadData(); self.powerCollectionView.layoutIfNeeded(); self.hideRappleActivity();
    }
    
     
    
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    
    ///languageSpokenCloseBtnAction...
    @IBAction func languageSpokenCloseBtnAction(_ sender: Any) {
        self.bottomView.isHidden = true; self.languageSpokenView.isHidden = true
    }
    
    ///emergencyContactCloseBtnAction...
    @IBAction func emergencyContactCloseBtnAction(_ sender: Any) {
        self.bottomView.isHidden = true; emergencyNumberView.isHidden = true
    }
    
    @IBAction func showlanguageView(_ sender: Any) {
        self.bottomView.isHidden = false; self.languageSpokenView.isHidden = false
    }
    
    
    @IBAction func showEmergencyView(_ sender: Any) {
        self.bottomView.isHidden = false; emergencyNumberView.isHidden = false
    }
    
    
}

//MARK: - CollectionView Delegate & DataSource ...
extension BasicInfoViewController:UICollectionViewDataSource,UICollectionViewDelegate {
    
    ///numberOfItemsInSection..
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return powerAdapters.count }
    
    ///cellForItemAt..
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PowerAdapterCell", for: indexPath) as! PowerAdapterCell
        cell.imgName = powerAdapters[indexPath.row].uppercased(); cell.initCell()
        return cell
    }
    
}


//MARK: - Network layer...
extension BasicInfoViewController {
    
    ///getBasicInfo...
    func getBasicInfo(){
        showRappleActivity()
        let baseURL = "https://trip-sawa-api-22bb4f708068.herokuapp.com/v1/"
        let apiUrl = baseURL + "destination-info/query?country=\(tripLocation?.country ?? "India")"
        Alamofire.request(apiUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    if json == nil{ self.hideRappleActivity(); return }
                    let basicInfo = try? JSONDecoder().decode(BasicInfo.self, from: data)
                    self.setupBasicInfoData(basicInfo: basicInfo)
                }
                catch{ self.hideRappleActivity() }
            case .failure(_): self.hideRappleActivity()
            }
        }
    }
    
}


