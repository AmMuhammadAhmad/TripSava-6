//
//  ProfileViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 19/06/2023.
//

import UIKit

class ProfileViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var inviteFriendMainView: UIView!
    
    @IBOutlet weak var inviteFriendInnerView: UIView!
    //MARK: - Variables...
    
    
    
    //MARK: - View Life Cycle...
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){
        let userProfile = UserDefaults.standard.retrieve(object: SignupModel.self, fromKey: Constants.profileModelStr)?.user
        nameLabel.text = "\(userProfile?.firstName ?? "") \(userProfile?.lastName ?? "")"
    }
    
    ///sendInviteMessage...
    func sendInviteMessage(isMail: Bool) {
        if isMail { self.sendEmail(subject: "Join me on My Awesome Trip App!", body: Constants.Urls.inviateMsg, recipients: []) }
        else { sendSMSWithText(message: Constants.Urls.inviateMsg, recipient: "") }
        self.inviteFriendInnerView.animateHideToBottom(duration: 0) { self.inviteFriendMainView.isHidden = true }
    }
    
     
    //MARK: - Actions...
    
    ///editProfileBtnAction...
    @IBAction func editProfileBtnAction(_ sender: Any) {
        self.pushViewController(storyboard: "Profile", identifier: "EditProfileViewController")
    }
    
    ///notificationBtnAction...
    @IBAction func notificationBtnAction(_ sender: Any) {
        self.pushViewController(storyboard: "Profile", identifier: "EditNotificationViewController")
    }
    
    ///loginAndAccountBtnAction...
    @IBAction func loginAndAccountBtnAction(_ sender: Any) { self.pushViewController(storyboard: "Profile", identifier: "LoginAndAccountViewController") }
    
    ///shareFeedBackBtnAction...
    @IBAction func shareFeedBackBtnAction(_ sender: Any) {
        self.pushViewController(storyboard: "Profile", identifier: "ShareFeedbackViewController")
    }
    
    ///FQQBtnAction...
    @IBAction func FQQBtnAction(_ sender: Any) {
        SafariViewController.shared.openUrlWith(linkString: Constants.Urls.FAQUrl, Parentcontroller: self)
    }
    
    ///getHelpBtnAction...
    @IBAction func getHelpBtnAction(_ sender: Any) {
    }
    
    ///privacyPolicyBtnAction....
    @IBAction func privacyPolicyBtnAction(_ sender: Any) {
        SafariViewController.shared.openUrlWith(linkString: Constants.Urls.privacyAndPolicyUrl, Parentcontroller: self)
    }
    
    ///termsOfServicesBtnAction...
    @IBAction func termsOfServicesBtnAction(_ sender: Any) {
        SafariViewController.shared.openUrlWith(linkString: Constants.Urls.termsAndServicesUrl, Parentcontroller: self)
    }
    
    ///inviteFriendBtnAction...
    @IBAction func inviteFriendBtnAction(_ sender: Any) {
        self.inviteFriendMainView.isHidden = false; self.inviteFriendInnerView.animateFromBottom(to: view.bounds.height - 300)
    }
    
    ///rateUsBtnAction...
    @IBAction func rateUsBtnAction(_ sender: Any) {
        SafariViewController.shared.openUrlWith(linkString: Constants.Urls.rattingUrl, Parentcontroller: self)
    }
    
    ///closeInviteFriendBtnAction...
    @IBAction func closeInviteFriendBtnAction(_ sender: Any) {
        self.inviteFriendInnerView.animateHideToBottom(duration: 0.2) { self.inviteFriendMainView.isHidden = true }
    }
    
    ///smsBtnAction..
    @IBAction func smsBtnAction(_ sender: Any) { sendInviteMessage(isMail: false) }
    
    ///emailBtnAction..
    @IBAction func emailBtnAction(_ sender: Any) { sendInviteMessage(isMail: true) }
    
    ///logoutBtnAction...
    @IBAction func logoutBtnAction(_ sender: Any) { self.showCustomView(firstBtnTitle: "Yes", secondBtntext: "No", message: "Are you sure you want to Logout?") {
        self.logoutNow() }
    }
    
}


//MARK: - Network layer...
extension ProfileViewController {
    
    ///logoutNow...
    func logoutNow(){
        self.showRappleActivity()
        if let token = appCredentials.accessToken {
            Constants.tripSavaServcesManager.logout(token: token) { resultent in
                switch resultent {
                case .success(let response):
                    self.hideRappleActivity() 
                    if response.status == false {
                        self.presentAlert(withTitle: "Alert", message: "please close app then reopen app again and try again")  }
                    else { appCredentials.resetAppCredentials(); self.setNewRootViewController(storyboard: "Auth", identifier: "OnBoardingViewController") }
                case .failure(let error): self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: error)
                }
            }
        }
        else { self.presentAlert(withTitle: "Alert", message: "please close app then reopen app again and try again") }
    }
}
