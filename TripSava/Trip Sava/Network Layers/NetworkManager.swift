//
//  NetworkManager.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 06/07/2023.
//

import UIKit
import Moya

//MARK:- TripSava Moya Provider SetUp...
struct tripSavaServicesProvider {
    
    //MARK: - Variables...
    static let provider = MoyaProvider<NetworkServices>()
    
    //MARK: - Functions...
    ///performRequest...
    static func performRequest<T: Decodable>(_ target: NetworkServices, responseType: T.Type, completion: @escaping (APIResult<T>) -> Void) {
        tripSavaServicesProvider.provider.request(target) { result in
            switch result {
            case .success(let response):
                do { let result = try JSONDecoder().decode(T.self, from: response.data); completion(.success(result)) }
                catch { let errorMessage = "Failed to decode response."; completion(.failure(errorMessage)) }
            case .failure(let error): completion(.failure(error.localizedDescription))
            }
        }
    }
}


//MARK:- Services Manager...
struct TripSavaNetworkingManager {
    
    //MARK: - signUp...
    func signUp(firstName: String, lastName: String, email: String, gender: String, city: String, country: String, travelExperience: String, password: String, dob: String, completion: @escaping (APIResult<SignupModel>) -> Void) {
        let target = NetworkServices.signUp(firstName: firstName, lastName: lastName, email: email, gender: gender, city: city, country: country, travelExperience: travelExperience, password: password, dob: dob)
        tripSavaServicesProvider.performRequest(target, responseType: SignupModel.self, completion: completion)
    }
    
    //MARK: - login...
    func login(email: String, password: String, completion: @escaping (APIResult<SignupModel>) -> Void) {
        let target = NetworkServices.login(email: email, password: password)
        tripSavaServicesProvider.performRequest(target, responseType: SignupModel.self, completion: completion)
    }
    
    //MARK: - logout...
    func logout(token: String, completion: @escaping (APIResult<BaseModel>) -> Void) {
        let target = NetworkServices.logout(token: token)
        tripSavaServicesProvider.performRequest(target, responseType: BaseModel.self, completion: completion)
    }
    
    //MARK: - updateProfile...
    func updateProfile(firstName: String, lastName: String, dob: String, gender: String, city: String, country: String, completion: @escaping (APIResult<SignupModel>) -> Void) {
        let target = NetworkServices.updateProfile(firstName: firstName, lastName: lastName, dob: dob, gender: gender, city: city, country: country)
        tripSavaServicesProvider.performRequest(target, responseType: SignupModel.self, completion: completion)
    }
    
    //MARK: - updateEmail...
    func updateEmail(email: String, completion: @escaping (APIResult<SignupModel>) -> Void) {
        let target = NetworkServices.updateEmail(email: email)
        tripSavaServicesProvider.performRequest(target, responseType: SignupModel.self, completion: completion)
    }
    
    //MARK: - sendOptForForgotPassword...
    func sendOptForForgotPassword(email: String, completion: @escaping (APIResult<ForgotPasswordModel>) -> Void) {
        let target = NetworkServices.sendOptForForgotPassword(email: email)
        tripSavaServicesProvider.performRequest(target, responseType: ForgotPasswordModel.self, completion: completion)
    }
    
    //MARK: - verifyOTPCode
    func verifyOTPCode(otpCode: String, token: String, completion: @escaping (APIResult<ForgotPasswordModel>) -> Void) {
        let target = NetworkServices.verifyOTPCode(otp: otpCode, forgotAccessToken: token)
        tripSavaServicesProvider.performRequest(target, responseType: ForgotPasswordModel.self, completion: completion)
    }
    
    //MARK: - resetPassword...
    func resetPassword(password: String, token: String, completion: @escaping (APIResult<ForgotPasswordModel>) -> Void) {
        let target = NetworkServices.resetPassword(password: password, forgotAccessToken: token)
        tripSavaServicesProvider.performRequest(target, responseType: ForgotPasswordModel.self, completion: completion)
    }
    
    //MARK: - searchPlaceFromGoogle...
    func searchPlaceFromGoogle(place: String, completion: @escaping (APIResult<GeocodingResponse>) -> Void) {
        let target = NetworkServices.getGeoCodingSearchApi(address: place)
        tripSavaServicesProvider.performRequest(target, responseType: GeocodingResponse.self, completion: completion)
    }
    
