//
//  NetworkModels.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 06/07/2023.
//

import UIKit

// MARK: - SignupModel...
class SignupModel: Codable {
    let status: Bool?
    let message: String?
    let user: User?
    let tokens: Tokens?
    
    init(status: Bool?, message: String?, user: User?, tokens: Tokens?) {
        self.status = status
        self.message = message
        self.user = user
        self.tokens = tokens
    }
}

// MARK: - Tokens
class Tokens: Codable {
    let accessToken: AccessToken?
}

// MARK: - AccessToken
class AccessToken: Codable {
    let token, expires: String?
}

// MARK: - User
class User: Codable {
    let ino, firstName, lastName, email, travelExperience, status, id, dob, gender, lastLogin, lastPasswordUpdate: String?
    let authProviders: [String]?
    let address: Address?
    let allowNotify: Bool
}

// MARK: - Address
class Address: Codable {
    let country, city: String?
}



//MARK: -----------------------

//MARK: -  BaseModel...
class BaseModel: Codable {
    let status: Bool?
    let message: String?
}


//MARK: -----------------------

//MARK: - ForgotPasswordModel...
class ForgotPasswordModel: Codable {
    let status: Bool?
    let message: String?
    let tokens: Tokens?
}


//MARK: -----------------------
//MARK: - Google Api Response...

///searchPlaceFromGoogleBaseResponse...
struct searchPlaceFromGoogleBaseResponse : Codable {
    let status, next_page_token: String?
    let results : [SearchPlaceFromGoogleResults]?
    
}

///SearchPlaceFromGoogleResults..
struct SearchPlaceFromGoogleResults : Codable {
    let icon, reference, icon_mask_base_uri, icon_background_color, place_id, formatted_address, name, business_status : String?
    let types : [String]?
    let geometry : Geometry?
    let photos : [Photos]?
    let user_ratings_total : Int?
    let rating : Double?
    let opening_hours : Opening_hours?
}

///Photos...
struct Photos : Codable {
    let width, height : Int?
    let html_attributions : [String]?
    let photo_reference : String?
}

///Opening_hours...
struct Opening_hours : Codable {
    let open_now : Bool?
    enum CodingKeys: String, CodingKey { case open_now = "open_now" }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        open_now = try values.decodeIfPresent(Bool.self, forKey: .open_now)
    }
}

///Geometry...
struct Geometry : Codable {
    let bounds : Bounds?
    let location : Location?
    let location_type : String?
    let viewport : Viewport?
    
}

///Location...
struct Location : Codable {
    let lat, lng : Double?
}

///Bounds...
struct Bounds : Codable {
    let northeast, southwest : Northeast?
}

///Northeast...
struct Northeast : Codable {
    let lat, lng : Double?
}

///Southwest...
struct Southwest : Codable {
    let lat, lng : Double?
}

///Viewport...
struct Viewport : Codable {
    let northeast, southwest : Northeast?
}


//MARK: -----------------------

// MARK: - UserBaseModel...
class UserBaseModel: Codable {
    let status: Bool?
    let message: String?
    let user: User?
    let tokens: Tokens?
}



//MARK: -----------------------

// MARK: - Blogs...
class BlogsBaseModel: Codable {
    let status: Bool?
    let blogs: Blogs?
}


// MARK: - Blogs...
class Blogs: Codable {
    let page, limit, totalPages, totalResults: Int
    let results: [BlogResults]?
}


// MARK: - Blogs...
class BlogResults: Codable {
    let name, keywords, url, status, createdAt, updatedAt, id, thumbnail: String?
}


//MARK: -----------------------

// MARK: - Blogs...
class CountriesBaseModel: Codable {
    let status: Bool?
    let countries: [Countries]?
}

//MARK: - Countries...
class Countries: Codable {
    let name, code, flag: String?
}

//MARK: -----------------------

//MARK: - EmbassiesListBaseModel...
struct EmbassiesListBaseModel : Codable {
    let status : Bool?
    let data : DataModel?
}

