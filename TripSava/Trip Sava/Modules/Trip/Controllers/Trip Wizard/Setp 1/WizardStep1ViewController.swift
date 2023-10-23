//
//  WizardStep1ViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 12/06/2023.
//

import UIKit
import FSCalendar
import DropDown

class WizardStep1ViewController: UIViewController {
    
    //MARK: - IBOutlets...
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarMainView: UIView!
    @IBOutlet weak var daterangelabel: UILabel!
    @IBOutlet weak var locationTxt: TextField!
    @IBOutlet weak var tripNameTxt: TextField!
    @IBOutlet weak var dateTextField: TextField!
    @IBOutlet weak var dateTxt: UIButton!
    @IBOutlet weak var calendarDateLabel: UILabel!
    
    
    //MARK: - Variables...
    
    let emptyMessage = "Your start date is in the past - this means you are already on your trip!\n\nDo you want to enter a date in the past?"
    let backBtnMsg = "Are you sure you want to exit the Trip Wizard?\n\nYour information will not be saved."
    var searchPlaceFromGoogleAllResults = [GeocodingResult]()
    private var firstDate: Date?; private var lastDate: Date?
    var datesRange: [Date]?; var backgroundView: UIView?
    let locationDropDown = DropDown(); var addressList: [String] = [];
    var city = "", country = ""; var latitude: Double = 0; var longitude: Double = 0
    var isCommingForTripUpdate: Bool = false; var trip: Trip?
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){
        setUpFSCalendar(); setUpDropDown(); updateDateLabels(); checkForUpdateTrip()
    }
    
    ///checkForUpdateTrip...
    func checkForUpdateTrip(){
        if isCommingForTripUpdate {
            if let trip = trip {
                //locationTxt.isUserInteractionEnabled = false
                locationTxt.text = "\(trip.location?.city ?? ""), \(trip.location?.country ?? "")"
                country = trip.location?.country ?? ""; city = trip.location?.city ?? ""
                latitude = trip.location?.lat ?? 0; longitude = trip.location?.lng ?? 0
                tripNameTxt.text = trip.name
                datesRange = self.datesInRange(from: trip.startDate ?? "", to: trip.endDate ?? "")
                firstDate = parseDate(from: trip.startDate ?? ""); lastDate = parseDate(from: trip.endDate ?? "");
                if let dateRanges = datesRange { for date in dateRanges { calendar.select(date) } }; updateDateLabels()
            }
        }
    }
    
    ///setUpDropDown..
    func setUpDropDown(){
        ///locationDropDown...
        locationDropDown.bottomOffset = CGPoint(x: 0, y: locationTxt.frame.height + 6)
        locationDropDown.textFont = Constants.applyFonts_DMSans(style: .regular, size: 14)
        locationDropDown.anchorView = locationTxt
        locationDropDown.direction = .bottom
        locationDropDown.backgroundColor = .white
        locationDropDown.textColor = UIColor(hex: "#474847")
        locationDropDown.selectedTextColor = UIColor(hex: "#E26A2B")
        locationDropDown.separatorColor = UIColor(hex: "#CBCBCB", alpha: 0.30)
        
        locationDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            let data = self?.searchPlaceFromGoogleAllResults[index]
            data?.address_components?.forEach({ address in
                if let types = address.types { if types.contains("country") { self?.country = address.long_name ?? "" } }
                if let types = address.types { if types.contains("locality") { self?.city = address.long_name ?? "" } }
                if let latitude = data?.geometry?.location?.lat, let longitude = data?.geometry?.location?.lng { self?.latitude = latitude; self?.longitude = longitude }
            });
            self?.locationTxt.text = item
        }
    }
    
    ///setUpFSCalendar...
    func setUpFSCalendar(){
        calendar.scope = .month
        calendar.scrollDirection = .vertical
        calendar.allowsMultipleSelection = true
        calendar.swipeToChooseGesture.isEnabled = true
        calendar.appearance.weekdayFont = Constants.applyFonts_DMSans(style: .regular, size: 14)
        calendar.appearance.headerTitleFont = Constants.applyFonts_DMSans(style: .Medium, size: 14)
        calendar.appearance.titleFont = Constants.applyFonts_DMSans(style: .Medium, size: 13)
        FSCalendar.appearance().placeholderType = .none
        calendar.appearance.headerSeparatorColor = .clear
        calendar.appearance.todayColor = UIColor(hex: "#013781", alpha: 0.1)
        calendar.appearance.titleDefaultColor = UIColor(hex: "#474847", alpha: 0.96)
        calendar.appearance.titleTodayColor = UIColor(hex: "#474847", alpha: 0.96)
        calendar.appearance.titleDefaultColor =  UIColor(hex: "#474847", alpha: 0.96)
        calendar.appearance.headerTitleAlignment = .left
        calendar.calendarWeekdayView.backgroundColor = .white
        calendar.calendarWeekdayView.isHidden = false
        calendar.calendarWeekdayView.calendar = calendar
        calendar.calendarWeekdayView.configureAppearance()
        
        // Adjust the frame of the calendar
        calendar.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height - 100)
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
        swipeLeftGesture.direction = .left
        calendar.superview?.addGestureRecognizer(swipeLeftGesture)
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight))
        swipeRightGesture.direction = .right
        calendar.superview?.addGestureRecognizer(swipeRightGesture)
        
    }
    
    ///handleSwipeLeft...
    @objc func handleSwipeLeft() {
        let currentDate = calendar.selectedDate ?? Date()
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)
        calendar.select(nextDate)
    }
    
    ///handleSwipeRight...
    @objc func handleSwipeRight() {
        let currentDate = calendar.selectedDate ?? Date()
        let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)
        calendar.select(previousDate)
    }
    
    
    ///handleCalendarViewBtnAction..
    func handleCalendarViewBtnAction(){  calendarMainView.isHidden.toggle() }
    
    ///handleNextBtnAction...
    func handleNextBtnAction(){
        print(tripNameTxt.isInRange(range: 30) )
        if locationTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter the main destination") }
        else if country == "" || city == "" || latitude == 0 || longitude == 0 { self.presentAlert(withTitle: "Alert", message: "Please select the city from list") }
        else if tripNameTxt.isEmptyTextField() { self.presentAlert(withTitle: "Alert", message: "Enter the trip name") }
        else if tripNameTxt.isInRange(range: 30) { self.presentAlert(withTitle: "Alert", message: "Trip name must be less than or equal to 30 characters long") }
        else if datesRange?.count ?? 0 <= 0 { self.presentAlert(withTitle: "Alert", message: "Please select the start and end date") }
        else {
            let tripData = TripData(tripWizardStep1: TripWizardStep1(city: city, country: country, lat: latitude, long: longitude, tripName: tripNameTxt.trimText(), tripStratDate: firstDate, tripEndData: lastDate, dateRanges: datesRange))
            let controller = storyboard?.instantiateViewController(withIdentifier: "WizardStep2ViewController") as! WizardStep2ViewController
            controller.tripData = tripData; controller.isCommingForTripUpdate = isCommingForTripUpdate; controller.trip = trip
            controller.hidesBottomBarWhenPushed = false; 
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    ///updateOnLocationTextDidChange..
    func updateOnLocationTextDidChange(text: String) {
        if isCommingForTripUpdate {
            locationTxt.text?.removeLast()
            showSimpleCustomMessageView(message: "Sorry we don’t yet support changing a location because much of the experience with TripSava is tied to your location, we recommend creating a new trip to have the best experience.", labelFont: Constants.applyFonts_DMSans(style: .regular, size: 13), msgColor: UIColor(hex: "#808080"), btnText: "Okay") { } }
        else { let searchText = text.trimmingCharacters(in: .whitespacesAndNewlines); searchPlaceFromGoogle(place: searchText) }
        
    }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.showCustomView(firstBtnTitle: "Yes", secondBtntext: "No", message: backBtnMsg) { self.popToRootViewController() } }
    
    ///nextBtnAction...
    @IBAction func nextBtnAction(_ sender: Any) { handleNextBtnAction() }
    
    ///toggleCalendarBtnAction...
    @IBAction func toggleCalendarBtnAction(_ sender: Any) { handleCalendarViewBtnAction() }
    
    ///locationTxtDidChange...
    @IBAction func locationTxtDidChange(_ sender: UITextField) { updateOnLocationTextDidChange(text: sender.text ?? "") }
    
}


