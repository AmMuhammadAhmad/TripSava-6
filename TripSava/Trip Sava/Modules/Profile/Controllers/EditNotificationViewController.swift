//
//  EditNotificationViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 19/06/2023.
//

import UIKit

class EditNotificationViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var notificationSwitchBtn: UISwitch!
    
    //MARK: - Variables...
    let userProfile = UserDefaults.standard.retrieve(object: SignupModel.self, fromKey: Constants.profileModelStr)
    
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){
        updateData()
    }
    
    ///updateData...
    func updateData(){ notificationSwitchBtn.isOn = userProfile?.user?.allowNotify ?? false }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    
    ///saveBtnAction...
    @IBAction func saveBtnAction(_ sender: Any) { updateNotificationsAlert(allowNotify: notificationSwitchBtn.isOn) }
    
}

//MARK: - Network layer...

extension EditNotificationViewController {
    
    ///updateNotificationsAlert...
    func updateNotificationsAlert(allowNotify: Bool){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.updateNotificationsAlert(allowNotify: allowNotify) { resultent in
            switch resultent {
                
            case .success(let response):
                if response.status == true {
                    let profile = SignupModel(status: self.userProfile?.status, message: self.userProfile?.message, user: response.user, tokens: self.userProfile?.tokens)
                    UserDefaults.standard.save(customObject: profile, inKey: Constants.profileModelStr)
                    self.presentAlert(withTitle: "Alert", message: response.message ?? Constants.errorMsg)
                }
                else {  self.presentAlert(withTitle: "Alert", message: response.message ?? Constants.errorMsg) }
                self.hideRappleActivity()
                
            case .failure(let error): self.presentAlert(withTitle: "Alert", message: error); self.hideRappleActivity()
            }
        }
        
    }
}
