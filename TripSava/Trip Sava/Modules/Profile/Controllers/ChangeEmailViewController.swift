//
//  ChangeEmailViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 19/06/2023.
//

import UIKit

class ChangeEmailViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var emailTxt: UITextField!
    
    //MARK: - Variables...
    
    
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){ }
    
    func handleSaveBtnAction(){
        if emailTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter email") }
        else { self.updateEmailNow() }
    }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    
    ///saveBtnAction...
    @IBAction func saveBtnAction(_ sender: Any) { handleSaveBtnAction() }
    

}


//MARK: - Network layer...
extension ChangeEmailViewController {
    
    ///updateProfileNow...
    func updateEmailNow(){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.updateEmail(email: emailTxt.text!) { resultent in
            switch resultent {
            case .success(let responseUser):
                if responseUser.status == true {
                    UserDefaults.standard.save(customObject: responseUser, inKey: Constants.profileModelStr); self.hideRappleActivity()
                    self.presentAlertAndBackToPreviousView(withTitle: "Alert", message: responseUser.message ?? "User Updated successfully", controller: self)
                }
                else { self.presentAlert(withTitle: "Alert", message: responseUser.message ?? Constants.errorMsg); self.hideRappleActivity() }
            case .failure(let error): self.presentAlert(withTitle: "Alert", message: error); self.hideRappleActivity()
            }
        }
    }
    
}