//MARK: - Data...
struct DataModel : Codable {
    let country : Country?
    let id : String?
    let embassies : [Embassies]?
}


//MARK: - Country...
struct Country : Codable {
    let name, code, flag : String?
}

//MARK: - Embassies...
struct Embassies : Codable {
    let id, locationType, name, address, city, websiteUrl : String?
    let phoneNumbers, emergencyContacts, emails, hours, consularNeeds : [String]?
    let destinationCountry : DestinationCountry?
}

//MARK: - DestinationCountry...
struct DestinationCountry : Codable {
    let name, code, flag : String?
}

//MARK: -----------------------

//MARK: - GeocodingResponse
struct GeocodingResponse: Codable {
    let results: [GeocodingResult]?
    let status: String?
}

//MARK: - GeocodingResult...
struct GeocodingResult: Codable {
    let address_components: [AddressComponent]?
    let formatted_address, placeID: String?
    let geometry: Geometry?
    let types: [String]?
}

//MARK: - AddressComponent...
struct AddressComponent: Codable {
    let long_name, short_name: String?
    let types: [String]?
}


//MARK: -----------------------

//MARK: - CategoriesBaseModel...
struct CategoriesBaseModel : Codable {
    let status : Bool?
    let categories : [Categories]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case categories = "categories"
    }
}

//MARK: -  Categories....
struct Categories : Codable {
    let name, slug, type, parent, id : String?
    let icon : Icon?
}

//MARK: - Icon...
struct Icon : Codable {
    let activeIcon, inactiveIcon, gif, type, id : String?
}


//MARK: -----------------------

//MARK: - ProductsBaseModel...
struct ProductsBaseModel : Codable {
    let status : Bool?
    let products : Products?
}

//MARK: - services
struct ServicesBaseModel : Codable {
    let status : Bool?
    let services : Products?
}

//MARK: - Products...
struct Products : Codable {
    let results : [ProductsResults]?
    let page, limit, totalPages, totalResults : Int?
}

//MARK: - ProductsResults...
struct ProductsResults : Codable {
    let ino, directUrl, status, name, brand, description, imageUrl, affiliateUrl, featuredStartDate, featuredEndDate, id, recommendationText : String?
    //let youtubeUrls, socialLinks : [String]?
    //let notes: [Notes]?
    let isRecommended : Bool?
    let rating : Int?
}

//MARK: - Notes...
struct Notes: Codable {
    let text: String?
}


//MARK: -----------------------

//MARK: - FavouritesBaseModel...
struct FavouritesBaseModel: Codable {
    let status: Bool?
    let favourites: Favourites?
}

//MARK: - Favourites...
struct Favourites: Codable {
    let results: [Favourite]?
    let page: Int?
    let limit: Int?
    let totalPages: Int?
    let totalResults: Int?
}

//MARK: - Favourite...
struct Favourite: Codable {
    let user: String?
    let type: String?
    let item: ProductsResults?
    let onModel: String?
    let addOn: String?
    let id: String?
}

//MARK: -----------------------

//MARK: - FavouritesIdsBaseModel...
struct FavouritesIdsBaseModel: Codable {
    let status: Bool?
    let favourites: [FavouritesIds]?
}

//MARK: - FavouritesIds...
struct FavouritesIds: Codable {
    let type, item: String?
}


//MARK: -----------------------

//MARK: - shoppingListBaseModel...
struct shoppingListBaseModel: Codable {
    let status : Bool?
    let shoppingList : ShoppingList?
}


//MARK: - ShoppingList...
struct ShoppingList : Codable {
    let results : [ShoppingListResults]?
    let page : Int?
    let limit : Int?
    let totalPages : Int?
    let totalResults : Int?
}

//MARK: - ShoppingListResults...
struct ShoppingListResults : Codable {
    let items : [ShoppingListItems]?
    let trip : String?
    let name : String?
    let status : String?
    let createdBy : String?
    let createdAt : String?
    let updatedAt : String?
    let id : String?
}

