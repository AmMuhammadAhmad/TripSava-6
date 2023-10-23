//
//  GetStartedViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 13/06/2023.
//

import UIKit
import ActiveLabel

class GetStartedViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var termAndConditionLabel: ActiveLabel!
    
    //MARK: - Variables...
    let messageString = "By using TripSava, you agree to our Terms of Use and Privacy Policy."
    let privacyPolicyStr = "Privacy Policy."
    let termsAndConditionStr = "Terms of Use"
    
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){
        if appCredentials.isFirstTimeLunch { backBtn.isHidden = true }
        else { backBtn.isHidden = false }
        setUpTermsAndConditionAttributedString()
    }
    
    ///setUpTermsAndConditionAttributedString...
    func setUpTermsAndConditionAttributedString() {
        
        let customType = ActiveType.custom(pattern: "\\sTerms of Use\\b")
        let customType1 = ActiveType.custom(pattern: "\\sPrivacy Policy\\b")
        termAndConditionLabel.enabledTypes = [.mention, .hashtag, .url, customType, customType1]
        termAndConditionLabel.text = "By using TripSava, you agree to our Terms of Use and Privacy Policy.      "
        termAndConditionLabel.numberOfLines = 0
        
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor(hex: "#E26A2B"), NSAttributedString.Key.font : Constants.applyFonts_DMSans(style: .Medium, size: 12), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
        
        termAndConditionLabel.customize { label in
            label.configureLinkAttribute = { _, _, _ in  return attributes  }
        }
        
        termAndConditionLabel.textColor = UIColor(hex: "#808080")
        termAndConditionLabel.font = Constants.applyFonts_DMSans(style: .regular, size: 12)
        
        termAndConditionLabel.handleCustomTap(for: customType) { element in
            SafariViewController.shared.openUrlWith(linkString: Constants.Urls.termsAndServicesUrl, Parentcontroller: self)
        }
        
        termAndConditionLabel.handleCustomTap(for: customType1) { element in
            SafariViewController.shared.openUrlWith(linkString: Constants.Urls.privacyAndPolicyUrl, Parentcontroller: self)
        }
        
    }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    
    ///ContinueWithEmailBtnAction...
    @IBAction func ContinueWithEmailBtnAction(_ sender: Any) { self.pushViewController(storyboard: "Auth", identifier: "SignUpViewController") }
    
    ///signInBtnAction...
    @IBAction func signInBtnAction(_ sender: Any) { self.pushViewController(storyboard: "Auth", identifier: "LoginViewController")
    }
}
