//
//  AddCubeTasksViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 18/06/2023.
//

import UIKit

class AddCubeTasksViewController: UIViewController {

    //MARK: - IBOutlets...
   
    @IBOutlet weak var tasksTableView: UITableView!
    
    //MARK: - Variables...
    let cellIdentifier = "CubeAddTaskTableViewCell"
    
    
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
        tasksTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    

}


//MARK: - TableView delegate and Datasource...
extension AddCubeTasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    ///numberOfSections...
    func numberOfSections(in tableView: UITableView) -> Int { 2 }
    
    ///numberOfRowsInSection...
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 10 }
    
    ///cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CubeAddTaskTableViewCell
        cell.setUpBGView()
        return cell
    }
}
