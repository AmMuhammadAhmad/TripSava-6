//
//  Constants.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 05/06/2023.
//

import UIKit

struct Constants {
    
    private init() {}
    
    //MARK: - App static Variables
    static var tripSavaServcesManager = TripSavaNetworkingManager()
    
    //MARK: - Colors...
    static let primaryColor: UIColor = UIColor(red: 0, green: 54, blue: 129, alpha: 1)
    static let secondryColor: UIColor = UIColor(red: 0.886, green: 0.416, blue: 0.169, alpha: 1)
    static let mainHeadingColor: UIColor = UIColor(red: 4, green: 4, blue: 21, alpha: 1)
    static let subHeadingColor: UIColor = UIColor(red: 71, green: 72, blue: 71, alpha: 0.96)
    static let textColor: UIColor = UIColor(red: 71, green: 72, blue: 71, alpha: 0.6)
    static let lightGrey: UIColor = UIColor(red: 0.542, green: 0.542, blue: 0.542, alpha: 1)
    
    static let errorMsg = "Something went wrong please try again"
    static let loadingMsg = "Loading..."
    static let profileModelStr = "profileModelStr"
    static let favIDsStr = "favIDsStr"
    static let updateFav = "updateFav"
    static let closedMsg = "Please close and reopen your app"
    
    //MARK: - EmbassiesData...
    struct EmbassiesData {
        static let embassy = "embassy"
        static let consultant = "consulate"
        static let office = "office"
        static let mission = "mission"
    }
    
    
    // MARK: - App URLs
    struct API {
        static let appBaseTestURL = "http://192.168.0.116:9007/v1"
        static let appLiveBaseUrl = "https://trip-sawa-api-22bb4f708068.herokuapp.com/v1/"
        static let googleMapTextSearchBaseUrl = "https://maps.googleapis.com/maps/api/place/"
        static let geoCoadingUrl = "https://maps.googleapis.com/maps/api/"
        static let chatGTPBaseUrl = "https://api.openai.com/v1/"
        static let googleMapKey = "AIzaSyCye2RoTwvhTqk-MQMu8qsNIfucTRt7PyY"
        static let ChatGTPKeyKey = "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"
       
    }
    
    //MARK: - Message...
    
    struct Urls {
        static let rattingUrl = "https://apps.apple.com/app/id\(310633997)?action=write-review"
        static let FAQUrl = "https://www.tripsava.com/how-it-works"
        static let privacyAndPolicyUrl = "https://www.tripsava.com/privacy-policy"
        static let termsAndServicesUrl = "https://www.tripsava.com/terms-of-service"
        static let appStoreLink = "App Store: https://apps.apple.com/us/app/whatsapp-messenger/id310633997"
        static let playStoreLink = "Google Play Store: https://play.google.com/store/apps/details?id=com.whatsapp&hl=en&gl=US&pli=1"
        static let inviateMsg = """
                Hey there!
                
                I wanted to invite you to join me on TripSava! 🌍✈️
                
                TripSava he perfect companion for all your travel adventures! Plan, track, and share your trips with ease.
                
                To get started, simply download TripSava from the App Store or Google Play Store using the links below:
                
                \(appStoreLink)
                \(playStoreLink)
                
                Whether you're a seasoned globetrotter or planning your first trip, TripSava will be your ultimate travel companion. Let's embark on unforgettable journeys together!
                
                Looking forward to seeing you on TripSava!
                
                Best regards,
                \(appCredentials.name ?? "TripSava User")
                """
    }
    
     
    //MARK: - Variables...
    
    
    
    //MARK: - Apply Font
    static func applyFonts_DMSans(style: FontStyle, size: CGFloat) -> UIFont {
        return UIFont(name: "DMSans-\(style.rawValue)", size: size)!
    }
    
    //MARK:- Font Styles
    enum FontStyle: String {
        case light = "Light"
        case regular = "Regular"
        case bold = "Bold"
        case semibold = "Semibold"
        case Medium = "Medium"
    }
    
    
    
}



// MARK: - appCredentials...
struct appCredentials {
    private init() {}
    
    ///allFavoritesIDs...
    static var allFavoritesIDs: [String] = []
    
    ///isSocialPlatfrom...
    static var isSocialPlatfrom: Bool {
        set { UserDefaults.standard.set(newValue, forKey: "isSocialPlatfrom")}
        get {
            if UserDefaults.standard.object(forKey: "isSocialPlatfrom") == nil {
                UserDefaults.standard.set(false, forKey: "isSocialPlatfrom"); return false
            }
            return UserDefaults.standard.bool(forKey: "isSocialPlatfrom")
        }
    }
    
    ///password...
    static var password: String? {
        set { UserDefaults.standard.set(newValue, forKey: "password") }
        get {
            if let getUid = UserDefaults.standard.string(forKey: "password") {
                if getUid == "" { return "" }
                let uid = getUid; return uid
            } else { return "" }
        }
    }
    
