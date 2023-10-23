//
//  MessageAndMail.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 31/07/2023.
//

import UIKit
import MessageUI

//MARK: - MessageCompose...
extension UIViewController: MFMessageComposeViewControllerDelegate {
    
    //MARK: - Functions...
    
    ///sendSMSWithText...
    func sendSMSWithText(message: String, recipient: String) {
        if MFMessageComposeViewController.canSendText() {
            let composeVC = MFMessageComposeViewController()
            composeVC.messageComposeDelegate = self
            composeVC.recipients = [recipient]
            composeVC.body = message
            self.present(composeVC, animated: true, completion: nil)
        } else { print("SMS services are not available on this device.") }
    }
    
    /// Delegate method for dismissing the SMS composer
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled: print("SMS Cancelled")
        case .sent: print("SMS Sent")
        case .failed: print("SMS Failed")
        @unknown default: break
        }
        controller.dismiss(animated: true, completion: nil)
    }
}


//MARK: - MailCompose...
extension UIViewController: MFMailComposeViewControllerDelegate {
    
    //MARK: - Functions...
    
    ///sendEmail....
    func sendEmail(subject: String, body: String, recipients: [String]) {
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            composeVC.setToRecipients(recipients)
            composeVC.setSubject(subject)
            composeVC.setMessageBody(body, isHTML: false)
            self.present(composeVC, animated: true, completion: nil)
        } else {  print("Email services are not available on this device.") }
    }
    
    /// Delegate method for dismissing the email composer
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled: print("Email Cancelled")
        case .sent: print("Email Sent")
        case .saved: print("Email Saved")
        case .failed: print("Email Failed")
        @unknown default: break
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
