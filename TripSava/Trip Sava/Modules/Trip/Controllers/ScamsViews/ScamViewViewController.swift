//
//  ScamViewViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 19/06/2023.
//

import UIKit

class ScamViewViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var txtView: UILabel!
    @IBOutlet weak var reportBtn: UIButton!
    
    //MARK: - Variables...
    var chatGtpData: TextCompletionResponse?
    var destiNationCards: DestiNationCards?
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){
        headerImageView.image = UIImage(named: destiNationCards?.image ?? "")
        headerTitleLabel.text = destiNationCards?.headerMsg
        getChatGtpText(query: destiNationCards?.queryMsg ?? "")
    }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    
    ///reportBtnAction...
    @IBAction func reportBtnAction(_ sender: Any) {
    }
    
}

//MARK: - Network layer...
extension ScamViewViewController {
    
    ///getChatGtpText...
    func getChatGtpText(query: String){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.getChatGtpMessage(query: query) { resultent in
            switch resultent {
            case .success(let response): self.chatGtpData = response; self.hideRappleActivity(); self.handleresponse()
            case .failure(_): self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: "Please return to this screen later as the data is currently unavailable. Thank you for your patience") 
            }
        }
    }
    
    ///handleresponse...
    func handleresponse(){
        if let queryText = self.chatGtpData?.choices.first?.text { txtView.text = queryText.trimmingCharacters(in: .newlines) }
    }
    
}
