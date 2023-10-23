//
//  TripSearchViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 16/06/2023.
//

import UIKit

class TripSearchViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var emptyTripView: UIView!
    @IBOutlet weak var suggestionStackView:UIStackView!
    @IBOutlet weak var suggestionLbl:UILabel!
    //MARK: - Variables...
    let tripCellIdentifier = "TripSearchTableViewCell"
    var tripsDatasource: [Trip] = []
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){ setUpTableViewCell() }
    
    ///setUpTableViewCell...
    func setUpTableViewCell(){
        searchTableView.register(UINib(nibName: tripCellIdentifier, bundle: nil), forCellReuseIdentifier: tripCellIdentifier)
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
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    
    ///textFiledDidChangeText..
    @IBAction func textFiledDidChangeText(_ sender: TextField) {
        guard let text = sender.text else {
            print("1")
            suggestionStackView.isHidden = false
            suggestionLbl.text = "Suggestions"
            searchTableView.isHidden = true
            emptyTripView.isHidden = true
            return
        }
        if text.count == 0{
            print("2")
            suggestionStackView.isHidden = false
            suggestionLbl.text = "Suggestions"
            searchTableView.isHidden = true
            emptyTripView.isHidden = true
            return
            
        }else{
            print("3")
            suggestionStackView.isHidden = true
            suggestionLbl.text = "Search Results"
            searchTableView.isHidden = true
            emptyTripView.isHidden = true
        }
        
        getAllTrips(page: 0, limit: 100, searchText: text)
    }
    
    
}

//MARK: - TableView delegate and Datasource...
extension TripSearchViewController: UITableViewDelegate, UITableViewDataSource {
      
    ///numberOfRowsInSection...
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return tripsDatasource.count }
    
    ///cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tripCellIdentifier, for: indexPath) as! TripSearchTableViewCell
        cell.data = tripsDatasource[indexPath.row]; cell.setUpBGView()
        return cell
    }
    
    ///didSelectRowAt..
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        GoToDetailsScreen(trip: tripsDatasource[indexPath.row])
    }
}


//MARK: - Network layer...
extension TripSearchViewController {
    
    ///getAllTrips...
    func getAllTrips(page: Int, limit: Int, searchText: String){
        print("Calling for Query: \(searchText)")
        Constants.tripSavaServcesManager.getAlltrips(page: page, limit: limit, searchText: searchText) { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true { 
                    self.tripsDatasource.removeAll();
                    self.tripsDatasource = response.trips?.results ?? [];
                    self.handletripData(searchText: searchText)
                } else { self.tripsDatasource.removeAll(); self.handletripData(searchText: searchText) }
            case .failure(_): self.tripsDatasource.removeAll(); self.handletripData(searchText: searchText)
            }
        }
    }
    
    ///handletripData...
    func handletripData(searchText:String) {
        if searchText.count == 0{
            suggestionStackView.isHidden = false
            suggestionLbl.text = "Suggestions"
            searchTableView.isHidden = true
            emptyTripView.isHidden = true
            return
        }
        if tripsDatasource.isEmpty {
            print("4")
            emptyTripView.isHidden = false;
            searchTableView.isHidden = true
            suggestionLbl.text = "Search Results"
            suggestionStackView.isHidden = true
        }else {
            print("5")
            emptyTripView.isHidden = true;
            searchTableView.isHidden = false;
            self.searchTableView.reloadData()
        }
    }
    

    
}
