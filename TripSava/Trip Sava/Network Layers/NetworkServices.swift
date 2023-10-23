//
//  NetworkServices.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 06/07/2023.
//

import Moya

//MARK: - Services...
enum NetworkServices {
    
    case signUp(firstName: String, lastName: String, email: String, gender: String, city: String, country: String, travelExperience: String, password:String, dob: String)
    case updateProfile(firstName: String, lastName: String, dob: String, gender: String, city: String, country: String)
    case login(email: String, password: String)
    case sendOptForForgotPassword(email: String)
    case verifyOTPCode(otp: String, forgotAccessToken: String)
    case resetPassword(password: String, forgotAccessToken: String)
    case logout(token: String)
    case updateEmail(email: String)
    case searchPlaceFromGoogle(place: String)
    case updateNotificationsAlert(allowNotify: Bool)
    case updatePassword(currentPassword: String, newPassword: String)
    case getCountryEmbassy(countryCode: String)
    case getSelectedCountryEmbassiesDetails(sourceCountry: String, destinationCountry: String)
    case getGeoCodingSearchApi(address: String)
    case getCategories(type: String, parent: String)
    case getProducts(primaryCategory: String, secondaryCategory: String, name: String, isFeatured: Bool)
    case getServices(primaryCategory: String, secondaryCategory: String, name: String, isFeatured: Bool)
    case addNewItemIntoShoppingList(trip: String, product: String, name: String, isCustom: Bool)
    case updateShoppingListItem(name: String, isChecked: Bool, shoppingListId: String, itemId: String)
    case deleteShoppinhListItem(shoppingListId: String, itemId: String)
    case updateUserfavourite(item: String, type: String)
    case createQuickList(name: String, image: String, startDate: String, endDate: String)
    case createPackingList(tripId: String, activities: [String], travellingWith: [String])
    case getPackingOrPreprationCategories(tripId: String, type: String)
    case getPackingOrPreprationCategoriesAndItems(tripId: String, type: String)
    case addNewItemOnCategoryOrPackingOrPrepration(tripId: String, type: String, params: [String: Any])
    case checkAllItemsOfList(listId: String)
    case updateQuickList(tripId: String, name: String, image: String, startDate: String, endDate: String)
    case updatePackingList(tripId: String, categoryId: String, itemId: String, listType: String, isChecked: Bool, quantity: Int, bagType: String, priority: Bool, isToBuy: Bool, toBuy: Bool, primaryCategory: String)
    case getFavourites(type: String)
    case deleteShoppingList(listId: String)
    case createTripWizard(params: [String: Any])
    case getAllTrips(page: Int, limit: Int, searchText: String)
    case getTripWeather(tripId: String)
    case getTripWeatherDetails(tripId: String, date: String)
    case getChatGtpMessage(query: String)
    case deleteTrip(tripId: String)
    case updateTrip(tripId: String, params: [String: Any])
    case archiveQuicklist(tripId: String)
    case getFavoritesIDS
    case getBlogs
    case getCountries
    case getShoppingList
    case deleteAccount
    
}


//MARK: - MoyaProvider protocol...

//MARK: - TargetType...
extension NetworkServices: TargetType {
    
