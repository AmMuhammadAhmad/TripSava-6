//
//  WebViewViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 05/08/2023.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    //MARK: - Variables...
    var webLink: String = ""
    var headerText = ""
    
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){
        headerLabel.text = headerText
        if let url = URL(string: webLink) {
            let request = URLRequest(url: url); webView.load(request)
        }
    }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    
    @IBAction func printBtnTapped(_ sender:UIButton){
        self.sharePDF()
    }
    
    func printPDF() {
        let printInfo = UIPrintInfo.printInfo()
        printInfo.outputType = .general

        let printController = UIPrintInteractionController.shared
        printController.printInfo = printInfo
        printController.printFormatter = webView.viewPrintFormatter()

        printController.present(animated: true) { (controller, success, error) in
            if success {
                print("Printing completed successfully")
            } else if let error = error {
                print("Printing failed: \(error)")
            }
        }
    }
    
    func sharePDF() {
        if let pdfData = webView.pdfData {
            let activityViewController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // For iPad

            self.present(activityViewController, animated: true, completion: nil)
        }
    }


}

extension WKWebView {
    var pdfData: Data? {
        if let pdfURL = self.url,
            let pdfData = try? Data(contentsOf: pdfURL) {
            return pdfData
        }
        return nil
    }
}
