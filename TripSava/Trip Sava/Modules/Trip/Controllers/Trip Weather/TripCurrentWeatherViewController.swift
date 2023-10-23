//
//  TripCurrentWeatherViewController.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 13/06/2023.
//

import UIKit

class TripCurrentWeatherViewController: UIViewController {

    //MARK: - IBOutlets...
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    @IBOutlet weak var hourlyWeatherCollectionView: UICollectionView!
    @IBOutlet weak var seatherSumaryLabel: UILabel!
    @IBOutlet weak var hoursCollectionViewHeaderLabel: UILabel!
    @IBOutlet weak var readMoreBtn: UIButton!
    
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var chanceOfRainLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var dewPointsLabel: UILabel!
    @IBOutlet weak var feelsLikeConditionLabel: UILabel!
    
    @IBOutlet weak var sunTotalTimeLabel: UILabel!
    @IBOutlet weak var sunRiseLabel: UILabel!
    @IBOutlet weak var sunSetLabel: UILabel!
    
    @IBOutlet weak var moonTotalTimeLabel: UILabel!
    @IBOutlet weak var moonRiseLabel: UILabel!
    @IBOutlet weak var moonsunSetLabel: UILabel!
    
    @IBOutlet weak var particularMeterValueLabel: UILabel!
    @IBOutlet weak var particularMeterNumberLabel: UILabel!
    @IBOutlet weak var particularSlider: UISlider!
    
    @IBOutlet weak var uvValueLabel: UILabel!
    @IBOutlet weak var uvSlider: UISlider!
    @IBOutlet weak var uvNumberLabel: UILabel!
    
    @IBOutlet weak var uvView: UIView!
    @IBOutlet weak var uvDetailsView: UIView!
    
    @IBOutlet weak var goldenHourMorningLabel: UILabel!
    @IBOutlet weak var goldenHourEveningLabel: UILabel!
    @IBOutlet weak var blueMoonMorning: UILabel!
    @IBOutlet weak var blueMoonEvening: UILabel!
    
    
    //MARK: - Variables...
    let cellIdentifier = "tripCurrentWeatherCollectionViewCell"
    var chatGtpData: TextCompletionResponse?
    let quertIntroText = "I want to make sure you are prepared for the weather during your trip."
    let queryClosingText = "Remember that the weather can change so be sure to regularly check the weather for updates, and add anything else you might need to your packing and/or shopping lists to purchase"
    var trip: Trip?; var weatherListData: [WeatherData] = []; var hoursWeatherData: WeatherInfo?
    var weatherHoursData: [HourlyInfo] = []; var UvData: [UvInfo] = []
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    
    //MARK: - Functions...
    