    //MARK: - baseURL...
    var baseURL: URL {
        switch self {
            
            ///App Base Url
        case .signUp, .login, .logout, .updateProfile, .updateEmail, .sendOptForForgotPassword, .verifyOTPCode, .resetPassword, .updateNotificationsAlert, .deleteAccount, .updatePassword, .getBlogs, .getCountries, .getCountryEmbassy, .getSelectedCountryEmbassiesDetails, .getCategories, .getProducts, .getServices, .getFavourites, .updateUserfavourite, .getFavoritesIDS, .getShoppingList, .addNewItemIntoShoppingList, .updateShoppingListItem, .checkAllItemsOfList, .deleteShoppingList, .deleteShoppinhListItem, .createTripWizard, .getAllTrips, .getTripWeather, .createQuickList, .createPackingList, .getPackingOrPreprationCategories, .deleteTrip, .updateTrip, .archiveQuicklist, .updateQuickList, .getPackingOrPreprationCategoriesAndItems, .updatePackingList, .getTripWeatherDetails, .addNewItemOnCategoryOrPackingOrPrepration:
            return URL(string: Constants.API.appLiveBaseUrl)!
            
            ///Google APi Base url
        case .searchPlaceFromGoogle:
            return URL(string: Constants.API.googleMapTextSearchBaseUrl)!
            
            ///GeoCoading Base url
        case .getGeoCodingSearchApi:
            return URL(string: Constants.API.geoCoadingUrl)!
            
            ///Chat GTP Base Url...
        case .getChatGtpMessage:
            return URL(string: Constants.API.chatGTPBaseUrl)!
        }
    }
    
    //MARK: - paths...
    var path: String {
        switch self {
        case .signUp: return "auth/register"
        case .login: return "auth/login"
        case .logout: return "auth/logout"
        case .updateProfile: return "users/profile"
        case .updateEmail: return "users/email"
        case .sendOptForForgotPassword: return "auth/forgot-password"
        case .verifyOTPCode: return "auth/verify-code"
        case  .resetPassword: return "auth/reset-password"
        case .searchPlaceFromGoogle: return "textsearch/json"
        case .updateNotificationsAlert: return "users/notification-alert"
        case .deleteAccount: return "users/account"
        case .updatePassword: return "users/password"
        case .getBlogs: return "blogs"
        case .getCountries: return "embassies/countries"
        case .getGeoCodingSearchApi: return "geocode/json"
        case .getCategories: return "categories"
        case .getProducts: return "products/query"
        case .getServices: return "services/query"
        case .getFavourites: return "users/favourites/details"
        case .getShoppingList: return "shopping-list"
        case .getAllTrips: return "trips"
        case .getChatGtpMessage: return "completions"
        case .addNewItemIntoShoppingList: return "shopping-list/items"
        case .updateUserfavourite, .getFavoritesIDS: return "users/favourites"
        case .createQuickList: return "trips/quicklist"
        case .createTripWizard: return "trips/wizard"
        case .updateTrip(tripId: let tripId, params: _): return "trips/\(tripId)"
        case .deleteTrip(tripId: let tripId): return "trips/\(tripId)"
        case .archiveQuicklist(tripId: let tripId): return "trips/quicklist/\(tripId)/archive"
        case .getTripWeather(tripId: let tripId): return "trips/\(tripId)/weather-list"
        case .getTripWeatherDetails(tripId: let tripId, date: let date): return "trips/\(tripId)/weather-list/\(date)"
        case .deleteShoppingList(listId: let listId): return "shopping-list/\(listId)"
        case .checkAllItemsOfList(listId: let listId): return "shopping-list/\(listId)/check-all"
        case .getPackingOrPreprationCategories(tripId: let tripId, type: _): return "trips/\(tripId)/categories"
        case .getPackingOrPreprationCategoriesAndItems(tripId: let tripId, type: let type): return "trips/\(tripId)/\(type)"
        case .createPackingList(tripId: let tripId, activities: _, travellingWith: _): return "trips/\(tripId)/packing-list/init"
        case .updateQuickList(tripId: let tripId, name: _, image: _, startDate: _, endDate: _): return "trips/quicklist/\(tripId)"
        case .addNewItemOnCategoryOrPackingOrPrepration(tripId: let tripId, type: let type, params: _): return "trips/\(tripId)/\(type)"
        case .deleteShoppinhListItem(shoppingListId: let shoppingListId, itemId: let itemId): return "shopping-list/\(shoppingListId)/items/\(itemId)"
        case .getCountryEmbassy(countryCode: let countryCode): return "embassies/countries/\(countryCode)/embassy-countries"
        case .getSelectedCountryEmbassiesDetails(sourceCountry: let sourceCountry, destinationCountry: let destinationCountry):
            return "embassies/countries/\(sourceCountry)/embassy-list/\(destinationCountry)"
        case .updateShoppingListItem(name: _, isChecked: _, shoppingListId: let shoppingListId, itemId: let itemId):
            return "shopping-list/\(shoppingListId)/items/\(itemId)"
        case .updatePackingList(tripId: let tripId, categoryId: let categoryId, itemId: let itemId, listType: let listType, isChecked: _, quantity: _, bagType: _, priority: _, isToBuy: _, toBuy: _, primaryCategory: _): return "trips/\(tripId)/\(listType)/categories/\(categoryId)/items/\(itemId)/edit"
             
        }
    }
    