//MARK: - FSCalendarDelegate...
extension WizardStep1ViewController: FSCalendarDelegate {
    
    ///didSelect...
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if date.withComponents([.day, .month, .year]) < Date().withComponents([.day, .month, .year]) { /// check if user selected the past date...
            self.showCustomView(firstBtnTitle: "Yes", secondBtntext: "No", message: emptyMessage) { /// if user added the yes button add the date...
                self.updateFirstSelectedDate(date: date); self.updateDateLabels()
            } noAction: { /// deselect the date if user tap on no button...
                calendar.deselect(date); self.updateDateLabels()
            }
        } else { self.updateFirstSelectedDate(date: date); self.updateDateLabels() }
    }
    
    ///updateFirstSelectedDate...
    func updateFirstSelectedDate(date: Date){
        
        if firstDate == nil { firstDate = date; datesRange = [firstDate!] ; return }  // nothing selected:
        
        if firstDate != nil && lastDate == nil { // only first date is selected:
            if date <= firstDate! { calendar.deselect(firstDate!); firstDate = date; datesRange = [firstDate!]; return
            }
            let range = datesRange(from: firstDate!, to: date); lastDate = range.last
            for d in range { calendar.select(d) }; datesRange = range; return
        }
        
        if firstDate != nil && lastDate != nil { // both are selected:
            for d in calendar.selectedDates { calendar.deselect(d) }
            lastDate = nil; firstDate = nil; datesRange = []
        }
    }
    
    ///didDeselect...
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if firstDate != nil && lastDate != nil { // both are selected:
            for d in calendar.selectedDates { calendar.deselect(d) }
            lastDate = nil; firstDate = nil; datesRange = []; self.updateDateLabels()
        }
    }
    
    ///datesRange...
    func datesRange(from: Date, to: Date) -> [Date] {
        if from > to { return [Date]() }
        var tempDate = from; var array = [tempDate]
        while tempDate < to { tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!; array.append(tempDate) }
        return array
    }
    
    ///updateDateLabels...
    func updateDateLabels(){
        if firstDate == nil || lastDate == nil { // only first date is selected:
            daterangelabel.text = ""
            calendarDateLabel.text = "Select the start & end date"
        }
        if firstDate != nil && lastDate != nil { // both are selected:
            calendarDateLabel.text = self.getDateFormatedString(startDate: firstDate ?? Date(), endDate: lastDate ?? Date())
            daterangelabel.text = getDaysAndNightsString(datesRange: datesRange ?? [])
        }
    }
    
}

