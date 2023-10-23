//
//  CheckListCollectionViewCell.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 05/08/2023.
//

import UIKit

class CheckListCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets...
    
    @IBOutlet weak var checkListCardImageView: UIImageView!
    
    //MARK: - Variables...
    var data: CheckListModel? {
        didSet {
            guard let data = data else { return }
            checkListCardImageView.image = UIImage(named: data.imgName)
        }
    }
    
    var delegate: LibraryViewController?
    
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
    
    ///didTapOnCheckListCard...
    @IBAction func didTapOnCheckListCard(_ sender: Any) {
        guard let checkList = data else { return }; delegate?.didTapOnCheckListBtn(data: checkList)
    }
    
}