    //MARK: - Method...
    var method: Method {
        switch self {
            
            /// GET...
        case .searchPlaceFromGoogle, .getBlogs, .getCountries, .getCountryEmbassy, .getSelectedCountryEmbassiesDetails, .getGeoCodingSearchApi, .getCategories, .getProducts, .getServices, .getFavourites, .getFavoritesIDS, .getShoppingList, .getAllTrips, .getTripWeather, .getPackingOrPreprationCategories, .getPackingOrPreprationCategoriesAndItems, .getTripWeatherDetails: return .get
            
            /// POST...
        case .signUp, .login, .logout, .sendOptForForgotPassword, .verifyOTPCode, .resetPassword, .updateUserfavourite, .addNewItemIntoShoppingList, .createTripWizard, .getChatGtpMessage, .createQuickList, .createPackingList, .addNewItemOnCategoryOrPackingOrPrepration: return .post
            
            /// PUT...
        case .updateProfile, .updateEmail, .updateNotificationsAlert, .updatePassword, .updateShoppingListItem, .checkAllItemsOfList, .updateTrip, .archiveQuicklist, .updateQuickList, .updatePackingList: return .put
            
            /// Delete
        case .deleteAccount, .deleteShoppingList, .deleteShoppinhListItem, .deleteTrip: return .delete
            
        }
    }
    
    //MARK: - sampleData...
    var sampleData: Data { return Data() }
    
