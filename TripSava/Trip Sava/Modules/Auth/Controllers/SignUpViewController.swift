//
//  SignUpViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 13/06/2023.
//

import UIKit
import ActiveLabel

class SignUpViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var emailTxt: TextField!
    @IBOutlet weak var passwordTxt: TextField!
    @IBOutlet weak var confirmPasswordTxt: TextField!
    @IBOutlet weak var termAndConditionLabel: ActiveLabel!
    @IBOutlet weak var errorMsgLabel: UILabel!
    
    
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
    func setUpViews(){ setUpTermsAndConditionAttributedString() }
    
    ///setUpTermsAndConditionAttributedString...
    func setUpTermsAndConditionAttributedString() {
        
        let customType = ActiveType.custom(pattern: "\\sTerms of Use\\b")
        let customType1 = ActiveType.custom(pattern: "\\sPrivacy Policy\\b")
        termAndConditionLabel.enabledTypes = [.mention, .hashtag, .url, customType, customType1]
        termAndConditionLabel.text = "By using TripSava, you agree to our Terms of Use and Privacy Policy.      "
        termAndConditionLabel.numberOfLines = 0
        
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor(hex: "#003681"), NSAttributedString.Key.font : Constants.applyFonts_DMSans(style: .Medium, size: 12), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
        
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
    
    ///handleSignUpBtnAction...
    func handleSignUpBtnAction(){
        if emailTxt.isEmptyTextField() { self.showErrorMsg(msg: "Enter your email.") }
        else if !emailTxt.isValidEmail() { self.showErrorMsg(msg: "Email address is not valid.") }
        else if passwordTxt.isEmptyTextField() { self.showErrorMsg(msg: "Enter the password.") }
        else if passwordTxt.isPasswordInRange() { self.showErrorMsg(msg: "The password must be greater than 8.") }
        else if confirmPasswordTxt.isEmptyTextField() { self.showErrorMsg(msg: "Enter the confirm password.") }
        else if confirmPasswordTxt.isPasswordInRange() { self.showErrorMsg(msg: "The password must be greater than 8.") }
        else if passwordTxt.trimText() != confirmPasswordTxt.trimText() { self.showErrorMsg(msg: "The passwords do not match.") }
        else { gotoSignUpDetailsController() }
    }
    
    ///gotoSignUpDetailsController...
    func gotoSignUpDetailsController(){
        let credentials: userCredentials = (emailTxt.text!, passwordTxt.text!)
        let storyboard = UIStoryboard(name: "Auth", bundle: nil); clearTxt()
        let controller = storyboard.instantiateViewController(withIdentifier: "SignUpDetailsViewController") as! SignUpDetailsViewController
        controller.user = credentials; self.navigationController?.pushViewController(controller, animated: true) 
    }
    
    ///clearTxt...
    func clearTxt(){ self.emptyTextField(textFields: [emailTxt, passwordTxt, confirmPasswordTxt]) }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    
    ///signUpBtnAction...
    @IBAction func signUpBtnAction(_ sender: Any) { self.handleSignUpBtnAction() }
    
    
}

//MARK: - TextFieldDelegate...
extension SignUpViewController: UITextFieldDelegate {
      
    ///textFieldDidBeginEditing...
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorMsgLabel.isHidden = true
    }
    
    ///showErrorMsg...
    func showErrorMsg(msg: String){ errorMsgLabel.isHidden = false; errorMsgLabel.text = msg }
     
}
