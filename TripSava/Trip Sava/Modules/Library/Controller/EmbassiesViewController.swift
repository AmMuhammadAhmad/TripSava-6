//
//  EmbassiesViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 01/08/2023.
//

import UIKit
import DropDown
import IQKeyboardManager
import Kingfisher

class EmbassiesViewController: UIViewController {
    
    //MARK: - IBOutlets...
    @IBOutlet weak var searchEmptyView: UIView!
    @IBOutlet weak var countryTableView: UITableView!
    @IBOutlet weak var dropDownCountryView: UIView!
    @IBOutlet weak var dropDownCountryLabel: UILabel!
    @IBOutlet weak var dropDownCountryFlagImageView: UIImageView!
    @IBOutlet weak var searchTextField: TextField!
    
    //MARK: - Variables...
    let cellIdentifier = "EmbassiesTableViewCell"
    var originalDatasource: [Countries] = []
    var datasource: [Countries] = []
    var groupedCountries: [String: [Countries]] = [:]
    var sectionTitles: [String] = []
    var originalSections: [String] = []
    var isSearching = false
    let locationDropDown = DropDown()
    var countries: [Countries] = []
    var dropDownCountries: [String] = []
    var tableviewCountries: [Countries] = []
    var selectedSourceCountry: Countries?
    
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){ setUpTableView(); setUpDropDown(); getDropDownCountries() }
    
    
    ///setUpTableView...
    func setUpTableView(){
        countryTableView.addPullToRefresh(target: self, action: #selector(refreshCollectionView))
        countryTableView.setupTiTleIndex(color: UIColor(hex: "#003681"), font: Constants.applyFonts_DMSans(style: .Medium, size: 12))
        countryTableView.register(EmbassiesHeaderView.self, forHeaderFooterViewReuseIdentifier: EmbassiesHeaderView.reuseIdentifier)
        countryTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    ///refreshCollectionView...
    @objc private func refreshCollectionView() {
        self.getDropDownCountries(); DispatchQueue.main.async { self.countryTableView.endPullToRefresh() }
    }
    
    ///prepareData...
    func prepareData() {
        datasource.sort { $0.name ?? "" < $1.name ?? "" }
        groupedCountries = Dictionary(grouping: datasource) { String($0.name!.prefix(1)) }
        sectionTitles = groupedCountries.keys.sorted()
        originalSections = sectionTitles
        DispatchQueue.main.async { self.countryTableView.reloadData() }
    }
    
    ///setUpDropDown..
    func setUpDropDown(){
        IQKeyboardManager.shared().keyboardDistanceFromTextField = 100.0
        locationDropDown.textFont = Constants.applyFonts_DMSans(style: .regular, size: 14)
        locationDropDown.anchorView = dropDownCountryView
        locationDropDown.direction = .bottom
        locationDropDown.backgroundColor = .white
        locationDropDown.textColor = UIColor(hex: "#474847")
        locationDropDown.selectedTextColor = UIColor(hex: "#E26A2B")
        locationDropDown.separatorColor = UIColor(hex: "#CBCBCB", alpha: 0.30)
        locationDropDown.bottomOffset = CGPoint(x: 0, y: dropDownCountryView.frame.height + 6)
        searchTextField.addClearButtonWithExpandedSize(expandedWidth: 20, expandedHeight: 40)
        
        locationDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            self?.dropDownCountryLabel.text = item
            guard let country = self?.countries[index] else { return }
            self?.selectedSourceCountry = country
            if let flagImageUrl = URL(string: country.flag ?? "") {
                DispatchQueue.main.async { self?.dropDownCountryFlagImageView.kf.setImage(with: flagImageUrl, placeholder: UIImage(named: "IMGplaceholder")) }
            }
            if let countryCode = country.code { self?.getCountryEmbassy(countryCode: countryCode) }
        }
        
    }
     
    
    ///handleSearchBtnAction...
    func handleSearchBtnAction(sender: UISearchBar) {
        if sender.text?.isEmpty == false {
            isSearching = true; let searchText = sender.text!.lowercased()
            datasource = originalDatasource.filter { $0.name!.lowercased().contains(searchText) }
            
            groupedCountries = Dictionary(grouping: datasource) { String($0.name!.prefix(1)) }
            if !groupedCountries.isEmpty { sectionTitles = sectionTitles.filter { sectionTitle in  return groupedCountries[sectionTitle]?.isEmpty == false } }
            
        } else {
            isSearching = false; datasource = originalDatasource
            groupedCountries = Dictionary(grouping: datasource) { String($0.name!.prefix(1)) }
            sectionTitles = originalSections
        }
        
        if groupedCountries.isEmpty { searchEmptyView.isHidden = false } else { searchEmptyView.isHidden = true }
        self.countryTableView.reloadData()
    }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    
    ///selectCountryBtnAction...
    @IBAction func selectCountryBtnAction(_ sender: Any) { self.locationDropDown.show() }
    
    ///searchTxtEditingChangesAction..
    @IBAction func searchTxtEditingChangesAction(_ sender: UISearchBar) { handleSearchBtnAction(sender: sender) }
     
}