    ///setUpViews...
    func setUpViews(){
        generateTripWeatherQuery(); getWeatherData(); updateData()
        setUpCollectionView()
        readMoreBtn.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 14)
    }
     
    ///setUpCollectionView..
    func setUpCollectionView(){
        weatherCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        hourlyWeatherCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func updateData(){
        
        UvData.append(UvInfo(index: [1,2], UVHeaderText: "It is generally safe to spend extended periods of time outdoors without risk of harm from the sun's rays. However, it is still important to take precautions to protect your skin and eyes from potential damage. Explore the outdoors: Take advantage of the comfortable weather and plan a day trip or outdoor adventure. Go for a hike, visit a park, or plan a picnic. Remember to bring plenty of water, sunscreen, and protective clothing.", detailsText: []))
        
        UvData.append(UvInfo(index: [3,4,5], UVHeaderText: "The sun's rays are moderate and can still cause harm to your skin and eyes. Plan indoor activities: Consider planning indoor activities such as visiting museums, art galleries, or indoor markets to avoid extended exposure to the sun.", detailsText: [
        "*Wear protective clothing:* Wear protective clothing such as long-sleeved shirts, hats, and sunglasses to protect your skin and eyes from harmful UV rays.",
        "*Use sunscreen:* Apply a broad-spectrum sunscreen with a minimum SPF of 30 to all exposed skin areas, and reapply every two hours, or more frequently if swimming or sweating.",
        "*Avoid peak sun hours:* Try to avoid being outside during peak sun hours, which are typically from 10 am to 4 pm. Plan your outdoor activities for earlier or later in the day when the sun's rays are less intense.",
        "*Take breaks in shaded areas:* If you are spending time outdoors, take breaks in shaded areas to reduce your exposure to the sun's rays.",
        "*Stay hydrated:* Drink plenty of water and avoid alcohol and caffeine, which can dehydrate your body and increase your risk of heat exhaustion or heat stroke.",
        "*Consider using an umbrella or sunshade:* If you are spending time at the beach or in a park, consider using an umbrella or sunshade to provide additional protection from the sun's rays."
        ]))
         
        UvData.append(UvInfo(index: [6,7], UVHeaderText: "The sun's rays are strong and can cause harm to your skin and eyes in a short period of time. It's important to take extra precautions to protect yourself from the sun's rays. Plan indoor activities: Consider planning indoor activities such as visiting museums, art galleries, or indoor markets to avoid extended exposure to the sun.", detailsText: [
        "*Wear protective clothing:* Wear protective clothing such as long-sleeved shirts, hats, and sunglasses to protect your skin and eyes from harmful UV rays.",
        "*Use sunscreen:* Apply a broad-spectrum sunscreen with a minimum SPF of 30 to all exposed skin areas, and reapply every two hours, or more frequently if swimming or sweating.",
        "*Avoid peak sun hours:* Try to avoid being outside during peak sun hours, which are typically from 10 am to 4 pm. Plan your outdoor activities for earlier or later in the day when the sun's rays are less intense.",
        "*Take breaks in shaded areas:* If you are spending time outdoors, take breaks in shaded areas to reduce your exposure to the sun's rays.",
        "*Stay hydrated:* Drink plenty of water and avoid alcohol and caffeine, which can dehydrate your body and increase your risk of heat exhaustion or heat stroke.",
        "*Consider using an umbrella or sunshade:* If you are spending time at the beach or in a park, consider using an umbrella or sunshade to provide additional protection from the sun's rays"
        ]))
        
        UvData.append(UvInfo(index: [8,9,10], UVHeaderText: "The sun's rays are extremely strong and can cause serious harm to your skin and eyes. It's crucial to take extra precautions to protect yourself from the sun's rays. Plan indoor activities: Consider planning indoor activities such as visiting museums, art galleries, or indoor markets to avoid extended exposure to the sun.", detailsText: [
            "*Wear protective clothing:* Wear protective clothing such as long-sleeved shirts, pants, wide-brimmed hats, and sunglasses to protect your skin and eyes from harmful UV rays.",
            "*Use sunscreen:* Apply a broad-spectrum sunscreen with a minimum SPF of 30 to all exposed skin areas, and reapply every two hours, or more frequently if swimming or sweating.",
            "*Seek shade:* When outdoors, seek shade under a tree, umbrella or sunshade, especially during peak sun hours.",
            "*Avoid peak sun hours:* Try to avoid being outside during peak sun hours, which are typically from 10 am to 4 pm. Plan your outdoor activities for earlier or later in the day when the sun's rays are less intense.",
            "*Stay hydrated:* Drink plenty of water and avoid alcohol and caffeine, which can dehydrate your body and increase your risk of heat exhaustion or heat stroke.",
            "*Consider rescheduling outdoor activities:* If possible, reschedule your outdoor activities for a day when the UV index is lower.",
            "Consider wearing a face covering or sun-protective fabric to protect your face from the sun's rays."
        ]))
        
        UvData.append(UvInfo(index: [11], UVHeaderText: "The sun's rays are extremely intense and can cause severe harm to your skin and eyes in a very short period of time. It's essential to take extreme precautions to protect yourself from the sun's rays.  Stay indoors: Consider staying indoors and avoiding outdoor activities altogether, especially during peak sun hours.", detailsText: [
        "*Wear protective clothing:* If you need to go outside, wear protective clothing such as long-sleeved shirts, pants, wide-brimmed hats, and sunglasses to protect your skin and eyes from harmful UV rays.",
        "*Use sunscreen:* Apply a broad-spectrum sunscreen with a minimum SPF of 30 to all exposed skin areas, and reapply every two hours, or more frequently if swimming or sweating.",
        "*Seek shade:* When outdoors, seek shade under a tree, umbrella or sunshade, especially during peak sun hours.",
        "*Avoid peak sun hours:* Try to avoid being outside during peak sun hours, which are typically from 10 am to 4 pm. Plan your outdoor activities for earlier or later in the day when the sun's rays are less intense.",
        "*Stay hydrated:* Drink plenty of water and avoid alcohol and caffeine, which can dehydrate your body and increase your risk of heat exhaustion or heat stroke.",
        "*Reschedule outdoor activities:* If possible, reschedule your outdoor activities for a day when the UV index is lower.",
        "Consider wearing a face covering or sun-protective fabric to protect your face from the sun's rays."
        ]))
       
    }
    
    ///generateTripWeatherQuery...
    func generateTripWeatherQuery(){
        if let trip = trip {
            let startDate = trip.startDate?.convertDateFormat(from: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", to: "MMMM dd") ?? ""
            let endDate = trip.endDate?.convertDateFormat(from: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", to: "MMMM dd") ?? ""
            let query = "I am going on a trip to \(trip.location?.city ?? "") during \(startDate) - \(endDate) what the weather conditions will be like and provide me a list on how I should prepare for them"
            getChatGtpText(query: query)
        }
       
    }
    
    ///getWeatherData...
    func getWeatherData(){
        if let data = weatherListData[0].date, let trip = trip {
            getTripHoursWeather(tripId: trip.id ?? "", date: data)
            let dayName = getFullDayNameAndDayOfMonth(from: data)
            hoursCollectionViewHeaderLabel.text = "\(dayName) . \(weatherListData[0].location?.name ?? "")"
        }
    }
    
    ///handleReadMoreBtAction...
    func handleReadMoreBtAction(){
        if seatherSumaryLabel.numberOfLines == 10 {
            seatherSumaryLabel.numberOfLines = 0; 
            readMoreBtn.setTitle("Read less", for: .normal)
            readMoreBtn.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 14)
        }else {
            seatherSumaryLabel.numberOfLines = 10; 
            readMoreBtn.setTitle("Read more", for: .normal)
            readMoreBtn.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 14)
        }
    }
    
    ///handleCloseBtnAction..
    func handleCloseBtnAction(){ uvView.isHidden.toggle(); }
    
    ///handleUvLearnMoreBtnAction..
    func handleUvLearnMoreBtnAction(tag: Int){ 
        let customView = UvCustomView();
        var info: UvInfo?
        UvData.forEach { uvInfo in  if uvInfo.index.contains(tag) { info = uvInfo } }
        if let uvInfoDetail = info {
            customView.updateData(headerTxt: uvInfoDetail.UVHeaderText, details: uvInfoDetail.detailsText)
            
        }
        
        uvDetailsView.addsubViewWithConstraints(subView: customView, topAnchor: uvDetailsView.topAnchor, leadingAnchor: uvDetailsView.leadingAnchor, trailingAnchor: uvDetailsView.trailingAnchor, bottomAnchor: uvDetailsView.bottomAnchor, insertAt: 1)
    }
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popViewController() }
    
    @IBAction func tripSummeryReadMoreBtnAction(_ sender: Any) { handleReadMoreBtAction() }
    
    ///closeBtnAction...
    @IBAction func closeBtnAction(_ sender: Any) { handleCloseBtnAction() }
    
    ///uvLearnMoreBtnAction...
    @IBAction func uvLearnMoreBtnAction(_ sender: Any) { handleCloseBtnAction() }
    
    
}

