//
//  UpdatePasswordViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 31/07/2023.
//

import UIKit

class UpdatePasswordViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var currentPasswordTxt: TextField!
    @IBOutlet weak var newPasswordTxt: TextField!
    @IBOutlet weak var confirmPasswordTxt: TextField!
    @IBOutlet weak var thirdEyeImg: UIImageView!
    @IBOutlet weak var secondEyeImg: UIImageView!
    @IBOutlet weak var firstEyeImg: UIImageView!
    
    //MARK: - Variables...
    let user = UserDefaults.standard.retrieve(object: SignupModel.self, fromKey: Constants.profileModelStr)
    
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){ }
    
    ///handleEyeBtnAction...
    func handleEyeBtnAction(tag: Int){
        switch tag {
        case 0: currentPasswordTxt.isSecureTextEntry.toggle()
        case 1: newPasswordTxt.isSecureTextEntry.toggle()
        case 2: confirmPasswordTxt.isSecureTextEntry.toggle()
        default: currentPasswordTxt.isSecureTextEntry = true; newPasswordTxt.isSecureTextEntry = true; confirmPasswordTxt.isSecureTextEntry = true
        }
    }
    
    ///toggleEyeImage...
    func toggleEyeImage(tag: Int){
        
        if tag == 0 {
            if firstEyeImg.image == UIImage(systemName: "eye.slash") { firstEyeImg.image = UIImage(systemName: "eye") } else { firstEyeImg.image = UIImage(systemName: "eye.slash") }
        }
        else if tag == 1 {
            if secondEyeImg.image == UIImage(systemName: "eye.slash") { secondEyeImg.image = UIImage(systemName: "eye") } else { secondEyeImg.image = UIImage(systemName: "eye.slash") }
        }
        if tag == 2 {
            if thirdEyeImg.image == UIImage(systemName: "eye.slash") { thirdEyeImg.image = UIImage(systemName: "eye") } else { thirdEyeImg.image = UIImage(systemName: "eye.slash") }
        }
    }
    
    ///handleUpdateBtnAction...
    func handleUpdateBtnAction(){
        if currentPasswordTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter the current password.") }
        else if newPasswordTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter the new password.") }
        else if newPasswordTxt.isPasswordInRange() { self.presentAlert(withTitle: "Alert", message: "The new password must be greater than 8.") }
        else if confirmPasswordTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter the confirm password.") }
        else if confirmPasswordTxt.isPasswordInRange() { self.presentAlert(withTitle: "Alert", message: "The password must be greater than 8.") }
        else if newPasswordTxt.trimText() != confirmPasswordTxt.trimText() { self.presentAlert(withTitle: "Alert", message: "New Password do not match.") }
        else { self.updatePassword() }
    }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    
    ///passwordEyeBtnAction...
    @IBAction func passwordEyeBtnAction(_ sender: UIButton) { handleEyeBtnAction(tag: sender.tag); toggleEyeImage(tag: sender.tag) }
     
    ///updatePasswordNow...
    @IBAction func updatePasswordNow(_ sender: Any) { handleUpdateBtnAction() }
    
}

//MARK: - Network layer...
extension UpdatePasswordViewController {
    
    ///updatePassword..
    func updatePassword(){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.updatePassword(currentPassword: currentPasswordTxt.trimText(), newPassword: newPasswordTxt.trimText()) { resultent in
            switch resultent { 
            case .success(let response): self.hideRappleActivity();
                if response.status == true {
                    let updateUser = SignupModel(status: self.user?.status, message: self.user?.message, user: response.user, tokens: response.tokens)
                    UserDefaults.standard.save(customObject: updateUser, inKey: Constants.profileModelStr)
                    self.presentAlert(withTitle: "Alert", message: response.message ?? "Password update successfully") 
                }
                else { self.presentAlert(withTitle: "Alert", message: response.message ?? Constants.errorMsg) }
            case .failure(let error):
                self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: error)
            }
        }
    }
}
