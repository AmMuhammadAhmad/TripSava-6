//
//  LoginViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 13/06/2023.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var emailTxt: TextField!
    @IBOutlet weak var passwordTxt: TextField!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var forgortEmailView: UIView!
    @IBOutlet weak var otpMainView: UIView!
    @IBOutlet weak var otpView: OTPView!
    @IBOutlet weak var resetPasswordView: UIView!
    @IBOutlet weak var forgotPasswordEmailTxt: TextField!
    @IBOutlet weak var forgotPasswordTxt: TextField!
    @IBOutlet weak var forgotConfirmPasswordTxt: TextField!
    @IBOutlet weak var secondEyeImg: UIButton!
    @IBOutlet weak var firstEyeImg: UIButton!
    
    
    //MARK: - Variables...
    var textFields = [UITextField]()
    var otp = ""; var currentAccessToken = ""
    
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){
        setupOTPAction() 
    }
    
    ///setupOTPAction...
    func setupOTPAction(){
        otpView.handleOtpCompletion = { otpValue in  self.otp = otpValue }
    }
    
    ///handleSignInBtnAction...
    func handleSignInBtnAction(){
        if emailTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter email") }
        else if !emailTxt.isValidEmail() { self.presentAlert(withTitle: "Alert", message: "Enter the valid email") }
        else if passwordTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter password") }
        else if passwordTxt.isPasswordInRange() { self.presentAlert(withTitle: "Alert", message: "Password must be greater than 8") }
        else { loginNow(email: emailTxt.text!, password: passwordTxt.text!) }
    }
    
    ///clearTxt...
    func clearTxt(){
        self.emptyTextField(textFields: [emailTxt, passwordTxt] )
    }
    
    ///handleBottomViewBtnAction...
    func handleBottomViewBtnAction(){ self.bottomView.isHidden = true; forgortEmailView.isHidden = true; otpMainView.isHidden = true; resetPasswordView.isHidden = true  }
    
    ///handleFortgotBtnAction...
    func handleFortgotBtnAction(){ self.bottomView.isHidden = false; forgortEmailView.isHidden = false }
    
    ///handleForgotPasswordContinueBtnAction..
    func handleForgotPasswordContinueBtnAction(){
        if forgotPasswordEmailTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter email") }
        else { sendOptForForgotPassword() }
    }
    
    ///handleOTPContinueBtnAction...
    func handleOTPContinueBtnAction(){
        if otp == "" { self.presentAlert(withTitle: "Alert", message: "Enter OTP Code") }
        if currentAccessToken == "" { self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " Please send otp again") }
        else { verifyOTPCode(otp: otp, token: currentAccessToken) }
    }
    
    ///resetPasswordBtnAction..
    func resetPasswordBtnAction(){
        if forgotPasswordTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter password") }
        else if forgotPasswordTxt.isPasswordInRange() { self.presentAlert(withTitle: "Alert", message: "Password must be greater than 8") }
        else if forgotConfirmPasswordTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter confirm password") }
        else if forgotConfirmPasswordTxt.isPasswordInRange() { self.presentAlert(withTitle: "Alert", message: "Password must be greater than 8") }
        else if forgotPasswordTxt.trimText() != forgotConfirmPasswordTxt.trimText() { self.presentAlert(withTitle: "Alert", message: "Password not match") }
        else if currentAccessToken == "" { self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " Please send otp again") }
        else { resetPasswordNow(token: self.currentAccessToken) }
    }
    
    ///toggleEyeImage...
    func toggleEyeImage(tag: Int){
        if tag == 0 {
            if firstEyeImg.currentImage == UIImage(systemName: "eye.slash") { firstEyeImg.setImage(UIImage(systemName: "eye"), for: .normal)  } else { firstEyeImg.setImage(UIImage(systemName: "eye.slash"), for: .normal) }
        }
        else if tag == 1 {
            if secondEyeImg.currentImage == UIImage(systemName: "eye.slash") { secondEyeImg.setImage(UIImage(systemName: "eye"), for: .normal)  } else { secondEyeImg.setImage(UIImage(systemName: "eye.slash"), for: .normal) }
        }
    }
    
    ///handleEyeBtnAction...
    func handleEyeBtnAction(tag: Int){
        switch tag {
        case 0: forgotPasswordTxt.isSecureTextEntry.toggle()
        case 1: forgotConfirmPasswordTxt.isSecureTextEntry.toggle()
        default: forgotConfirmPasswordTxt.isSecureTextEntry = true; forgotPasswordTxt.isSecureTextEntry = true
        }
    }
    
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    
    ///backBtnAction...
    @IBAction func signUpBtnAction(_ sender: Any) { self.popViewController() }
    
    ///loginBtnAction...
    @IBAction func loginBtnAction(_ sender: Any) { handleSignInBtnAction() }
    
    ///bottomViewBtnAction...
    @IBAction func bottomViewBtnAction(_ sender: Any) { handleBottomViewBtnAction() }
    
    ///forgotPasswordBtnAction...
    @IBAction func forgotPasswordBtnAction(_ sender: Any) { handleFortgotBtnAction() }
    
    ///forgotPasswordContinueBtnAction..
    @IBAction func forgotPasswordContinueBtnAction(_ sender: Any) { handleForgotPasswordContinueBtnAction() }
    
    ///otpContinueBtnAction...
    @IBAction func otpContinueBtnAction(_ sender: Any) { handleOTPContinueBtnAction() }
    
    ///resetPasswordBtnAction...
    @IBAction func resetPasswordBtnAction(_ sender: Any) { resetPasswordBtnAction() }
    
    ///eyeBtnAction..
    @IBAction func eyeBtnAction(_ sender: UIButton) { toggleEyeImage(tag: sender.tag); handleEyeBtnAction(tag: sender.tag) }
    
}