    //MARK: - Task...
    var task: Task {
        switch self {
            
            //MARK: - signUp...
        case .signUp(firstName: let firstName, lastName: let lastName, email: let email, gender: let gender, city: let city, country: let country, travelExperience: let travelExperience, password: let password, dob: let dob):
            let addressParameters = ["city": city, "country": country]
            let parameter = [ "firstName": firstName,
                              "lastName": lastName,
                              "email": email,
                              "gender": gender,
                              "address": addressParameters,
                              "travelExperience": travelExperience,
                              "dob": dob,
                              "password": password ] as [String : Any]
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
            
            //MARK: - login...
        case .login(email: let email, password: let password):
            let parameter = [ "email": email,
                              "password": password ] as [String : Any]
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
            
            //MARK: - logout...
        case .logout(token: let token):
            let parameter = [ "accessToken": token ] as [String : Any]
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
            
            //MARK: - updateProfile...
        case .updateProfile(firstName: let firstName, lastName: let lastName, dob: let dob, gender: let gender, city: let city, country: let country):
            let addressParameters = ["city": city, "country": country]
            let parameter = [ "firstName": firstName,
                              "lastName": lastName,
                              "dob": dob,
                              "gender": gender,
                              "address": addressParameters ] as [String : Any]
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
            
            //MARK: - updateEmail...
        case .updateEmail(email: let email):
            let parameter = [ "email": email ] as [String : Any]
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
            
            ///sendOptForForgotPassword...
        case .sendOptForForgotPassword(email: let email):
            let parameter = [ "email": email ] as [String : Any]
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
            
            //MARK: -  verifyOTPCode...
        case .verifyOTPCode(otp: let otp, forgotAccessToken: _):
            let parameter = [ "code": otp ] as [String : Any]
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
            
            //MARK: - resetPassword...
        case .resetPassword(password: let password, forgotAccessToken: _):
            let parameter = [ "password": password ] as [String : Any]
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
            
            //MARK: - SearchPlaceFromGoogle...
        case .searchPlaceFromGoogle(place: let place):
            let parameter = [ "query": place,
                              "key": Constants.API.googleMapKey ]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
            
            //MARK: - updateNotificationsAlert...
        case .updateNotificationsAlert(allowNotify: let allowNotify):
            let parameter = [ "allowNotify": allowNotify ]
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
            
            //MARK: - updatePassword...
        case .updatePassword(currentPassword: let currentPassword, newPassword: let newPassword):
            let parameter = [ "currentPassword": currentPassword,
                              "newPassword": newPassword ]
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
            
            //MARK: - getGeoCodingSearchApi...
        case .getGeoCodingSearchApi(address: let address):
            let parameter = [ "address": address,
                              "key": Constants.API.googleMapKey ]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
            
            //MARK: - getCategories...
        case .getCategories(type: let type, parent: let parent):
            let parameter = [ "type": type,
                              "parent": parent ]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
            
            //MARK: - getProducts...
        case .getProducts(primaryCategory: let primaryCategory, secondaryCategory: let secondaryCategory, name: let name, isFeatured: let isFeatured):
            let parameter = [ "primaryCategory": primaryCategory,
                              "secondaryCategory": secondaryCategory,
                              "name": name,
                              "isFeatured": isFeatured ] as [String : Any]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
            
            //MARK: - getServices...
        case .getServices(primaryCategory: let primaryCategory, secondaryCategory: let secondaryCategory, name: let name, isFeatured: let isFeatured):
            let parameter = [ "primaryCategory": primaryCategory,
                              "secondaryCategory": secondaryCategory,
                              "name": name,
                              "isFeatured": isFeatured ] as [String : Any]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
            
            //MARK: - getFavourites...
        case .getFavourites(type: let type):
            let parameter = [ "type": type ]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
            
            //MARK: - updateUserfavourite...
        case .updateUserfavourite(item: let item, type: let type):
            let parameter = [ "item": item,
                              "type": type ]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
            
            //MARK: - getBlogs...
        case .getBlogs:
            let parameter = [ "status": "released" ]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
            
            //MARK: - addNewItemIntoShoppingList...
        case .addNewItemIntoShoppingList(trip: let trip, product: let product, name: let name, isCustom: let isCustom):
            let parameter = [ "trip": trip,
                              "product": product,
                              "name": name,
                              "isCustom": isCustom ] as [String : Any]
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
            
            
            //MARK: - updateShoppingListItem...
        case .updateShoppingListItem(name: let name, isChecked: let isChecked, shoppingListId: _, itemId: _):
            let parameter = [ "name": name,
                              "isChecked": isChecked ] as [String : Any]
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
            
            //MARK: - createTripWizard...
        case .createTripWizard(params: let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
            //MARK: - getAllTrips...
        case .getAllTrips(page: let page, limit: let limit, searchText: let searchText):
            let parameter = [ "page": page,
                              "limit": limit,
                              "searchText": searchText ] as [String : Any]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
            
            //MARK: - getChatGtpMessage...
        case .getChatGtpMessage(query: let query):
            let parameters = [ "prompt": query,
                               "model": "text-davinci-003",
                               "max_tokens": 200 ] as [String: Any]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
            //MARK: - createQuickList...
        case .createQuickList(name: let name, image: let image, startDate: let startDate, endDate: let endDate):
            let parameter = [ "name": name,
                              "image": image,
                              "startDate": startDate,
                              "endDate": endDate ] as [String : Any]
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
            
            //MARK: - createPackingList...
        case .createPackingList(tripId: _, activities: let activities, travellingWith: let travellingWith):
            let parameter = [ "activities": activities,
                              "travellingWith": travellingWith ] as [String : Any]
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
            
            //MARK: - getPackingOrPreprationCategories...
        case .getPackingOrPreprationCategories(tripId: _, type: let type):
            let parameter = [ "type": type ]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
            
            //MARK: - updateTrip...
        case .updateTrip(tripId: _, params: let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
            //MARK: - updateQuickList
        case .updateQuickList(tripId: _, name: let name, image: let image, startDate: let startDate, endDate: let endDate):
            let parameter = [ "name": name,
                              "image": image,
                              "startDate": startDate,
                              "endDate": endDate ] as [String : Any]
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
            
            ///updatePackingList...
        case .updatePackingList(tripId: _, categoryId: _, itemId: _, listType: _, isChecked: let isChecked, quantity: let quantity, bagType: let bagType, priority: let priority, isToBuy: let isToBuy, toBuy: let toBuy, primaryCategory: let primaryCategory):
            let parameter = [ "isChecked": isChecked,
                              "quantity": quantity,
                              "bagType": bagType,
                              "priority": priority,
                              "isToBuy": isToBuy,
                              "toBuy": toBuy,
                              "primaryCategory": primaryCategory ] as [String : Any]
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
            
            
            //MARK: - addNewItemOnCategoryOrPackingOrPrepration...
        case .addNewItemOnCategoryOrPackingOrPrepration(tripId: _, type: _, params: let params):
            let parameter = params
            return .requestParameters(parameters: parameter, encoding: JSONEncoding.default)
            
            //MARK: - requestPlain...
        case .deleteAccount, .getCountries, .getCountryEmbassy, .getSelectedCountryEmbassiesDetails, .getFavoritesIDS, .getShoppingList, .checkAllItemsOfList, .deleteShoppingList, .deleteShoppinhListItem, .getTripWeather, .deleteTrip, .archiveQuicklist, .getPackingOrPreprationCategoriesAndItems, .getTripWeatherDetails:
            return .requestPlain
            
            
            
        
        }
        
    }
    
    
    
    //MARK: - headers....
    var headers: [String : String]? {
        switch self {
            
            ///Nil...
        case .signUp, .login, .logout, .sendOptForForgotPassword, .searchPlaceFromGoogle, .getBlogs, .getCountries, .getCountryEmbassy, .getSelectedCountryEmbassiesDetails, .getGeoCodingSearchApi, .getCategories, .getProducts, .getServices: return nil
            
            ///Authorization with token only...
        case .updateProfile, .updateEmail, .updateNotificationsAlert, .deleteAccount, .updatePassword, .getFavourites, .updateUserfavourite, .getFavoritesIDS, .getShoppingList, .addNewItemIntoShoppingList, .updateShoppingListItem, .checkAllItemsOfList, .deleteShoppingList, .deleteShoppinhListItem, .getTripWeather, .createQuickList, .createPackingList, .getPackingOrPreprationCategories, .deleteTrip, .updateTrip, .archiveQuicklist, .updateQuickList, .getPackingOrPreprationCategoriesAndItems, .updatePackingList, .getTripWeatherDetails, .addNewItemOnCategoryOrPackingOrPrepration:
            return ["Authorization": ("Bearer ") + (appCredentials.accessToken ?? "")]
            
            ///verifyOTPCode...
        case .verifyOTPCode(otp: _, forgotAccessToken: let forgotAccessToken):
            return ["Authorization": ("Bearer ") + (forgotAccessToken)]
            
            ///resetPassword...
        case .resetPassword(password: _, forgotAccessToken: let forgotAccessToken):
            return ["Authorization": ("Bearer ") + (forgotAccessToken)]
            
            ///Authorization with token and content type...
        case .createTripWizard, .getAllTrips:
            return [ "Authorization": ("Bearer ") + (appCredentials.accessToken ?? ""), "Content-type": "application/json"]
            
            /// ChatGtp Tokem...
        case .getChatGtpMessage:
            return ["Authorization": ("Bearer ") + (Constants.API.ChatGTPKeyKey)]
        }
    }
    
    
}