    //MARK: - updateNotificationsAlert...
    func updateNotificationsAlert(allowNotify: Bool, completion: @escaping (APIResult<UserBaseModel>) -> Void) {
        let target = NetworkServices.updateNotificationsAlert(allowNotify: allowNotify)
        tripSavaServicesProvider.performRequest(target, responseType: UserBaseModel.self, completion: completion)
    }
    
    //MARK: - deleteAccount...
    func deleteAccount(completion: @escaping (APIResult<BaseModel>) -> Void) {
        let target = NetworkServices.deleteAccount
        tripSavaServicesProvider.performRequest(target, responseType: BaseModel.self, completion: completion)
    }
    
    //MARK: - updatePassword...
    func updatePassword(currentPassword: String, newPassword: String, completion: @escaping (APIResult<UserBaseModel>) -> Void) {
        let target = NetworkServices.updatePassword(currentPassword: currentPassword, newPassword: newPassword)
        tripSavaServicesProvider.performRequest(target, responseType: UserBaseModel.self, completion: completion)
    }
    
    //MARK: - getBlogs...
    func getBlogs(completion: @escaping (APIResult<BlogsBaseModel>) -> Void) {
        let target = NetworkServices.getBlogs
        tripSavaServicesProvider.performRequest(target, responseType: BlogsBaseModel.self, completion: completion)
    }
    
    //MARK: - getCountries...
    func getCountries(completion: @escaping (APIResult<CountriesBaseModel>) -> Void) {
        let target = NetworkServices.getCountries
        tripSavaServicesProvider.performRequest(target, responseType: CountriesBaseModel.self, completion: completion)
    }
    
    //MARK: - getCountryEmbassy...
    func getCountryEmbassy(countryCode: String, completion: @escaping (APIResult<CountriesBaseModel>) -> Void) {
        let target = NetworkServices.getCountryEmbassy(countryCode: countryCode)
        tripSavaServicesProvider.performRequest(target, responseType: CountriesBaseModel.self, completion: completion)
    }
    
    //MARK: - getSelectedCountryEmbassiesDetails...
    func getSelectedCountryEmbassiesDetails(sourceCountry: String, destinationCountry: String, completion: @escaping (APIResult<EmbassiesListBaseModel>) -> Void) {
        let target = NetworkServices.getSelectedCountryEmbassiesDetails(sourceCountry: sourceCountry, destinationCountry: destinationCountry)
        tripSavaServicesProvider.performRequest(target, responseType: EmbassiesListBaseModel.self, completion: completion)
    }
    
    
    //MARK: - getCategories...
    func getCategories(type: String, parent: String, completion: @escaping (APIResult<CategoriesBaseModel>) -> Void) {
        let target = NetworkServices.getCategories(type: type, parent: parent)
        tripSavaServicesProvider.performRequest(target, responseType: CategoriesBaseModel.self, completion: completion)
    }
    
    //MARK: - getProducts...
    func getProducts(primaryCategory: String, secondaryCategory: String, name: String, isFeatured: Bool, completion: @escaping (APIResult<ProductsBaseModel>) -> Void) {
        let target = NetworkServices.getProducts(primaryCategory: primaryCategory, secondaryCategory: secondaryCategory, name: name, isFeatured: isFeatured)
        tripSavaServicesProvider.performRequest(target, responseType: ProductsBaseModel.self, completion: completion)
    }
    
    //MARK: - getServices...
    func getServices(primaryCategory: String, secondaryCategory: String, name: String, isFeatured: Bool, completion: @escaping (APIResult<ServicesBaseModel>) -> Void) {
        let target = NetworkServices.getServices(primaryCategory: primaryCategory, secondaryCategory: secondaryCategory, name: name, isFeatured: isFeatured)
        tripSavaServicesProvider.performRequest(target, responseType: ServicesBaseModel.self, completion: completion)
    }
    
    //MARK: - getFavourites...
    func getFavourites(type: String, completion: @escaping (APIResult<FavouritesBaseModel>) -> Void) {
        let target = NetworkServices.getFavourites(type: type)
        tripSavaServicesProvider.performRequest(target, responseType: FavouritesBaseModel.self, completion: completion)
    }
    
    
    //MARK: - updateUserfavourite...
    func updateUserfavourite(item: String, type: String, completion: @escaping (APIResult<BaseModel>) -> Void) {
        let target = NetworkServices.updateUserfavourite(item: item, type: type)
        tripSavaServicesProvider.performRequest(target, responseType: BaseModel.self, completion: completion)
    }
    