//MARK: - Network layer...
extension WizardStep1ViewController {
    
    /// getAdddressFromCordinates...
    func searchPlaceFromGoogle(place: String) {
        Constants.tripSavaServcesManager.searchPlaceFromGoogle(place: place) { (Resultent) in
            switch Resultent {
            case .success(let response):
                if response.status == "OK" {
                    self.searchPlaceFromGoogleAllResults = response.results ?? []
                    self.handleSearchPlaceFromGoogle()
                }
                else { self.locationDropDown.hide() }
            case .failure(_): self.locationDropDown.hide()
            }
        }
    }
    
    ///handleSearchPlaceFromGoogle...
    func handleSearchPlaceFromGoogle(){
        country = ""; city = ""; latitude = 0; longitude = 0
        addressList.removeAll()
        for result in searchPlaceFromGoogleAllResults {
            if let addressComponents = result.address_components {
                var city: String?; var country: String?
                for component in addressComponents {
                    if let types = component.types {
                        if types.contains("locality") { city = component.long_name ?? component.short_name ?? "" }
                        if types.contains("country") { country = component.long_name ?? component.short_name ?? "" }
                    }
                    if let city = city, let country = country { let cityCountry = "\(city), \(country)"; addressList.append(cityCountry); break }
                }
            }
        }; locationDropDown.dataSource = addressList
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.locationDropDown.reloadAllComponents(); self.locationDropDown.show()
            self.locationDropDown.width = self.locationTxt.frame.width
        }
    }
}