//MARK: - ShoppingListItems
struct ShoppingListItems : Codable {
    let product : String?
    let name : String?
    let isChecked : Bool?
    let isCustom : Bool?
    let id : String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        product = try container.decodeIfPresent(String.self, forKey: .product) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name)
        isChecked = try container.decodeIfPresent(Bool.self, forKey: .isChecked)
        isCustom = try container.decodeIfPresent(Bool.self, forKey: .isCustom)
        id = try container.decodeIfPresent(String.self, forKey: .id)
    }
}


//MARK: -----------------------

//MARK: - shoppingListAddItemBaseModel...
struct shoppingListAddItemBaseModel: Codable {
    let status : Bool?
    let shoppingList : ShoppingListResults?
}

//MARK: -----------------------

//MARK: - checkAllItemsList...
struct checkAllItemsListBaseResponse: Codable {
    let status : Bool?
    let shoppingList : ShoppingListResults?
}

//MARK: -----------------------
 
//MARK: - TripResponse...
struct TripResponse: Codable {
    let status: Bool?
    let trip: Trip?
}

//MARK: - Trip...
struct Trip: Codable {
    let location: TripLocation?
    let name: String?
    let image: String?
    let startDate: String?
    let endDate: String?
    let tripType: String?
    let tripStats: TripStats?
    
    //    let packingList: [String]
    //    let preparationList: [String]
    //    let weather: [String]
    let itemStats: ItemStats?
    let status: String?
    let id: String?
}

//ItemStats...
struct ItemStats: Codable {
    let packing: ItemStatsPacking?
    let preparation: ItemStatsPreparation?
}

//ItemStatsPacking...
struct ItemStatsPacking: Codable {
    let toPackTotal: Int?
    let toBuy: Int?
    let priority: Int?
    let completedPercentage: Int?
    let seeMore: Int?
    let toPackList: [String]?
}

//ItemStatsPreparation...
struct ItemStatsPreparation: Codable {
    let toPrepareTotal: Int?
    let alert: Int?
    let priority: Int?
    let completedPercentage: Int?
    let seeMore: Int?
    let toPrepareList: [String]?
}

//MARK: - TripLocation...
struct TripLocation: Codable {
    let country: String?
    let city: String?
    let lat: Double?
    let lng: Double?
}

//MARK: - TripStats...
struct TripStats: Codable {
    let purposes: [String]?
    let accommodations: [TransportMode]?
    let transportModes: [TransportMode]?
    let customTransportMode: String?
    let requiresLaundry: Bool?
    let hasPets: Bool?
    let petCareTasks: Int?
    let additionalTasks: [Int]?
    let activities: [String]?
    let travellingWith: [String]?
    let savePackingList: Bool?
}

//MARK: - TransportMode...
struct TransportMode: Codable {
    let key: String?
    let isPersonal: Bool?
    let isRental: Bool?
}

//MARK: -----------------------


//MARK: - AllTripResponse...
struct AllTripBaseResponse: Codable {
    let status: Bool?
    let trips: TripResult?
}

//MARK: - TripResult...
struct TripResult: Codable {
    let results: [Trip]?
    let page: Int?
    let limit: Int?
    let totalPages: Int?
    let totalResults: Int? 
}


//MARK: -----------------------

//MARK: - WeatherBaseResponse
struct WeatherBaseResponse: Codable {
    let status: Bool?
    let weatherList: [WeatherData]?
}

//MARK: - WeatherData...
struct WeatherData: Codable {
    let location: WeatherLocation?
    let dayName: String?
    let date: String?
    let minTem: Double?
    let maxTem: Double?
    let condition: Condition?
}

///WeatherLocation...
struct WeatherLocation: Codable {
    let name: String?
    let country: String?
}

///Condition...
struct Condition: Codable {
    let text: String?
    let icon: String?
    let code: Int?
}

//MARK: -----------------------


//MARK: - TextCompletionResponse...
struct TextCompletionResponse: Codable {
    let warning: String
    let object: String
    let choices: [Choice]
}

//MARK: - Choice...
struct Choice: Codable {
    let text: String
}

//MARK: - DestiNationCards...
struct DestiNationCards {
    let tag: Int 
    let headerMsg: String
    let image: String
    let queryMsg: String
}