//MARK: - CollectionView Delegate & DataSource ...
extension TripCurrentWeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    ///numberOfItemsInSection...
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 { return weatherListData.count } else { return weatherHoursData.count }
    }
    
    ///cellForItemAt...
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! tripCurrentWeatherCollectionViewCell
        if collectionView.tag == 0 { cell.data = weatherListData[indexPath.item] }
        else { cell.hoursData = weatherHoursData[indexPath.item] }
        return cell
    }
    
    ///sizeForItemAt...
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            let data = weatherListData[indexPath.item]; var updatedWidth: CGFloat = 65
            let estimatedWidth = estimatedTextWidth(for: data.location?.name ?? "", font: Constants.applyFonts_DMSans(style: .Medium, size: 11), width: collectionView.frame.width)
            if estimatedWidth > 65 { updatedWidth = estimatedWidth }
            return CGSize(width: updatedWidth, height: collectionView.frame.height)
        }
        else {
            _ = weatherHoursData[indexPath.item]; var updatedWidth: CGFloat = 65
            let estimatedWidth = estimatedTextWidth(for: hoursWeatherData?.location?.name ?? "", font: Constants.applyFonts_DMSans(style: .Medium, size: 11), width: collectionView.frame.width)
            if estimatedWidth > 65 { updatedWidth = estimatedWidth }
            return CGSize(width: updatedWidth, height: collectionView.frame.height)
        }
        
    }
    
    ///didSelectItemAt...
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            if let trip = trip, let data = weatherListData[indexPath.item].date {
                getTripHoursWeather(tripId: trip.id ?? "", date: data)
                let dayName = getFullDayNameAndDayOfMonth(from: data)
                hoursCollectionViewHeaderLabel.text = "\(dayName) . \(weatherListData[indexPath.item].location?.name ?? "")"
            }
        }
    }
    
}


