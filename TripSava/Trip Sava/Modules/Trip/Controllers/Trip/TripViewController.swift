//
//  TripViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 08/06/2023.
//

import UIKit
import Lottie

class TripViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var tripTableView: UITableView!
    @IBOutlet weak var addNewBgView: UIView!
    @IBOutlet weak var addNewView: UIView!
    @IBOutlet weak var wellcomeMainView: UIView!
    @IBOutlet weak var tripAnimatedView: LottieAnimationView!
    @IBOutlet weak var welcomeNameLabel: UILabel! 
    @IBOutlet weak var emptyTripView: UIView!
    
    //MARK: - Variables...
    let tripCellIdentifier = "TripTableViewCell"
    let tripHeaderIndentifier = "TripheaderTableViewCell"
    let animationDuration = 0.5
    var isDesignViewVisible = false
    let addNewViewHeight: CGFloat = 250
    var tripsDatasource: [Trip] = []
    
    var allTripsData: [Trip] = []
    var pastTripsData: [Trip] = []
    
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    ///viewWillAppear...
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllTrips(page: 1, limit: 100, searchText: "")
    }
    
    ///viewWillDisappear...
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        updateViewWillDisappear()
    }
    
  
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){ self.updateData(); self.hideAddNewView(); self.setUpCollectionView() }
    
    ///updateData...
    func updateData(){
        self.navigationController?.tabBarController?.tabBar.isHidden = false
        tripAnimatedView.contentMode = .scaleAspectFit
        tripAnimatedView.loopMode = .loop
        tripAnimatedView.animationSpeed = 1
        tripAnimatedView.play()
        //tripTableView.isHidden = true
        if appCredentials.isFirstTimeOpenHome {
            let userProfile = UserDefaults.standard.retrieve(object: SignupModel.self, fromKey: Constants.profileModelStr)?.user
            welcomeNameLabel.text = "Welcome, \((userProfile?.firstName ?? "TripSava") + " " + (userProfile?.lastName ?? ""))!"
            self.wellcomeMainView.isHidden = false; appCredentials.isFirstTimeOpenHome = false }
    }
     
    ///setUpCollectionView...
    func setUpCollectionView() {
        tripTableView.register(UINib(nibName: tripHeaderIndentifier, bundle: nil), forCellReuseIdentifier: tripHeaderIndentifier)
        tripTableView.register(UINib(nibName: tripCellIdentifier, bundle: nil), forCellReuseIdentifier: tripCellIdentifier)
    }
    
    func showAddtripView(){ 
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "AddNewTripViewController") as! AddNewTripViewController
        controller.modalPresentationStyle = .overFullScreen; controller.modalTransitionStyle = .crossDissolve 
        controller.tripAction = { self.pushViewController(storyboard: "Trip", identifier: "WizardStep1ViewController", hidesBottomBarWhenPushed: true) }
        controller.quickListAction = { self.pushViewController(storyboard: "Trip", identifier: "CreateTripQuickListViewController") }
        self.present(controller, animated: true, completion: nil)
    }
    
    
    ///showAddNewView...
    func showAddNewView(){
        UIWindow().bringSubviewToFront(self.addNewBgView)
        UIWindow().bringSubviewToFront(self.addNewView)
        self.addNewBgView.isHidden = false; self.addNewView.isHidden = false
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut) {
            self.addNewBgView.backgroundColor = UIColor.black.withAlphaComponent(0.3); self.addNewView.frame.origin.y = self.view.frame.height - 40 - self.addNewViewHeight
        }
    }
 
    
    ///hideAddNewView...
    func hideAddNewView(){
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut) {
            self.addNewView.frame.origin.y = self.view.frame.height + 40 + self.addNewViewHeight
            self.addNewBgView.backgroundColor = UIColor.black.withAlphaComponent(0)
        } completion: { isComplected in
            self.addNewBgView.isHidden = true; self.addNewView.isHidden = true
        }
    }
    
    ///updateViewWillDisappear...
    func updateViewWillDisappear(){
        self.addNewView.frame.origin.y = self.view.frame.height + 40 + self.addNewViewHeight
        self.addNewBgView.backgroundColor = UIColor.black.withAlphaComponent(0)
        self.addNewBgView.isHidden = true; self.addNewView.isHidden = true
    }
    
    ///GoToDetailsScreen...
    func GoToDetailsScreen(trip: Trip){
        if trip.tripType == "quicklist" { /// quicklist is tap
            let controller = storyboard?.instantiateViewController(withIdentifier: "QuickListDetailsViewController") as! QuickListDetailsViewController
            controller.trip = trip; self.navigationController?.pushViewController(controller, animated: true)
        }
        else { /// Trip is tap
            let controller = storyboard?.instantiateViewController(withIdentifier: "TripWeatherDetailsViewController") as! TripWeatherDetailsViewController
            controller.trip = trip; self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    //MARK: - Actions...
    
    ///newBtnAction...
    @IBAction func newBtnAction(_ sender: Any) { showAddtripView() }
    
    ///closeBtnAction...
    @IBAction func closeBtnAction(_ sender: Any) { hideAddNewView() }
    
    ///newTripBtnAction...
    @IBAction func newTripBtnAction(_ sender: Any) {
        self.pushViewController(storyboard: "Trip", identifier: "WizardStep1ViewController")
    }
    
    ///quickListBtnAction...
    @IBAction func quickListBtnAction(_ sender: Any) {
        self.pushViewController(storyboard: "Trip", identifier: "CreateTripQuickListViewController")
    }
    
    ///searchBtnActions...
    @IBAction func searchBtnActions(_ sender: Any) {
        self.pushViewController(storyboard: "Trip", identifier: "TripSearchViewController")
    }
    
    ///wellcomeBtnAction...
    @IBAction func wellcomeBtnAction(_ sender: Any) { wellcomeMainView.isHidden = true }
    
    
}

//MARK: - TableView delegate and Datasource...
extension TripViewController: UITableViewDelegate, UITableViewDataSource {
    
    ///numberOfSections...
    func numberOfSections(in tableView: UITableView) -> Int { if pastTripsData.isEmpty { return 1 } else { return 2 } }
    
    ///numberOfRowsInSection...
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return allTripsData.count } else { return pastTripsData.count }
    }
    
    ///cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tripCellIdentifier, for: indexPath) as! TripTableViewCell
        if indexPath.section == 0 { 
            cell.data = allTripsData[indexPath.row]
        } else {
            cell.data = pastTripsData[indexPath.row]
        }
        cell.setUpBGView()
        return cell
    }
    
    ///viewForHeaderInSection...
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil } else {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: tripHeaderIndentifier) as! TripheaderTableViewCell
            return headerCell
        }
    }
    
    ///heightForHeaderInSection...
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0 } else { return 44 }
    }
    
    ///estimatedHeightForHeaderInSection...
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {  return 0 } else { return 44 }
    }
    
    ///didSelectRowAt...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 { GoToDetailsScreen(trip: allTripsData[indexPath.row]) }
        else { GoToDetailsScreen(trip: pastTripsData[indexPath.row]) }
    }
    
   
 
    
}


//MARK: - Network layer...
extension TripViewController {
    
    ///getAllTrips...
    func getAllTrips(page: Int, limit: Int, searchText: String){
        self.showRappleActivity(); Constants.tripSavaServcesManager.getAlltrips(page: page, limit: limit, searchText: searchText) { resultent in
            switch resultent {
            case .success(let response): self.hideRappleActivity()
                if response.status == true {  self.tripsDatasource.removeAll(); self.tripsDatasource = response.trips?.results ?? []; self.handletripData()
                } else { self.presentAlert(withTitle: "Alert", message: Constants.errorMsg) }
            case .failure(let error): self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + "\n \(error)")
            }
        }
    }
    
    ///handletripData...
    func handletripData(){
        allTripsData.removeAll(); pastTripsData.removeAll()
        if tripsDatasource.isEmpty { emptyTripView.isHidden = false; tripTableView.isHidden = true }
        else { emptyTripView.isHidden = true; tripTableView.isHidden = false
            tripsDatasource.forEach { trip in
                if trip.status == "completed" { pastTripsData.append(trip) }
                else { allTripsData.append(trip) }
            }
        }
        self.tripTableView.reloadData()
    }
    

    
}
