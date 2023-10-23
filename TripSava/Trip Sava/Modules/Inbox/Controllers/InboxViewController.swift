//
//  InboxViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 17/06/2023.
//

import UIKit

class InboxViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var messageBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var underLineView: UILabel!
    @IBOutlet weak var underLineViewWidthAnchor: NSLayoutConstraint!
    @IBOutlet weak var inbobTableView: UITableView!
    @IBOutlet weak var emptyMsgView: UIView!
    @IBOutlet weak var emptyMsgLabel: UILabel!
    @IBOutlet weak var emptyMsgImageView: UIImageView!
    
    
    //MARK: - Variables...
    let animationSpeed: Double = 0.4
    let cellIdentifier = "InboxTableViewCell"
    
    
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
        inbobTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    
    //MARK: - Actions...
     
    ///messageBtnAction...
    @IBAction func messageBtnAction(_ sender: Any) {
        emptyMsgLabel.text = "We’ll let you know when you have a new message!"
        emptyMsgImageView.image = UIImage(named: "MassegeEmptyImage")
        
        UIView.animate(withDuration: animationSpeed) {
            self.underLineView.center.x = self.messageBtn.center.x;
            self.messageBtn.setTitleColor(UIColor(hex: "#E26A2B"), for: .normal)
            self.notificationBtn.setTitleColor(UIColor(hex: "474847", alpha: 0.60), for: .normal)
        }
    }
    
    ///notificationBtnAction...
    @IBAction func notificationBtnAction(_ sender: Any) {
        emptyMsgLabel.text = "We’ll let you know when you have a new update!"
        emptyMsgImageView.image = UIImage(named: "NotificationEmptyImage")
        UIView.animate(withDuration: animationSpeed) {
            self.underLineView.center.x = self.notificationBtn.center.x
            self.notificationBtn.setTitleColor(UIColor(hex: "#E26A2B"), for: .normal)
            self.messageBtn.setTitleColor(UIColor(hex: "#474847", alpha: 0.60), for: .normal)
        }
    }
    
    
}

//MARK: - TableView delegate and Datasource...
extension InboxViewController: UITableViewDelegate, UITableViewDataSource {
      
    ///numberOfRowsInSection...
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 0 }
    
    ///cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! InboxTableViewCell
        cell.setUpBGView()
        return cell
    }
}
