//
//  LoginAndAccountViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 31/07/2023.
//

import UIKit

class LoginAndAccountViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var lastUpdatedTxt: UITextField!
    
    //MARK: - Variables...
   
    
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    ///viewWillAppear...
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpViews()
    }
    
    
    //MARK: - Functions...
     
    ///setUpViews...
    func setUpViews(){
        print(UserDefaults.standard.retrieve(object: SignupModel.self, fromKey: Constants.profileModelStr)?.user?.lastPasswordUpdate)
        if let lastPasswordUpdate =  UserDefaults.standard.retrieve(object: SignupModel.self, fromKey: Constants.profileModelStr)?.user?.lastPasswordUpdate {
            lastUpdatedTxt.text = self.getTimeAgo(from: lastPasswordUpdate)
        } else {  lastUpdatedTxt.text = "********" }
    }
    
    ///handleDeleteAccountBtnAction...
    func handleDeleteAccountBtnAction(){
        self.showCustomView(firstBtnTitle: "Yes", secondBtntext: "No", message: "Are you sure you want to delete your account?") { self.deleteAccount() }
    }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    
    ///updatePasswordBtnAction...
    @IBAction func updatePasswordBtnAction(_ sender: Any) { self.pushViewController(storyboard: "Profile", identifier: "UpdatePasswordViewController") }
    
    ///DeleteAccountBtnAction...
    @IBAction func DeleteAccountBtnAction(_ sender: Any) { handleDeleteAccountBtnAction() }
    
}

//MARK: - Network layer...
extension LoginAndAccountViewController {
    
    ///deleteAccount..
    func deleteAccount(){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.deleteAccount { resultent in
            switch resultent {
            case .success(let response):
                print(response.status)
                print(response.message)
                self.hideRappleActivity()
                if response.status == true { appCredentials.resetAppCredentials(); self.setNewRootViewController(storyboard: "Auth", identifier: "OnBoardingViewController") }
                else {  self.presentAlert(withTitle: "Alert", message: response.message ?? Constants.errorMsg) }
            case .failure(let error): self.presentAlert(withTitle: "Alert", message: error); self.hideRappleActivity()
            }
        }
    }
    
    
}
