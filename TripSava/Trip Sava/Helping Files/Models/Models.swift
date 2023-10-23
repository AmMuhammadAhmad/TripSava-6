//
//  Models.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 06/06/2023.
//

import UIKit

//MARK: - OnBoardingModel...
struct OnBoardingModel {
    let bgImgName: String
    let onBoardImgName: String
    let title: String
    let subHeading: String
    let buttonTxtColor: UIColor
    
}

//MARK: - TripModel...
struct TripModel {
    let name: String
    let categoryImage: String
    let tripImg: String
    let tripType: String
    let location: String
    let formatedDate: String
    let endInDays: String
    let toBuy: String
    let packed: String
    let taskLeft: String
    let isArchived: Bool 
}

//MARK: - ShoppingListModel...
struct ShoppingListModel {
    var name: String
    var list: [String]
}

//MARK: - ScamsModel...
struct ScamsModel { 
    let image: String
    let headerTitle: String
    let reportBtnTitle: String
}


//MARK: - EmbassiesModel...
struct EmbassiesModel {
    let flag: String
    let name: String
}

//MARK: - CheckListModel...
struct CheckListModel {
    let name: String
    let imgName: String
    let pdfFileName: String
    let index: Int
}

//MARK: - TripData...
struct TripData {
    var tripWizardStep1: TripWizardStep1?
    var tripWizardStep2: TripWizardStep2?
    var tripWizardStep3: TripWizardStep3?
}

//MARK: - TripWizardStep1...
struct TripWizardStep1 {
    var city: String?
    var country: String?
    var lat: Double?
    var long: Double?
    var tripName: String?
    var tripStratDate: Date?
    var tripEndData: Date?
    var dateRanges: [Date]?
}

///TripWizardStep2...
struct TripWizardStep2 {
    var purpose: [String]?
    var accommodation: [TransportMode]?
    var transportation: [TransportMode]?
    var customTransportation: String?
}

///TripWizardStep3...
struct TripWizardStep3 {
    var laundryPlan: Bool?
    var petsTraveling: Bool?
    var packingAndPreparingListForPet: Int?
    var optionalPreparationTasksList: [Int]?
}

//MARK: - QuickListImages...
struct QuickListImages {
    let tag: Int
    let url: String
}


//MARK: - PreprationData
struct PreprationData {
    let imageUrl: String
    let title: String
}


//MARK: - UvStackViewData...
struct UvStackViewData { 
    let detail: String
}

//MARK: - TabBarBadgeUpdater...
protocol TabBarBadgeUpdater: AnyObject {
    func updateBadgeValue(_ value: String?, forTabAtIndex index: Int)
}


//MARK: - UvInfo...
struct UvInfo {
    let index: [Int]
    var UVHeaderText: String
    let detailsText: [String]
}

//MARK: - AddItemForPrepration...
struct AddItemForPrepration {
    var name: String?
    var timeline: String?
    var primaryCategory: String?
    var description: String?
    var alert: String?
    var priority: Bool?
}

//MARK: - AddItemForPacking....
struct AddItemForPacking {
    var name: String?
    var primaryCategory: String?
    var description: String?
    var addToShoppingList: Bool?
    var priority: Bool?
    var quantity: Int?
}

//MARK: - AddItemForPacking....
struct AddItemForCategory{
    var name: String?
    var icon: String?
    var type: String?
}