//MARK: -----------------------

//MARK: - AllTripResponse...
struct QucikListBaseResponse: Codable {
    let status: Bool?
    let trip: Trip?
}


//MARK: -----------------------
 
//MARK: - CategoryBaseModel...
struct CategoryBaseModel: Codable {
    let status: Bool?
    let categoryList: [PackingOrPackingCategory]?
}

//MARK: - Category...
struct PackingOrPackingCategory: Codable {
    let id, name, adminCategoryId: String?
    let icon: Icon?
}

//MARK: -----------------------

//MARK: - PackingListResponse...
struct PackingListResponse: Codable {
    let status: Bool?
    let list: [PackingItem]?
}
 
///PackingItem...
struct PackingItem: Codable {
    let primaryCategory: PackingOrPackingCategory?
    let secondaryCategory: PackingOrPackingCategory?
    let id: String?
    let itemId: String?
    let name: String?
    let description: String?
    let proTip: String?
    let quantity: Int?
    let isRecommended: Bool?
    let bagType: String?
    var isChecked: Bool?
    let isCustom: Bool?
    let priority: Bool?
    let toBuy: Bool?
    let notify: String?
}

 

 //MARK: - CategoriesWithItems...
struct CategoriesWithItems {
    let id: String?
    let name: String?
    let adminCategoryId: String?
    let icon: Icon?
    var items: [PackingItem]?
}

///DropDownCategoryList..
struct DropDownCategoryList {
    let categoryName: String?
    let categoryImgUrl: String?
    let categoryId: String?
}


//MARK: - WeatherBaseData... 
struct HoursWeatherBaseResponse: Codable {
    let status: Bool?
    let weather: [WeatherInfo]?
}

struct WeatherInfo: Codable {
    let date: String?
    let day: DayInfo?
    let astro: AstroInfo?
    let hour: [HourlyInfo]?
    let location: LocationInfo?
    let dayName: String?
}

struct DayInfo: Codable {
    let maxtemp_c: Double?
    let maxtemp_f: Double?
    let mintemp_c: Double?
    let mintemp_f: Double?
    let avgtemp_c: Double?
    let avgtemp_f: Double?
    let maxwind_mph: Double?
    let maxwind_kph: Double?
    let totalprecip_mm: Double?
    let totalprecip_in: Double?
    let avgvis_km: Double?
    let avgvis_miles: Double?
    let avghumidity: Int?
    let condition: ConditionInfo?
    let uv: Int?
}

struct ConditionInfo: Codable {
    let text: String?
    let icon: String?
    let code: Int?
}

struct AstroInfo: Codable {
    let sunrise: String?
    let sunset: String?
    let moonrise: String?
    let moonset: String?
    let moon_phase: String?
    let moon_illumination: String?
}

struct HourlyInfo: Codable {
    let time_epoch: Int?
    let time: String?
    let temp_c: Double?
    let temp_f: Double?
    let condition: ConditionInfo?
    let wind_mph: Double?
    let wind_kph: Double?
    let wind_degree: Int?
    let wind_dir: String?
    let pressure_mb: Double?
    let pressure_in: Double?
    let precip_mm: Double?
    let precip_in: Double?
    let humidity: Int?
    let cloud: Int?
    let feelslike_c: Double?
    let feelslike_f: Double?
    let windchill_c: Double?
    let windchill_f: Double?
    let heatindex_c: Double?
    let heatindex_f: Double?
    let dewpoint_c: Double?
    let dewpoint_f: Double?
    let will_it_rain: Int?
    let chance_of_rain: Int?
    let will_it_snow: Int?
    let chance_of_snow: Int?
    let vis_km: Double?
    let vis_miles: Double?
    let gust_mph: Double?
    let gust_kph: Double?
    let uv: Int?
}

struct LocationInfo: Codable {
    let name: String?
    let region: String?
    let country: String?
    let lat: Double?
    let lon: Double?
    let tz_id: String?
    let localtime_epoch: Int?
    let localtime: String?
}





