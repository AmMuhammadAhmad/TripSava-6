//
//  AlertViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 25/07/2023.
//

import UIKit

 
class AlertViewController: UIViewController {

    //MARK: - IBOutlets...
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    //MARK: - Variables...
    var firstBtnTitle = ""
    var secondBtntext = ""
    var message = ""
    var yesAction: (() -> Void)?
    var noAction: (() -> Void)?
    
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){ updareData() }
    
    ///updareData...
    fileprivate func updareData(){
        messageLabel.text = message
        noButton.setTitle(secondBtntext, for: .normal)
        yesButton.setTitle(firstBtnTitle, for: .normal)
    }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func noBtnAction(_ sender: Any) { self.dismiss(animated: false); noAction?() }
    
    ///yesBtnAction...
    @IBAction func yesBtnAction(_ sender: Any) { self.dismiss(animated: false); yesAction?() }
    
}