    ///getFavoritesIDS...
    func getFavoritesIDs(completion: @escaping (APIResult<FavouritesIdsBaseModel>) -> Void) {
        let target = NetworkServices.getFavoritesIDS
        tripSavaServicesProvider.performRequest(target, responseType: FavouritesIdsBaseModel.self, completion: completion)
    }
    
    //MARK: - getShoppingList...
    func getShoppingList(completion: @escaping (APIResult<shoppingListBaseModel>) -> Void) {
        let target = NetworkServices.getShoppingList
        tripSavaServicesProvider.performRequest(target, responseType: shoppingListBaseModel.self, completion: completion)
    }
    
    //MARK: - addNewItemIntoShoppingList...
    func addNewItemIntoShoppingList(trip: String, product: String, name: String, isCustom: Bool, completion: @escaping (APIResult<shoppingListAddItemBaseModel>) -> Void) {
        let target = NetworkServices.addNewItemIntoShoppingList(trip: trip, product: product, name: name, isCustom: isCustom)
        tripSavaServicesProvider.performRequest(target, responseType: shoppingListAddItemBaseModel.self, completion: completion)
    }
    
    //MARK: - updateShoppingListItem...
    func updateShoppingListItem(name: String, isChecked: Bool, shoppingListId: String, itemId: String, completion: @escaping (APIResult<shoppingListAddItemBaseModel>) -> Void) {
        let target = NetworkServices.updateShoppingListItem(name: name, isChecked: isChecked, shoppingListId: shoppingListId, itemId: itemId)
        tripSavaServicesProvider.performRequest(target, responseType: shoppingListAddItemBaseModel.self, completion: completion)
    }
    
    //MARK: - checkAllItemsOfList...
    func checkAllItemsOfList(listId: String, completion: @escaping (APIResult<checkAllItemsListBaseResponse>) -> Void) {
        let target = NetworkServices.checkAllItemsOfList(listId: listId)
        tripSavaServicesProvider.performRequest(target, responseType: checkAllItemsListBaseResponse.self, completion: completion)
    }
    
    //MARK: - deleteShoppingList...
    func deleteShoppingList(listId: String, completion: @escaping (APIResult<BaseModel>) -> Void) {
        let target = NetworkServices.deleteShoppingList(listId: listId)
        tripSavaServicesProvider.performRequest(target, responseType: BaseModel.self, completion: completion)
    }
    
    //MARK: - deleteShoppinhListItem...
    func deleteShoppinhListItem(shoppingListId: String, itemId: String, completion: @escaping (APIResult<checkAllItemsListBaseResponse>) -> Void) {
        let target = NetworkServices.deleteShoppinhListItem(shoppingListId: shoppingListId, itemId: itemId)
        tripSavaServicesProvider.performRequest(target, responseType: checkAllItemsListBaseResponse.self, completion: completion)
    }
    
    //MARK: - createTripWizard...
    func createTripWizard(params: [String: Any], completion: @escaping (APIResult<TripResponse>) -> Void) {
        let target = NetworkServices.createTripWizard(params: params)
        tripSavaServicesProvider.performRequest(target, responseType: TripResponse.self, completion: completion)
    }
    
    //MARK: - getAlltrips...
    func getAlltrips(page: Int, limit: Int, searchText: String, completion: @escaping (APIResult<AllTripBaseResponse>) -> Void) {
        let target = NetworkServices.getAllTrips(page: page, limit: limit, searchText: searchText)
        tripSavaServicesProvider.performRequest(target, responseType: AllTripBaseResponse.self, completion: completion)
    }
    
    //MARK: - getTripWeather...
    func getTripWeather(tripId: String, completion: @escaping (APIResult<WeatherBaseResponse>) -> Void) {
        let target = NetworkServices.getTripWeather(tripId: tripId)
        tripSavaServicesProvider.performRequest(target, responseType: WeatherBaseResponse.self, completion: completion)
    }
    
    //MARK: - getTripWeatherDetails...
    func getTripWeatherDetails(tripId: String, date: String, completion: @escaping (APIResult<HoursWeatherBaseResponse>) -> Void) {
        let target = NetworkServices.getTripWeatherDetails(tripId: tripId, date: date)
        tripSavaServicesProvider.performRequest(target, responseType: HoursWeatherBaseResponse.self, completion: completion)
    }
    
    //MARK: - getChatGtpMessage...
    func getChatGtpMessage(query: String, completion: @escaping (APIResult<TextCompletionResponse>) -> Void) {
        let target = NetworkServices.getChatGtpMessage(query: query)
        tripSavaServicesProvider.performRequest(target, responseType: TextCompletionResponse.self, completion: completion)
    }
    
