//
//  DeleteShoppingListViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 30/08/2023.
//

import UIKit

class DeleteShoppingListViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    //MARK: - Variables...
   
    var message: String?
    var deleteBtnAction: (() -> Void)?
    
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){ updareData() }
    
    ///updareData...
    fileprivate func updareData(){ messageLabel.text = message }
    
    
    //MARK: - Actions...
     
    ///yesBtnAction...
    @IBAction func cancelButtonAction(_ sender: Any) { self.dismiss(animated: false) }
    
    ///deleteButtonAction...
    @IBAction func deleteButtonAction(_ sender: Any) { self.dismiss(animated: false); deleteBtnAction?() }

}