//MARK: - Network layer...
extension LoginViewController {
    
    ///loginNow...
    func loginNow(email: String, password: String) {
        self.showRappleActivity()
        Constants.tripSavaServcesManager.login(email: email.lowercased(), password: password) { resultent in
            switch resultent {
            case .success(let response):
                self.hideRappleActivity(); self.clearTxt()
                if response.status == false { self.presentAlert(withTitle: "Alert", message: response.message ?? "Account verification required") }
                else {
                    appCredentials.isFirstTimeLunch = true
                    appCredentials.accessToken = response.tokens?.accessToken?.token; appCredentials.isUserLogin = true
                    UserDefaults.standard.save(customObject: response, inKey: Constants.profileModelStr)
                    self.setNewRootViewController(storyboard: "Tabbar", identifier: "TabBarVC")
                } 
            case .failure(let error): self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: error)
            }
        }
    }
    
    ///sendOptForForgotPassword...
    func sendOptForForgotPassword(){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.sendOptForForgotPassword(email: forgotPasswordEmailTxt.text!.lowercased()) { resultent in
            switch resultent {
            case .success(let response):
                print(response)
                if response.status == true {
                    print(response)
                    self.presentAlert(withTitle: "Alert", message: response.message ?? "4 digit otp code sended at provided email \(self.forgotPasswordEmailTxt.text!)")
                    self.forgortEmailView.isHidden = true; self.otpMainView.isHidden = false; self.forgotPasswordEmailTxt.text = "";
                    self.currentAccessToken = response.tokens?.accessToken?.token ?? ""
                } else { self.presentAlert(withTitle: "Alert", message: response.message ?? Constants.errorMsg) }
                self.hideRappleActivity()
            case .failure(_): self.presentAlert(withTitle: "Alert", message: Constants.errorMsg); self.hideRappleActivity()
            }
        }
    }
    
    ///verifyOTPCode...
    func verifyOTPCode(otp: String, token: String) {
        self.showRappleActivity()
        Constants.tripSavaServcesManager.verifyOTPCode(otpCode: self.otp, token: token) { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true {
                    self.otpMainView.isHidden = true; self.resetPasswordView.isHidden = false; self.otp = ""
                    self.currentAccessToken = response.tokens?.accessToken?.token ?? ""
                } else { self.presentAlert(withTitle: "Alert", message: response.message ?? Constants.errorMsg) }
                self.hideRappleActivity()
            case .failure(_): self.presentAlert(withTitle: "Alert", message: Constants.errorMsg); self.hideRappleActivity()
            }
        }
    }
    
    ///resetPasswordNow..
    func resetPasswordNow(token: String){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.resetPassword(password: forgotPasswordTxt.text!, token: token) { resultent in
            switch resultent {
            case .success(let response):
                print(response.status)
                if response.status == true {
                    self.resetPasswordView.isHidden = true; self.bottomView.isHidden = true; self.otp = ""; self.currentAccessToken = ""
                    let action = UIAlertAction(title: "Ok", style: .default) { isComplected in
                        appCredentials.accessToken = response.tokens?.accessToken?.token; appCredentials.isUserLogin = true
                        UserDefaults.standard.save(customObject: response, inKey: Constants.profileModelStr)
                        self.setNewRootViewController(storyboard: "Tabbar", identifier: "TabBarVC")
                    }
                    self.presentAlertAndGotoThatFunction(withTitle: "Alert", message:  response.message ?? "Password change successfully", OKAction: action)
                } else { self.presentAlert(withTitle: "Alert", message: response.message ?? Constants.errorMsg) }
                self.hideRappleActivity()
            case .failure(_): self.presentAlert(withTitle: "Alert", message: Constants.errorMsg); self.hideRappleActivity()
            }
        }
    }
    
    
    
    
    
    
    
}


