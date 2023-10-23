//
//  PrintViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 27/07/2023.
//

import UIKit

class PrintViewController: UIViewController {
    
    //MARK: - IBOutlets...
    @IBOutlet weak var printPackingListtableView: UITableView!
    
    
    //MARK: - Variables...
    let cellIdentifier = "PrintTableViewCell"
    var packingitemsList = ["Passport", "Driver’s license", "Health Certificate", "T-shirts", "Hike boots", "Light sweater"]
    var packingListName = "Summer Holiday 2023"
    var packingMsg = "This is your  packing list for your trip to Paris"
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){ setUpTableView() }
    
    ///setUpTableView...
    func setUpTableView(){
        printPackingListtableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    ///nowCreateAnPDFFileAndShare...
    func nowCreateAnPDFFileAndShare(){
        if let pdfData = generatePDFWithItemsList(itemsList: packingitemsList, projectTitle: packingListName, subHeader: packingMsg) {
            let activityViewController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        }
    }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    
    ///printBtnAction...
    @IBAction func printBtnAction(_ sender: Any) { nowCreateAnPDFFileAndShare() }
    
}

//MARK: - TableView delegate and Datasource...
extension PrintViewController: UITableViewDelegate, UITableViewDataSource {
    
    ///numberOfRowsInSection...
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { packingitemsList.count }
    
    ///cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PrintTableViewCell
        cell.item = packingitemsList[indexPath.item]
        return cell
    }
}
