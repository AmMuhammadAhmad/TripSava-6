//
//  ShareFeedbackViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 08/06/2023.
//

import UIKit

class ShareFeedbackViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var msgLabel: UILabel!
    
    
    //MARK: - Variables...
    let messageString = "Thanks for sending us your ideas, issues, or appreciations. We can't respond individually, but we'll pass it on to the teams who are working to help make Tripsava better for everyone. \n\nIf you do have a specific question, or need help resolving a problem, you can contact us to connect with our support team."
    let linkString = "contact us"
     
    
    
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){
        setUpTermsAndConditionAttributedString()
    }
    
    func setUpTermsAndConditionAttributedString(){
        //set the message link...
        let msg = messageString

        let attributedString = NSMutableAttributedString(string: msg)

        let completetxtrange = (msg as NSString).range(of: msg)
        attributedString.addAttributes([NSAttributedString.Key.font: Constants.applyFonts_DMSans(style: .regular, size: 14), NSAttributedString.Key.foregroundColor : UIColor(hex: "#474847", alpha: 0.8)], range: completetxtrange)

        let range = (msg as NSString).range(of: linkString)
        attributedString.addAttributes([NSAttributedString.Key.font: Constants.applyFonts_DMSans(style: .Medium, size: 14), NSAttributedString.Key.foregroundColor : UIColor(hex: "#E26A2B")], range: range)
         
        attributedString.append(NSAttributedString(string: ".aa   s   aa.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.clear, ]))

        msgLabel.isUserInteractionEnabled = true;
        DispatchQueue.main.async {
            self.msgLabel.attributedText = attributedString
        }
        msgLabel.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(handleMsgTapGesture(getsture:))))
    }
    
    
    @objc func handleMsgTapGesture(getsture: UITapGestureRecognizer) {
        let range = (msgLabel.text! as NSString).range(of: linkString)
        if getsture.didTapAttributedTextInLabell(label: msgLabel, inRange: range) {
            SafariViewController.shared.openUrlWith(linkString: "http://www.google.com", Parentcontroller: self)
        }
    }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    
    @IBAction func saveBtnAction(_ sender: Any) { self.popViewController() }

}
