//
//  EmbassiesHeaderView.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 01/08/2023.
//

import UIKit

class EmbassiesHeaderView: UITableViewHeaderFooterView {
    
    //MARK: - Variables...
    static let reuseIdentifier = "EmbassiesHeaderView"
    
    ///headerLabel...
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#040415")
        label.font = Constants.applyFonts_DMSans(style: .bold, size: 16)
        return label
    }()
    
    ///headerText....
    var headerText: String? {
        didSet {
            guard let title = headerText else { return }
            headerLabel.text = title
        }
    }
    
    //MARK: - View init methods
    
    ///reuseIdentifier....
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    ///coder...
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    ///willMove...
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        contentView.backgroundColor = UIColor.white
    }
    
    //MARK: - Functions...
    
    ///setupViews...
    private func setupViews() {
        backgroundView = UIView(); backgroundView?.backgroundColor = .clear; contentView.backgroundColor = .white
        contentView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            headerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
     
}
