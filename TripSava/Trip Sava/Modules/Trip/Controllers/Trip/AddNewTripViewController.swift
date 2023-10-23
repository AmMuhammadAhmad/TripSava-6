//
//  AddNewTripViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 08/08/2023.
//

import UIKit

class AddNewTripViewController: UIViewController {
    
    //MARK: - IBOutlets...
    @IBOutlet weak var addNewBgView: UIView!
    @IBOutlet weak var addNewView: UIView!
    
    //MARK: - Variables...
    var tripAction: (() -> Void)?
    var quickListAction: (() -> Void)?
    let animationDuration = 0.3
    let addNewViewHeight: CGFloat = 220
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showAddNewView()
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideAddNewView()
    }
    
    
    //MARK: - Functions...
     
    
    ///setUpViews...
    func setUpViews(){ }
     
    
    ///showAddNewView...
    func showAddNewView(){
        self.addNewBgView.isHidden = false; self.addNewView.isHidden = false
        addNewBgView.animateFromBottom(to: (self.window?.frame.height ?? 400) - addNewViewHeight , duration: 0.3)
    }
 
    
    ///hideAddNewView...
    func hideAddNewView(){
        addNewBgView.animateHideToBottom(duration: 0.5) { self.addNewBgView.isHidden = true; self.addNewView.isHidden = true }
    }
    
    ///updateViewWillDisappear...
    func updateViewWillDisappear(){
        self.addNewView.frame.origin.y = self.view.frame.height + self.addNewViewHeight
        self.addNewBgView.backgroundColor = UIColor.black.withAlphaComponent(0)
        self.addNewBgView.isHidden = true; self.addNewView.isHidden = true
    }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.dismiss(animated: false) }
    
    ///yesBtnAction...
    @IBAction func newTripBtnAction(_ sender: Any) { self.dismiss(animated: false); tripAction?() }
    
    ///quickListBtnAction...
    @IBAction func quickListBtnAction(_ sender: Any) { self.dismiss(animated: false); quickListAction?() }
    
}