    //MARK: - createQuickList...
    func createQuickList(name: String, image: String, startDate: String, endDate: String, completion: @escaping (APIResult<QucikListBaseResponse>) -> Void) {
        let target = NetworkServices.createQuickList(name: name, image: image, startDate: startDate, endDate: endDate)
        tripSavaServicesProvider.performRequest(target, responseType: QucikListBaseResponse.self, completion: completion)
    }
    
    //MARK: - createPackingList...
    func createPackingList(tripId: String, activities: [String], travellingWith: [String], completion: @escaping (APIResult<BaseModel>) -> Void) {
        let target = NetworkServices.createPackingList(tripId: tripId, activities: activities, travellingWith: travellingWith)
        tripSavaServicesProvider.performRequest(target, responseType: BaseModel.self, completion: completion)
    }
    
    //MARK: - getPackingOrPreprationCategories...
    func getPackingOrPreprationCategories(tripId: String, type: String, completion: @escaping (APIResult<CategoryBaseModel>) -> Void) {
        let target = NetworkServices.getPackingOrPreprationCategories(tripId: tripId, type: type)
        tripSavaServicesProvider.performRequest(target, responseType: CategoryBaseModel.self, completion: completion)
    }
    
    //MARK: - getPackingOrPreprationCategoriesAndItems...
    func getPackingOrPreprationCategoriesAndItems(tripId: String, type: String, completion: @escaping (APIResult<PackingListResponse>) -> Void) {
        let target = NetworkServices.getPackingOrPreprationCategoriesAndItems(tripId: tripId, type: type)
        tripSavaServicesProvider.performRequest(target, responseType: PackingListResponse.self, completion: completion)
    }
    
    //MARK: - deleteTrip...
    func deleteTrip(tripId: String, completion: @escaping (APIResult<BaseModel>) -> Void) {
        let target = NetworkServices.deleteTrip(tripId: tripId)
        tripSavaServicesProvider.performRequest(target, responseType: BaseModel.self, completion: completion)
    }
    
    //MARK: - updateTrip...
    func updateTrip(tripId: String, params: [String: Any], completion: @escaping (APIResult<TripResponse>) -> Void) {
        let target = NetworkServices.updateTrip(tripId: tripId, params: params)
        tripSavaServicesProvider.performRequest(target, responseType: TripResponse.self, completion: completion)
    }
    
    //MARK: - archiveQuicklist...
    func archiveQuicklist(tripId: String, completion: @escaping (APIResult<BaseModel>) -> Void) {
        let target = NetworkServices.archiveQuicklist(tripId: tripId)
        tripSavaServicesProvider.performRequest(target, responseType: BaseModel.self, completion: completion)
    }
    
    //MARK: - updateQuickList...
    func updateQuickList(tripId: String, name: String, image: String, startDate: String, endDate: String, completion: @escaping (APIResult<QucikListBaseResponse>) -> Void) {
        let target = NetworkServices.updateQuickList(tripId: tripId, name: name, image: image, startDate: startDate, endDate: endDate)
        tripSavaServicesProvider.performRequest(target, responseType: QucikListBaseResponse.self, completion: completion)
    }
    
    //MARK: - updatePackingList...
    func updatePackingList(tripId: String, categoryId: String, itemId: String, listType: String, isChecked: Bool, quantity: Int, bagType: String, priority: Bool, isToBuy: Bool, toBuy: Bool, primaryCategory: String, completion: @escaping (APIResult<PackingListResponse>) -> Void) {
        let target = NetworkServices.updatePackingList(tripId: tripId, categoryId: categoryId, itemId: itemId, listType: listType, isChecked: isChecked, quantity: quantity, bagType: bagType, priority: priority, isToBuy: isToBuy, toBuy: toBuy, primaryCategory: primaryCategory)
        tripSavaServicesProvider.performRequest(target, responseType: PackingListResponse.self, completion: completion)
    }
    
    //MARK: - addNewItemOnCategoryOrPackingOrPrepration...
    func addNewItemOnCategoryOrPackingOrPrepration(tripId: String, type: String, params: [String: Any], completion: @escaping (APIResult<PackingListResponse>) -> Void) {
        let target = NetworkServices.addNewItemOnCategoryOrPackingOrPrepration(tripId: tripId, type: type, params: params)
        tripSavaServicesProvider.performRequest(target, responseType: PackingListResponse.self, completion: completion)
    }
    
}



