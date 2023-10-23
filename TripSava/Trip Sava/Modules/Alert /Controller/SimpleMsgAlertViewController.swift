//
//  SimpleMsgAlertViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 11/10/2023.
//

import UIKit

class SimpleMsgAlertViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var okayBtn: UIButton!
    
    //MARK: - Variables...
    var message: String?
    var msgColor: UIColor?
    var labelFont: UIFont?
    var btnText: String?
    var closeBtnAction: (() -> Void)?
    
    
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
    fileprivate func updareData(){ messageLabel.text = message; messageLabel.textColor = msgColor; messageLabel.font = labelFont; okayBtn.setTitle(btnText, for: .normal) }

    //MARK: - Actions...
    @IBAction func closeButtonAction(_ sender: Any) { self.dismiss(animated: false); closeBtnAction?() }
}
