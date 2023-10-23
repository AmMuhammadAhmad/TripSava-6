//
//  EmbassiesDetailsCustomView.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 03/08/2023.
//

import UIKit 

class EmbassiesDetailsCustomView: UIView {
    
    //MARK: - Variables...
    
    ///iconImageView...
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return imageView
    }()
    
    ///iconContainerView...
    private let iconContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return view
    }()
    
    
    ///horizontalStackView...
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconContainerView, workingHoursStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    ///workingHoursStackView....
    private let workingHoursStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    
    
    //MARK: - Init Methods...
    
    ///init..
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    ///required init...
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    
    
    //MARK: - Functions...
    
    ///setupUI..
    private func setupUI() {
        backgroundColor = .clear; addSubview(horizontalStackView)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add iconImageView to iconContainerView
        iconContainerView.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Constraints for horizontalStackView
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Constraints for iconImageView
            iconImageView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor),
            iconImageView.topAnchor.constraint(equalTo: iconContainerView.topAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            
            // Constraints for iconContainerView
            iconContainerView.leadingAnchor.constraint(equalTo: horizontalStackView.leadingAnchor),
            iconContainerView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    ///setUpViews...
    func setUpViews(icon: UIImage?, workingHours: [String], tag: Int) {
        iconImageView.image = icon
        workingHours.forEach { info in
            let workingHoursLabel = UILabel()
            workingHoursLabel.text = info; workingHoursLabel.tag = tag; workingHoursLabel.numberOfLines = 0
            workingHoursLabel.font = Constants.applyFonts_DMSans(style: .regular, size: 14)
            workingHoursLabel.textColor = UIColor(hex: "#474847", alpha: 0.96)
            workingHoursLabel.isUserInteractionEnabled = true
            workingHoursLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:))))
            workingHoursStackView.addArrangedSubview(workingHoursLabel)
        }
    }
    
    ///labelTapped...
    @objc private func labelTapped(_ gesture: UITapGestureRecognizer) {
        
        if let label = gesture.view as? UILabel, let text = label.text {
            if label.tag == 0 { ///address...
                let addressText = text.replacingOccurrences(of: "address", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
                let encodedAddress = addressText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                if let addressURL = URL(string: "http://maps.apple.com/?q=\(encodedAddress)") {
                    UIApplication.shared.open(addressURL, options: [:], completionHandler: nil)
                }
            }
            else if label.tag == 1 { /// phone...
                if let phoneURL = URL(string: "tel:\(text)") { UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil) }
                else { displayInvalidPhoneNumberAlert() }
            }
            else if label.tag == 2 { /// email...
                if let emailURL = URL(string: "mailto:\(text)") { UIApplication.shared.open(emailURL, options: [:], completionHandler: nil) }
            }
            else if label.tag == 4 { /// links...
                if let url = URL(string: text) { UIApplication.shared.open(url, options: [:], completionHandler: nil) }
            }
        }
    }
    
    ///displayInvalidPhoneNumberAlert...
    private func displayInvalidPhoneNumberAlert() {
        let alert = UIAlertController(title: "Invalid Phone Number", message: "The provided phone number is not valid.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let viewController = windowScene.windows.first?.rootViewController { viewController.present(alert, animated: true, completion: nil) }
    }
    
}
