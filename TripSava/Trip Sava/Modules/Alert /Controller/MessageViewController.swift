//
//  MessageViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 29/08/2023.
//

import UIKit
class MessageViewController: UIViewController {
    
    //MARK: - IBOutlets...
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    
    //MARK: - Variables...
    var message: String?
    var boldText: String?
    var msgColor: UIColor?
    
    var attributedString: NSMutableAttributedString?
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
    fileprivate func updareData(){ messageLabel.attributedText = attributedString }
    
    
    //MARK: - Actions...
     
    ///yesBtnAction...
    @IBAction func closeButtonAction(_ sender: Any) { self.dismiss(animated: false); closeBtnAction?() }
    
}