//MARK: - Network layer...
extension TripCurrentWeatherViewController {
    
    ///getChatGtpText...
    func getChatGtpText(query: String){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.getChatGtpMessage(query: query) { resultent in
            switch resultent {
            case .success(let response): self.chatGtpData = response; self.handleresponse()
            case .failure(_): self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: "Please return to this screen later as the data is currently unavailable. Thank you for your patience")
            }
        }
    }
    
    ///handleresponse...
    func handleresponse(){
        if let queryText = self.chatGtpData?.choices.first?.text {
            let queryText = queryText.trimmingCharacters(in: .newlines)
            seatherSumaryLabel.text = "\(quertIntroText)\n\n\(queryText)\n\n\(queryClosingText)"
            self.hideRappleActivity()
        }
    }
    
    
    ///getTripWeather...
    func getTripHoursWeather(tripId: String, date: String) {
        self.showRappleActivity()
        Constants.tripSavaServcesManager.getTripWeatherDetails(tripId: tripId, date: date) { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true { self.hoursWeatherData = response.weather?.first; self.handleWeatherDetailsData() }
            case .failure(_): self.hideRappleActivity()
            }
        }
    }
    
    ///handleWeatherDetailsData...
    func handleWeatherDetailsData(){
        if let weatherDetails = hoursWeatherData {
            weatherHoursData = weatherDetails.hour ?? []; self.hourlyWeatherCollectionView.reloadData()
            
            if let data = weatherHoursData.first {
                windLabel.text = "\(data.wind_mph ?? 0)mph"
                precipitationLabel.text = "\(data.precip_mm ?? 0)mph"
                chanceOfRainLabel.text = "Chances of rain:\n\(data.chance_of_rain ?? 0)%"
                feelsLikeLabel.text = "\(data.feelslike_f ?? 0)º"
                humidityLabel.text = "\(data.humidity ?? 0)%"
                dewPointsLabel.text = "The dew points is \(data.dewpoint_f ?? 0)º"
                feelsLikeConditionLabel.text = "\(data.condition?.text ?? "")"
                
                if let uv = data.uv {
                    if uv  >= 1 && uv <= 2 { uvValueLabel.text = "Low" }
                    else if uv >= 3 && uv <= 5 { uvValueLabel.text = "Moderate" }
                    else if uv >= 6 && uv <= 7 { uvValueLabel.text = "High" }
                    else if uv >= 8 && uv <= 10 { uvValueLabel.text = "Very High" }
                    else if uv >= 11  { uvValueLabel.text = "Extreme" }
                    uvNumberLabel.text = "\(uv)"; uvSlider.minimumValue = 0; uvSlider.maximumValue = 10; uvSlider.value = 0
                    handleUvLearnMoreBtnAction(tag: uv)
                }
            }
            
            if let astro = weatherDetails.astro {
                sunSetLabel.text = astro.sunset;sunRiseLabel.text = astro.sunrise
                sunTotalTimeLabel.text = calculateTimeDifference(start: astro.sunrise ?? "", end: astro.sunset ?? "")
                moonRiseLabel.text = astro.moonrise; moonsunSetLabel.text = astro.moonset
                moonTotalTimeLabel.text = calculateTimeDifference(start: astro.moonrise ?? "", end: astro.moonset ?? "")
                 
                let sunrise = astro.sunrise ?? ""; let sunset =  astro.sunset ?? ""
                let moonrise = astro.moonrise ?? ""; let moonset = astro.moonset ?? ""
                
                if let (sunMorning, sunEvening, moonMorning, moonEvening) = calculateGoldenAndBlueHours(sunrise: sunrise, sunset: sunset, moonrise: moonrise, moonset: moonset) {
                    self.goldenHourMorningLabel.text = sunMorning; self.goldenHourEveningLabel.text = sunEvening
                    self.blueMoonMorning.text = moonMorning; blueMoonEvening.text = moonEvening
                }
                
                
            }
            
            self.hideRappleActivity()
        }
    }
    
    func calculateGoldenAndBlueHours(sunrise: String, sunset: String, moonrise: String, moonset: String) -> (String, String, String, String)? {
        let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "hh:mm a"
        if let sunriseDate = dateFormatter.date(from: sunrise), let sunsetDate = dateFormatter.date(from: sunset),
           let moonriseDate = dateFormatter.date(from: moonrise), let moonsetDate = dateFormatter.date(from: moonset) {
            let calendar = Calendar.current ; let firstHourStartAfterSunRise = calendar.date(byAdding: .hour, value: 1, to: sunriseDate)
            let firstHourEndAfterSunRise = calendar.date(byAdding: .hour, value: 1, to: firstHourStartAfterSunRise ?? Date())
            let lastHourBeforeSunSet = calendar.date(byAdding: .hour, value: -1, to: sunsetDate)
            let mintsBeforeMoonRise = calendar.date(byAdding: .minute, value: -30, to: moonriseDate)
            let mintsAfterMoonset = calendar.date(byAdding: .minute, value: 20, to: moonsetDate)
            let goldenHourMorningString = "\(dateFormatter.string(from: firstHourStartAfterSunRise!)) - \(dateFormatter.string(from: firstHourEndAfterSunRise!))"
            let goldenHourEveningString = "\(dateFormatter.string(from: lastHourBeforeSunSet!)) - \(sunset)"
            let blueHoureMorning = "\(dateFormatter.string(from: mintsBeforeMoonRise!)) - \(moonrise)"
            let blueHoureEvening = "\(dateFormatter.string(from: mintsAfterMoonset!)) - \(moonrise)"
            return (goldenHourMorningString, goldenHourEveningString, blueHoureMorning, blueHoureEvening)
        }; return nil
    }
     
    
}