    ///imageURL...
    static var imageURL: String? {
        set { UserDefaults.standard.set(newValue, forKey: "imageURL") }
        get {
            if let getUid = UserDefaults.standard.string(forKey: "imageURL") {
                if getUid == "" { return "" }
                let uid = getUid; return uid
            } else { return "" }
        }
    }
    
    ///name...
    static var name: String? {
        set { UserDefaults.standard.set(newValue, forKey: "name") }
        get {
            if let getUid = UserDefaults.standard.string(forKey: "name") {
                if getUid == "" { return "" }
                let uid = getUid; return uid
            } else { return "" }
        }
    }
    
    ///dateOfBirth...
    static var dateOfBirth: Date? {
        set { UserDefaults.standard.set(newValue, forKey: "dateOfBirth") }
        get {
            if let getUid = UserDefaults.standard.object(forKey: "dateOfBirth")  {
                return getUid as? Date
            } else { return Date() }
        }
    }
    
    ///gender..
    static var gender: String? {
        set { UserDefaults.standard.set(newValue, forKey: "gender") }
        get {
            if let getUid = UserDefaults.standard.string(forKey: "gender") {
                if getUid == "" { return "" }
                let uid = getUid; return uid
            } else { return "" }
        }
    }
     
    ///email...
    static var email: String? {
        set { UserDefaults.standard.set(newValue, forKey: "email") }
        get {
            if let getUid = UserDefaults.standard.string(forKey: "email") {
                if getUid == "" { return "" }
                let uid = getUid; return uid
            } else { return "" }
        }
    }
    
    ///isFirstTimeLunch...
    static var isFirstTimeLunch: Bool {
        set { UserDefaults.standard.set(newValue, forKey: "isFirstTimeLunch")}
        get {
            if UserDefaults.standard.object(forKey: "isFirstTimeLunch") == nil {
                UserDefaults.standard.set(false, forKey: "isFirstTimeLunch"); return false
            }
            return UserDefaults.standard.bool(forKey: "isFirstTimeLunch")
        }
    }
    
    ///isFirstTimeOpenHome...
    static var isFirstTimeOpenHome: Bool {
        set { UserDefaults.standard.set(newValue, forKey: "isFirstTimeOpenHome")}
        get {
            if UserDefaults.standard.object(forKey: "isFirstTimeOpenHome") == nil {
                UserDefaults.standard.set(false, forKey: "isFirstTimeOpenHome"); return false
            }
            return UserDefaults.standard.bool(forKey: "isFirstTimeOpenHome")
        }
    }
    
    ///isFirstTimeLunch...
    static var isUserLogin: Bool {
        set { UserDefaults.standard.set(newValue, forKey: "isUserLogin")}
        get {
            if UserDefaults.standard.object(forKey: "isUserLogin") == nil {
                UserDefaults.standard.set(false, forKey: "isUserLogin"); return false
            }
            return UserDefaults.standard.bool(forKey: "isUserLogin")
        }
    }
    
    ///isFirstTimeLunch...
    static var isFirstTimeOpenShpoingList: Bool {
        set { UserDefaults.standard.set(newValue, forKey: "isFirstTimeOpenShpoingList")}
        get {
            if UserDefaults.standard.object(forKey: "isFirstTimeOpenShpoingList") == nil {
                UserDefaults.standard.set(false, forKey: "isFirstTimeOpenShpoingList"); return false
            }
            return UserDefaults.standard.bool(forKey: "isFirstTimeOpenShpoingList")
        }
    }
    
    
    ///accessToken...
    static var accessToken: String? {
        set { UserDefaults.standard.set(newValue, forKey: "accessToken") }
        get {
            if let getUid = UserDefaults.standard.string(forKey: "accessToken") {
                if getUid == "" { return "" }
                let uid = getUid; return uid
            } else { return "" }
        }
    }
    
    ///catalogSelectedTab...
    static var catalogSelectedTab: String? {
        set { UserDefaults.standard.set(newValue, forKey: "catalogSelectedTab") }
        get {
            if let data = UserDefaults.standard.string(forKey: "catalogSelectedTab") {
                if data == "" { return "product" }
                let id = data; return id
            } else { return "product" }
        }
    }
     
    
    ///resetAppCredentials...
    static func resetAppCredentials(){
        UserDefaults.standard.save(customObject: SignupModel(status: nil, message: nil, user: nil, tokens: nil), inKey: Constants.profileModelStr)
        appCredentials.password = ""
        appCredentials.imageURL = ""
        appCredentials.name = ""
        appCredentials.dateOfBirth = nil
        appCredentials.gender = ""
        appCredentials.email = ""
        appCredentials.isFirstTimeOpenHome = false
        appCredentials.isUserLogin = false
        appCredentials.isFirstTimeOpenShpoingList = false
        appCredentials.accessToken = ""
        appCredentials.catalogSelectedTab = "product"
        appCredentials.isFirstTimeLunch = false
    }
}
