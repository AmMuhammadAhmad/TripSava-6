//
//  TripWeatherDetailsViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 14/06/2023.
//

import UIKit
import Kingfisher

class TripWeatherDetailsViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    @IBOutlet weak var tripEditView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var editTripBtn: UIButton!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var LeisureImageView: UIImageView!
    @IBOutlet weak var weatherEmptyView: UIView!
    
    @IBOutlet weak var initPackingListView: UIView!
    @IBOutlet weak var packingView: UIView!
    @IBOutlet weak var preparingView: UIView!
    
    @IBOutlet weak var totaoPackItemsLabel: UILabel!
    @IBOutlet weak var packingPriporityLabel: UILabel!
    @IBOutlet weak var packingToBuyLabel: UILabel!
    @IBOutlet weak var packingPackedLabel: UILabel!
    @IBOutlet weak var packingEmptyMsgLabel: UILabel!
    @IBOutlet weak var packingStackView: UIStackView!
    @IBOutlet weak var packingAddItemsBtn: UIButton!
    @IBOutlet weak var packingOptionStackView: UIStackView!
    
    @IBOutlet weak var totaoPreprationItemsLabel: UILabel!
    @IBOutlet weak var preprationAlertLabel: UILabel!
    @IBOutlet weak var preprationPriporityLabel: UILabel!
    @IBOutlet weak var preprationDoneLabel: UILabel!
    @IBOutlet weak var preprationEmptyMsgLabel: UILabel!
    @IBOutlet weak var preparingStackView: UIStackView!
    @IBOutlet weak var preprationAddTaskBtn: UIButton!
    @IBOutlet weak var preprationOptionStackView: UIStackView!
    
    //MARK: - Variables...
    var trip: Trip?;  var weatherListData: [WeatherData] = []; var destinationCardsData: [DestiNationCards] = []
    let cellIdentifier = "tripCurrentWeatherCollectionViewCell"
    var isComingForNewTrip: Bool = false
   
     
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){ 
    
        setUpCollectionView();
        updateData() }
    
    ///updateData..
    func updateData(){
         
        if let tripData = trip { ///update trip data
            addressLabel.text = "\(tripData.location?.city ?? ""), \(tripData.location?.country ?? "")"
            daysLabel.text = self.formatDateWithFromToAndDays(startDateString: tripData.startDate ?? "", endDateString: tripData.endDate ?? "")
            if let postImageUrl = URL(string: tripData.image ?? "") { /// set trip image....
                self.countryImageView.kf.setImage(with: postImageUrl, placeholder: UIImage(named: "IMGplaceholder"))
            }
            
            ///check purpose data....
            if let purpose = tripData.tripStats?.purposes {
                if purpose.contains("Business") && purpose.contains("Leisure") { businessImageView.isHidden = false; LeisureImageView.isHidden = false }
                else if purpose.contains("Business") { businessImageView.isHidden = false; LeisureImageView.isHidden = true }
                else if purpose.contains("Leisure") { businessImageView.isHidden = true; LeisureImageView.isHidden = false  }
            }
            
            ///check user already init packing
            if let activities = tripData.tripStats?.activities, !activities.isEmpty {
                initPackingListView.isHidden = true; packingView.isHidden = false; preparingView.isHidden = false;
                
                if let packing = tripData.itemStats?.packing { ///handle packing list
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
                 
                print(tripData.itemStats?.preparation)
                if let prepration = tripData.itemStats?.preparation { ///handle packing list
                    totaoPreprationItemsLabel.text = "\(prepration.toPrepareTotal ?? 0) tasks"
                    preprationAlertLabel.text = "\(prepration.alert ?? 0)"
                    preprationPriporityLabel.text =  "\(prepration.priority ?? 0)"
                    preprationDoneLabel.text = "\(prepration.completedPercentage ?? 0)%"
                    if (prepration.toPrepareTotal ?? 0) <= 0 {
                        preprationOptionStackView.isHidden = true; preprationAddTaskBtn.setTitle("See all tasks", for: .normal); preprationEmptyMsgLabel.isHidden = false
                    }
                    else {
                        if (prepration.seeMore ?? 0) <= 0 { preprationAddTaskBtn.setTitle("See all tasks", for: .normal)
                            if (prepration.toPrepareList ?? []).count >= 1 { self.addPrePrationList(perpareList: prepration.toPrepareList ?? []) }
                        }
                        else {
                            preprationAddTaskBtn.setTitle("See \(prepration.seeMore ?? 0) more", for: .normal)
                            self.addPrePrationList(perpareList: prepration.toPrepareList ?? [])
                        }
                        preprationOptionStackView.isHidden = false; preprationEmptyMsgLabel.isHidden = true
                    }
                }
            }
            else {
                initPackingListView.isHidden = false; packingView.isHidden = true; preparingView.isHidden = true
                preprationEmptyMsgLabel.isHidden = true; preprationEmptyMsgLabel.isHidden = true
            }
            
            getTripWeather(tripId: tripData.id ?? "")
            
        }
        
        /// Update destinations Cards...
        let city = trip?.location?.city ?? "";
        let country = trip?.location?.country ?? ""
        
        destinationCardsData.append(DestiNationCards(tag: 0, headerMsg: "Basic Information about \(city)", image: "destinationCard0", queryMsg: "Detail Information about \(city), \(country)"))
        destinationCardsData.append(DestiNationCards(tag: 1, headerMsg: "Best Time to Visit \(city), \(country)", image: "destinationCard1", queryMsg: "What are the best times to visit by month including climate starting with january to \(city), \(country)"))
        destinationCardsData.append(DestiNationCards(tag: 2, headerMsg: "Cost of Travel in \(city)", image: "destinationCard2", queryMsg: "Tell me about the cost of travel in the destination of \(city),\(country)"))
        
        destinationCardsData.append(DestiNationCards(tag: 3, headerMsg: "Top Phrases to know when travelling in \(city)", image: "destinationCard3", queryMsg: "What is the main language and top 25 travel phrases with phonetic pronunciation sorted by topic and in bullets for tourists visiting \(city),\(country)"))
        
        destinationCardsData.append(DestiNationCards(tag: 4, headerMsg: "Customs & Cultural Considerations in \(city)", image: "destinationCard1", queryMsg: "What are the local customs and dress requirements as a tourist traveling to \(city),\(country)"))
        
        destinationCardsData.append(DestiNationCards(tag: 5, headerMsg: "Top Scams in \(city)", image: "destinationCard5", queryMsg: "As a tourist tell me about any tourist scams I should be aware of in \(city),\(country)"))
        
        destinationCardsData.append(DestiNationCards(tag: 6, headerMsg: "Products & Services for Your Travel", image: "destinationCard6", queryMsg: "Products & Services for Your Travel in \(city),\(country)"))
        
        destinationCardsData.append(DestiNationCards(tag: 7, headerMsg: "Tax Refund for Travelers", image: "destinationCard7", queryMsg: "Tax Refund for Travelers in \(city),\(country)"))
        
        destinationCardsData.append(DestiNationCards(tag: 8, headerMsg: "Health and Safety Recommendations in \(city)", image: "destinationCard8", queryMsg: "Health and safety guidelines removing COVID information when traveling to \(city),\(country)"))
        
        destinationCardsData.append(DestiNationCards(tag: 9, headerMsg: "Tipping Suggestions in \(city)", image: "destinationCard9", queryMsg: "How much should I tip for Restaurants, bars/pubs, coffee shop, Taxi, Tour Guide, Concierge/Porter, Housekeeper in \(city), \(country)"))
        
    }
    
    ///addPerpareList..
    func addPrePrationList(perpareList: [String]){
        perpareList.forEach { name in
            let nameLabel: UILabel = {
                let label = UILabel()
                label.setUpLabel(text: name, font: Constants.applyFonts_DMSans(style: .regular, size: 12), textAlignment: .left, textColor: UIColor(red: 0.28, green: 0.283, blue: 0.279, alpha: 0.8), numberOfLines: 0, textBGcolor: .clear)
                return label
            }()
            
            if perpareList.count < 7 { nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true }
            else { preparingStackView.distribution = .fillEqually }
            preparingStackView.addArrangedSubview(nameLabel)
        }
        
        if perpareList.count < 8 { preparingStackView.addArrangedSubview(UIView()) }
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
    
    ///setUpCollectionView...
    func setUpCollectionView(){
        weatherCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    ///handleScamsBtnAction...
    func handleScamsBtnAction(tag: Int){
        if tag == 0 {
            let controller = storyboard?.instantiateViewController(withIdentifier: "BasicInfoViewController") as! BasicInfoViewController
            if let trip = trip { controller.tripLocation = trip.location; controller.trip = trip }
            self.navigationController?.pushViewController(controller, animated: true)
        }
        else {
            let card = destinationCardsData[tag]
            let controller = storyboard?.instantiateViewController(withIdentifier: "ScamViewViewController") as! ScamViewViewController
            controller.destiNationCards = card; self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    ///handleCreatePackingBtAction...
    func handleCreatePackingBtAction(){
        let storyboard = UIStoryboard(name: "Trip", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "StartPackingViewController") as! StartPackingViewController
        controller.trip = trip; self.navigationController?.pushViewController(controller, animated: true)
    }
    
    ///handleDeletetripBtnAction..
    func handleDeletetripBtnAction(){
        if let trip = trip { deleteTripNow(tripId: trip.id ?? "") }
        else { self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " -> Trip not found") }
        
    }
    
    ///handleEditTrip...
    func handleEditTrip(){
        let storyboard = UIStoryboard(name: "Trip", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "WizardStep1ViewController") as! WizardStep1ViewController
        controller.isCommingForTripUpdate = true; controller.trip = trip; controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    ///handleSuccessResponse...
    func handleSuccessResponse(){
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PackingListVC") as! PackingListVC
        controller.trip = trip; self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popToRootViewController() }
    
    ///createPackingWizardBtnAction...
    @IBAction func createPackingWizardBtnAction(_ sender: Any) { handleCreatePackingBtAction() }
    
    ///scamsBtnAction...
    @IBAction func scamsBtnAction(_ sender: UIButton) { handleScamsBtnAction(tag: sender.tag) }
    
    ///hideTripEditBtnAction...
    @IBAction func hideTripEditBtnAction(_ sender: Any) { self.tripEditView.isHidden = true }
    
    ///editTripBtnAction...
    @IBAction func editTripBtnAction(_ sender: Any) { self.tripEditView.isHidden.toggle() }
    
    ///packingAddOrShowItemsBtnAction...
    @IBAction func packingAddOrShowItemsBtnAction(_ sender: Any) { handleSuccessResponse() }
    
    ///preprationAddOrShowTaskBtnAction...
    @IBAction func preprationAddOrShowTaskBtnAction(_ sender: Any) { handleSuccessResponse() }
    
    ///deleteTripBtnAction...
    @IBAction func deleteTripBtnAction(_ sender: Any) { handleDeletetripBtnAction() }
    
    ///editThisTripBtnAction...
    @IBAction func editThisTripBtnAction(_ sender: Any) { handleEditTrip() }
    
    
}

//MARK: - CollectionView Delegate & DataSource ...
extension TripWeatherDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    ///numberOfItemsInSection...
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return weatherListData.count }
    
    ///cellForItemAt...
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! tripCurrentWeatherCollectionViewCell
        cell.data = weatherListData[indexPath.item]
        return cell
    }
    
    ///sizeForItemAt...
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let data = weatherListData[indexPath.item]; var updatedWidth: CGFloat = 65
        let estimatedWidth = estimatedTextWidth(for: data.location?.name ?? "", font: Constants.applyFonts_DMSans(style: .Medium, size: 11), width: collectionView.frame.width)
        if estimatedWidth > 65 { updatedWidth = estimatedWidth }
        return CGSize(width: updatedWidth, height: collectionView.frame.height)
    }
    
    ///didSelectItemAt...
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Trip", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TripCurrentWeatherViewController") as! TripCurrentWeatherViewController
        controller.trip = trip; controller.weatherListData = weatherListData
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
}

//MARK: - Network layer...
extension TripWeatherDetailsViewController {
    
    ///getTripWeather...
    func getTripWeather(tripId: String) {
        self.showRappleActivity()
        Constants.tripSavaServcesManager.getTripWeather(tripId: tripId) { resultent in
            switch resultent {
            case .success(let response): self.hideRappleActivity()
                if response.status == true {
                    self.weatherListData = response.weatherList ?? []; self.weatherCollectionView.reloadData()
                    if self.weatherListData.isEmpty { self.weatherEmptyView.isHidden = false } else { self.weatherEmptyView.isHidden = true }
                } else { self.weatherEmptyView.isHidden = false }
            case .failure(_): self.hideRappleActivity(); self.weatherEmptyView.isHidden = false
            }
        }
    }
    
    ///deleteTripNow..
    func deleteTripNow(tripId: String){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.deleteTrip(tripId: tripId) { resultent in
            switch resultent {
            case .success(_): self.hideRappleActivity(); self.presentAlertAndBackToRootView(withTitle: "Alert", message: "Trip delete successfully", controller: self)
            case .failure(let error): self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " -> \(error)")
            }
        }
    }
    
    
}