////MARK: - TableView delegate and Datasource...
extension EmbassiesViewController: UITableViewDelegate, UITableViewDataSource {
    
    ///numberOfSections...
    func numberOfSections(in tableView: UITableView) -> Int { return sectionTitles.count }
    
    ///numberOfRowsInSection...
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let country = sectionTitles[section]; return groupedCountries[country]?.count ?? 0
    }
    
    ///cellForRowAt...
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EmbassiesTableViewCell
        let country = sectionTitles[indexPath.section]; cell.setUpBGView()
        if let embassies = groupedCountries[country] { let embassy = embassies[indexPath.row]; cell.data = embassy }
        return cell
    }
    
    ///viewForHeaderInSection...
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: EmbassiesHeaderView.reuseIdentifier) as? EmbassiesHeaderView
        headerView?.headerText = sectionTitles[section]
        return headerView
    }
    
    ///sectionIndexTitles...
    func sectionIndexTitles(for tableView: UITableView) -> [String]? { return sectionTitles }
    
    ///heightForHeaderInSection...
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 30 }
    
    ///didSelectRowAt...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Library", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EmbassiesDetailsViewController") as! EmbassiesDetailsViewController
        controller.sourceCountry = selectedSourceCountry
        let country = sectionTitles[indexPath.section]
        if let embassies = groupedCountries[country] { let embassy = embassies[indexPath.row]; controller.destinationCountry = embassy }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}


//MARK: - Network layer...
extension EmbassiesViewController {
    
    ///getDropDownCountries..
    func getDropDownCountries(){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.getCountries { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true {
                    self.countries = []; self.countries = response.countries ?? []; self.handlegCountriesDropDownData()
                }
                else { self.presentAlert(withTitle: "Alert", message: "Countries are not available") }
                self.hideRappleActivity()
                
            case .failure(_):
                self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: "Countries are not available")
                
            }
        }
    }
    
    ///handlegCountriesDropDownData...
    func handlegCountriesDropDownData(){
        
        //get all countries...
        dropDownCountries = []
        countries.removeAll { country in
            if country.code == "US" { return false } else { return true }
        }
        countries.forEach { country in  dropDownCountries.append(country.name ?? "")  }
        
        ///update dropDown Data...
        if let firstCountry = countries.first { 
            selectedSourceCountry = firstCountry
            self.dropDownCountryLabel.text = firstCountry.name
            if let flagImageUrl = URL(string: firstCountry.flag ?? "") {
                DispatchQueue.main.async {
                    self.dropDownCountryFlagImageView.kf.setImage(with: flagImageUrl, placeholder: UIImage(named: "IMGplaceholder"))
                }
                if let countryCode = firstCountry.code { self.getCountryEmbassy(countryCode: countryCode) }
            }
        }
        if countries.count >= 2 { locationDropDown.dataSource = dropDownCountries; locationDropDown.reloadAllComponents() }
        
    }
    
    ///getCountryEmbassy...
    func getCountryEmbassy(countryCode: String){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.getCountryEmbassy(countryCode: countryCode) { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true {
                    self.tableviewCountries = []; self.originalDatasource = []; self.datasource = []
                    self.tableviewCountries = response.countries ?? []; self.hideRappleActivity();
                    self.originalDatasource = self.tableviewCountries; self.datasource = self.tableviewCountries
                    self.prepareData()
                } else { self.presentAlert(withTitle: "Alert", message: "Embassy Countries are not available") }
            case .failure(_):
                self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: "Embassy Countries are not available")
            }
        }
    }
    
}


