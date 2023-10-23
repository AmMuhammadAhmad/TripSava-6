//
//  PrintTableViewCell.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 27/07/2023.
//

import UIKit

class PrintTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets...
    @IBOutlet weak var itemNameLabel: UILabel!
    
    //MARK: - Variables...
    
    var item: String? {
        didSet {
            guard let item = item else { return }
            itemNameLabel.text = item
        }
    }
    
    //MARK: - Cell Init Methods...
    
    ///awakeFromNib...
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    
    //MARK: - Functions...
    
    ///setupCell...
    func setupCell(){ }
    
    
    //MARK: - Actions...
    
    
}
