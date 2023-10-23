//
//  PackingListVC.swift
//  TripSava
//
//  Created by Muneeb Zain on 08/06/2023.
//

import UIKit
import Kingfisher
import DropDown

class PackingListVC: UIViewController, UITabBarDelegate {
    
    //MARK: - IBOutlets...
    @IBOutlet weak var packingSegmentedControl: UISegmentedControl!
    @IBOutlet weak var preprationTableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomDetailsView: UIView!
    @IBOutlet weak var packingView: UIView!
    @IBOutlet weak var PreparingHeaderLabel: UILabel!
    @IBOutlet weak var tableViewHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var ShareAndPrintMainView: UIView!
    @IBOutlet weak var shareAndPrintDetailView: UIView!
    @IBOutlet weak var tripNameLabel: UILabel!
    @IBOutlet weak var categoriesCollection: UICollectionView!
    @IBOutlet weak var itemNameLabel: UILabel! /// items details outlet...
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var proTipButoon: UIButton!
    @IBOutlet weak var proTipView: UIView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var bagPackImg0: UIImageView!
    @IBOutlet weak var bagPackImg1: UIImageView!
    @IBOutlet weak var bagPackImg2: UIImageView!
    @IBOutlet weak var bagPackImg3: UIImageView!
    @IBOutlet weak var bagPackImg4: UIImageView!
    @IBOutlet weak var bagPackLabel0: UILabel!
    @IBOutlet weak var bagPackLabel1: UILabel!
    @IBOutlet weak var bagPackLabel2: UILabel!
    @IBOutlet weak var bagPackLabel3: UILabel!
    @IBOutlet weak var bagPackLabel4: UILabel!
    @IBOutlet weak var bagPackView0: UIView!
    @IBOutlet weak var bagPackView1: UIView!
    @IBOutlet weak var bagPackView2: UIView!
    @IBOutlet weak var bagPackView3: UIView!
    @IBOutlet weak var bagPackView4: UIView!
    @IBOutlet weak var backPackMainView: UIView!
    @IBOutlet weak var quantityPlusBtn: UIButton!
    @IBOutlet weak var quantitySubtructBtn: UIButton!
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var categorynameLabel: UILabel!
    @IBOutlet weak var bagPackImg: UIImageView!
    @IBOutlet weak var priorityImg: UIImageView!
    @IBOutlet weak var addToShoppingListImg: UIImageView!
    @IBOutlet weak var bagPackLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var addToShoppingListLabel: UILabel!
    @IBOutlet weak var dropDownAnchorView: UIView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var sortView: UIView!
    @IBOutlet weak var dataViewBtn1: UIButton!
    @IBOutlet weak var dataViewBtn2: UIButton!
    @IBOutlet weak var dataViewBtn3: UIButton!
    @IBOutlet weak var itemViewBtn1: UIButton!
    @IBOutlet weak var itemViewBtn2: UIButton!
    @IBOutlet weak var itemViewBtn3: UIButton!
    @IBOutlet weak var itemViewBtn4: UIButton!
    @IBOutlet weak var sortedBtn1: UIButton!
    @IBOutlet weak var sortedBtn2: UIButton!
    @IBOutlet weak var DataMainViews: UIView!
    @IBOutlet weak var ItemsMainView: UIView!
    @IBOutlet weak var SortedMainViews: UIView!
    @IBOutlet weak var dataHeaderIcon1: UIImageView!
    @IBOutlet weak var dataHeaderIcon2: UIImageView!
    @IBOutlet weak var dataHeaderIcon3: UIImageView!
    @IBOutlet weak var dataHeaderLabel1: UILabel!
    @IBOutlet weak var dataHeaderLabel2: UILabel!
    @IBOutlet weak var dataHeaderLabel3: UILabel!
    
    
    //MARK: - Variables...
    var identifeir = "ShopingListTableViewCell"; let cellIdentifier = "PackingPreprationCategoryCell"
    var trip: Trip?; var currentCategories: [PackingOrPackingCategory] = []
    var dropDownCategoryList: [DropDownCategoryList] = []
    var preprationData: [PreprationData] = []; var packingAndPreprationData: [PackingItem] = []
    var categoriesWithItemData: [CategoriesWithItems] = []; var currentSelectedItem: PackingItem?
    var selectedTab = 0; var selecetdCategoryForItemDetails = ""
    var isBackPack = false; var isPriority = false; var isAddToShoppingList = false; var selecetdBackPackTag: Int?
    var mainItemsOptionImgList: [UIImageView] = []; var mainItemsOptionLabelsList: [UILabel] = []
    var backPackLabelsList: [UILabel] = []; var backPackViewssList: [UIView] = []; var backPackImgessList: [UIImageView] = []
    let CatehoryDropDown = DropDown(); var categoryNameList: [String] = []
    var isDataViewSelecetd = false; var isItemViewSlecetd = false; var isSortedViewSlected = false
    var itemsBtn: [UIButton] = []; var dataBtns: [UIButton] = []; var sortedBtns: [UIButton] = []
    var itemSelectedTag: Int?; var dataSelcetdTag: Int?; var sortedSelecetdTag: Int?
    var dataHeaderViews: [UIView] = []; var dataHeaderLabels: [UILabel] = []; var dataHeaderImages: [UIImageView] = []
    var dataKeys: [String] = []; var itemsKeys: [String] = [];  var reloadForDeleteList: Bool = false
    var isReloadOnItemAdded: Bool = false; var isSeeAll: Bool = false; var isCheckedOnly = false; var isUnCheckedOnly = true;
   
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    ///viewDidLayoutSubviews...
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateOnViewDidLayoutSubview()
    }
    
    //MARK: - Functions...
    
    ///setupView...
    func setupView() { updateData(); registerTableViewCells(); setUpCollectionView(); getPackingOrPreprationCategoriesAndItems(type: "packing-list") }
    
    func updateOnViewDidLayoutSubview(){ DispatchQueue.main.async { self.tableViewHeightAnchor.constant = self.preprationTableView.contentSize.height + 50 } }
    
    ///setUpCollectionView...
    func setUpCollectionView(){ categoriesCollection.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier) }
    
    ///updateData...
    func updateData(){
        if let trip = trip { tripNameLabel.text = trip.name }
        packingSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        packingSegmentedControl.setTitleTextAttributes([.foregroundColor: Constants.lightGrey], for: .normal)
        packingSegmentedControl.selectedSegmentIndex = 0
        preprationData.append(PreprationData(imageUrl: "clock", title: "Early"))
        preprationData.append(PreprationData(imageUrl: "FewDaysOf", title: "Few days before"))
        preprationData.append(PreprationData(imageUrl: "return", title: "Days before"))
        preprationData.append(PreprationData(imageUrl: "dayoff", title: "Day of"))
        preprationData.append(PreprationData(imageUrl: "DurringTrip", title: "During Trip"))
        preprationData.append(PreprationData(imageUrl: "ReturningHome", title: "Returning home"))
        preprationData.append(PreprationData(imageUrl: "ArrivedHome", title: "Arrived home"))
        mainItemsOptionImgList = [bagPackImg, priorityImg, addToShoppingListImg]
        mainItemsOptionLabelsList = [bagPackLabel, priorityLabel, addToShoppingListLabel]
        backPackLabelsList = [bagPackLabel0, bagPackLabel1, bagPackLabel2, bagPackLabel3, bagPackLabel4]
        backPackViewssList = [bagPackView0, bagPackView1, bagPackView2, bagPackView3, bagPackView4]
        backPackImgessList = [bagPackImg0, bagPackImg1, bagPackImg2, bagPackImg3, bagPackImg4]
        dataBtns = [ dataViewBtn1, dataViewBtn2, dataViewBtn3]; sortedBtns = [sortedBtn1, sortedBtn2]
        itemsBtn = [itemViewBtn1, itemViewBtn2, itemViewBtn3, itemViewBtn4]
        dataHeaderViews = [DataMainViews, ItemsMainView, SortedMainViews]
        dataHeaderLabels = [dataHeaderLabel1, dataHeaderLabel2, dataHeaderLabel3]
        dataHeaderImages = [dataHeaderIcon1, dataHeaderIcon2, dataHeaderIcon3]
        dataKeys = ["All Items", "Packed Items", "Unpacked Items"]
        itemsKeys = ["Categories", "Bag", "Priority", "Timing"]
        setCategoryDropDownForItemsDetails()
    }
    
    ///setCategoryDropDownForItemsDetails...
    func setCategoryDropDownForItemsDetails(){
        CatehoryDropDown.bottomOffset = CGPoint(x: 0, y: dropDownAnchorView.frame.height - 10 )
        CatehoryDropDown.textFont = Constants.applyFonts_DMSans(style: .regular, size: 14)
        CatehoryDropDown.anchorView = dropDownAnchorView; CatehoryDropDown.direction = .bottom
        CatehoryDropDown.backgroundColor = .white; CatehoryDropDown.textColor = UIColor(hex: "#474847")
        CatehoryDropDown.selectedTextColor = UIColor(hex: "#E26A2B")
        CatehoryDropDown.separatorColor = UIColor(hex: "#CBCBCB", alpha: 0.30)
        CatehoryDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            let category = self?.dropDownCategoryList[index]; self?.categorynameLabel.text = item; self?.selecetdCategoryForItemDetails = category?.categoryId ?? ""
            if let imageUrl = URL(string: (category?.categoryImgUrl ?? "")) {
                self?.categoryIcon.kf.setImage(with: imageUrl, placeholder: UIImage(named: "IMGplaceholder"))
            }
        }
    }
    
    ///registerTableViewCells...
    func registerTableViewCells(){ preprationTableView.register(UINib(nibName: identifeir, bundle: nil), forCellReuseIdentifier: identifeir) }
    
    ///nowCreateAnPDFFileAndShare...
    func nowCreateAnPDFFileAndShare(){
        let packingitemsList = ["Passport", "Driver’s license", "Health Certificate", "T-shirts", "Hike boots", "Light sweater"]
        let packingListName = "Summer Holiday 2023"
        let packingMsg = "This is your  packing list for your trip to Paris"
        if let pdfData = generatePDFWithItemsList(itemsList: packingitemsList, projectTitle: packingListName, subHeader: packingMsg) {
            let activityViewController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        }
    }
    
    ///didTapOnItem...
    func didTapOnItem(item: PackingItem){
        
        if selectedTab == 1 { return }
        bottomView.isHidden = false; bottomDetailsView.isHidden = false
        self.bottomDetailsView.animateFromBottom(to: (self.window?.frame.height ?? 0) - 700, duration: 0.6)
        
        currentSelectedItem = item; itemNameLabel.text = item.name; quantityLabel.text = "\(item.quantity ?? 0)"
        if (item.quantity ?? 0) <= 0 { quantitySubtructBtn.backgroundColor = UIColor(hex: "#D9D9D9") }
        else { quantitySubtructBtn.backgroundColor = UIColor(hex: "#8A8A8A") }
        
        
        if item.description == "" { descriptionView.isHidden = true  } else { itemDescriptionLabel.text = item.description }
        if item.proTip == "" { proTipView.isHidden = true } else { proTipButoon.setTitle("\(item.proTip ?? "")", for: .normal) }
        categorynameLabel.text = item.primaryCategory?.name
        if let imageUrl = URL(string: (item.primaryCategory?.icon?.inactiveIcon ?? "")) {
            self.categoryIcon.kf.setImage(with: imageUrl, placeholder: UIImage(named: "IMGplaceholder"))
        }
        
        selecetdCategoryForItemDetails = item.primaryCategory?.id ?? ""
        isPriority = item.priority ?? false; isAddToShoppingList = item.toBuy ?? false
        if item.bagType == "" { resetTheBackPackOption(); updateItemsBagPackType(tag: 99) }
        else {
            DispatchQueue.main.async {
                let lebelIndex = Int(item.bagType ?? "0") ?? 0; self.bagPackLabel.textColor = UIColor(hex: "#E26A2B")
                self.isBackPack = true; self.bagPackLabel.text = self.backPackLabelsList[lebelIndex].text
                self.selecetdBackPackTag = nil; self.updateItemsBagPackType(tag: lebelIndex)
            }
        }; updateItemsMainOptions()
        
    }
    
    ///itemIsCheckUpdated...
    func itemIsCheckUpdated(selecetdItem: PackingItem){
        if selectedTab == 1 { return }
        if let trip = trip {
            var isCheckedUpdated = false;  var selcetdTabType = ""; var primaryCategoryId = selecetdCategoryForItemDetails
            if primaryCategoryId == "" { primaryCategoryId = selecetdItem.primaryCategory?.id ?? ""}
            if selecetdItem.isChecked == true { isCheckedUpdated = false } else { isCheckedUpdated = true }
            if selectedTab == 0 { selcetdTabType = "packing-list" } else { selcetdTabType = "prepration-list" }
            updateItemDetailsNow(tripId: trip.id ?? "", categoryId: selecetdItem.primaryCategory?.id ?? "", itemId: selecetdItem.id ?? "", listType: selcetdTabType, isChecked: isCheckedUpdated, quantity: selecetdItem.quantity ?? 1, bagType: selecetdItem.bagType ?? "", priority: isPriority, isToBuy: false, toBuy: selecetdItem.toBuy ?? false, primaryCategory: primaryCategoryId, isCommingForIsCheckedOnly: true)
        }
        else { self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " -> Trip not found") }
    }
    
    
    ///updateCollectionView...
    func updateCollectionView(isReloadOnItemAdded: Bool, indexPath: IndexPath, newData: CategoriesWithItems?, isSeeAll: Bool, reloadForDeleteList: Bool){
        self.isReloadOnItemAdded = isReloadOnItemAdded; self.isSeeAll = isSeeAll; self.reloadForDeleteList = reloadForDeleteList
        if !isReloadOnItemAdded { categoriesWithItemData[indexPath.item] = newData!; preprationTableView.reloadData() }  /// handle reload on add item or just for reload ....
        else { preprationTableView.reloadRows(at: [indexPath], with: .none) }
        //updateBadge()
    }
    
    
    
    ///updateItemsMainOptions...
    func updateItemsMainOptions(){
        if isPriority { mainItemsOptionImgList[1].tintColor = UIColor(hex: "#E26A2B"); mainItemsOptionLabelsList[1].textColor = UIColor(hex: "#E26A2B")
        } else { mainItemsOptionImgList[1].tintColor = UIColor(hex: "#474847"); mainItemsOptionLabelsList[1].textColor = UIColor(hex: "#474847") }
        if isAddToShoppingList { mainItemsOptionImgList[2].tintColor = UIColor(hex: "#E26A2B"); mainItemsOptionLabelsList[2].textColor = UIColor(hex: "#E26A2B") }
        else { mainItemsOptionImgList[2].tintColor = UIColor(hex: "#474847"); mainItemsOptionLabelsList[2].textColor = UIColor(hex: "#474847") }
    }
    
    ///updateItemsBagPackType..
    func updateItemsBagPackType(tag: Int){
        backPackLabelsList.forEach { label in
            if label.tag == tag && selecetdBackPackTag != tag { label.textColor = UIColor(hex: "#E26A2B") }
            else { if selecetdBackPackTag == tag { resetTheBackPackOption() }; label.textColor = UIColor(hex: "#474847", alpha: 0.8) }
        }
        backPackViewssList.forEach { view in
            if view.tag == tag && selecetdBackPackTag != tag  { view.layer.borderColor = UIColor(hex: "#E26A2B").cgColor }
            else { if selecetdBackPackTag == tag { resetTheBackPackOption() }; view.layer.borderColor = UIColor(hex: "#EBEBEB").cgColor }
        }
        
        backPackImgessList.forEach { imageView in
            if imageView.tag == tag && selecetdBackPackTag != tag  { imageView.tintColor = UIColor(hex: "#E26A2B") }
            else { if selecetdBackPackTag == tag { resetTheBackPackOption() }; imageView.tintColor = UIColor(hex: "#8A8A8A") }
        }
        
        if tag == 99 {
            backPackLabelsList.forEach { label in label.textColor = UIColor(hex: "#474847", alpha: 0.8) }
            backPackViewssList.forEach { view in view.layer.borderColor = UIColor(hex: "#EBEBEB").cgColor }
            backPackImgessList.forEach { view in view.layer.borderColor = UIColor(hex: "#EBEBEB").cgColor }
            resetTheBackPackOption()
        }
        else if selecetdBackPackTag != tag {
            selecetdBackPackTag = tag; isBackPack = true; bagPackLabel.text = backPackLabelsList[tag].text
            mainItemsOptionImgList[0].tintColor = UIColor(hex: "#E26A2B")
            mainItemsOptionLabelsList[0].textColor = UIColor(hex: "#E26A2B")
            bagPackImg.image = backPackImgessList[tag].image; bagPackImg.tintColor = UIColor(hex: "#E26A2B")
        }
        else if selecetdBackPackTag == tag { selecetdBackPackTag = nil }
    }
    
    ///resetTheBackPackOption..
    func resetTheBackPackOption(){
        bagPackLabel.text = "Bag"; bagPackImg.image = backPackImgessList[0].image;
        bagPackImg.tintColor = UIColor(hex: "#474847") ; bagPackLabel.textColor = UIColor(hex: "#474847")
    }
    
    ///handleBackPackMainOptionBtnAction...
    func handleBackPackMainOptionBtnAction(tag: Int){
        if tag == 0 { backPackMainView.isHidden.toggle() }
        else if tag == 1 { isPriority.toggle(); updateItemsMainOptions() }
        else if tag == 2 { isAddToShoppingList.toggle(); updateItemsMainOptions() }
    }
    
    ///updateCounter...
    func updateCounter(tag: Int){
        if tag == 0 { // - btn
            var quantity = Int(quantityLabel.text ?? "0") ?? 0
            if quantity != 0 { quantity = quantity - 1; quantityLabel.text = "\(quantity)" }
            if quantity <= 0 { quantitySubtructBtn.backgroundColor = UIColor(hex: "#D9D9D9") }
            else { quantitySubtructBtn.backgroundColor = UIColor(hex: "#8A8A8A") }
        }
        else { // + btn
            var quantity = Int(quantityLabel.text ?? "0") ?? 0
            quantity = quantity + 1; quantityLabel.text = "\(quantity)"
            if quantity <= 0 { quantitySubtructBtn.backgroundColor = UIColor(hex: "#D9D9D9") }
            else { quantitySubtructBtn.backgroundColor = UIColor(hex: "#8A8A8A") }
        }
    }
    
    func handleSaveItemDetailBtnAction(){
        if let trip = trip, let selecetdItem = currentSelectedItem {
            var selcetdTabType = ""; let quantity = (Int(quantityLabel.text ?? "1") ?? 1)
            var selectedBagTag = ""; var isToBuy = false
            if selecetdItem.toBuy != isAddToShoppingList { isToBuy = true }
            if selecetdBackPackTag == 99 || selecetdBackPackTag == nil { selectedBagTag = "" } else { selectedBagTag = "\(selecetdBackPackTag ?? 99)" }
            if selectedTab == 0 { selcetdTabType = "packing-list" } else { selcetdTabType = "prepration-list" }
            updateItemDetailsNow(tripId: trip.id ?? "", categoryId: selecetdItem.primaryCategory?.id ?? "", itemId: selecetdItem.id ?? "", listType: selcetdTabType, isChecked: selecetdItem.isChecked ?? false, quantity: quantity, bagType: selectedBagTag, priority: isPriority, isToBuy: isToBuy, toBuy: isAddToShoppingList, primaryCategory: selecetdCategoryForItemDetails, isCommingForIsCheckedOnly: false)
        }
        else { self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " -> Trip not found") }
    }
    
    ///handleItemDetailHideViewAction..
    func handleItemDetailHideViewAction(){
        DispatchQueue.main.async {
            self.bottomDetailsView.animateHideToBottom(duration: 0.5) { self.bottomDetailsView.isHidden = true; self.bottomView.isHidden = true }
        }
    }
    
    ///handleDataViewBtnAction...
    func handleDataViewBtnAction(){ dataView.isHidden.toggle(); itemView.isHidden = true; sortView.isHidden = true }
    
    ///handleItemViewBtnAction...
    func handleItemViewBtnAction(){ itemView.isHidden.toggle(); dataView.isHidden = true; sortView.isHidden = true }
    
    ///handleSortViewBtnAction...
    func handleSortViewBtnAction(){ sortView.isHidden.toggle(); dataView.isHidden = true; itemView.isHidden = true }
    
    ///handleMainHeaderSelection...
    func handleMainHeaderSelection(){
        
        if dataSelcetdTag != nil { ///For data view...
            dataHeaderViews[0].backgroundColor = UIColor(hex: "#E26A2B"); dataHeaderImages[0].tintColor = .white; dataHeaderLabels[0].textColor = .white
            dataHeaderLabels[0].text = dataKeys[dataSelcetdTag!]
        }
        else {
            dataHeaderViews[0].backgroundColor = UIColor(hex: "#A4A4A4", alpha: 0.3); dataHeaderImages[0].tintColor = UIColor(hex: "#8A8A8A")
            dataHeaderLabels[0].textColor = UIColor(hex: "#8A8A8A")
            dataHeaderLabels[0].text = "Unpacked Items"
        }
        
        if itemSelectedTag != nil { /// For items view...
            dataHeaderViews[1].backgroundColor = UIColor(hex: "#E26A2B"); dataHeaderImages[1].tintColor = .white; dataHeaderLabels[1].textColor = .white
            dataHeaderLabels[1].text = itemsKeys[itemSelectedTag!]
        }
        else {
            dataHeaderViews[1].backgroundColor = UIColor(hex: "#A4A4A4", alpha: 0.3); dataHeaderImages[1].tintColor = UIColor(hex: "#8A8A8A")
            dataHeaderLabels[1].textColor = UIColor(hex: "#8A8A8A")
            dataHeaderLabels[1].text = "Categories"
        }
        
        if sortedSelecetdTag != nil { /// For sorted view...
            dataHeaderViews[2].backgroundColor = UIColor(hex: "#E26A2B"); dataHeaderImages[2].tintColor = .white; dataHeaderLabels[2].textColor = .white
        }
        else {
            dataHeaderViews[2].backgroundColor = UIColor(hex: "#A4A4A4", alpha: 0.3); dataHeaderImages[2].tintColor = UIColor(hex: "#8A8A8A")
            dataHeaderLabels[2].textColor = UIColor(hex: "#8A8A8A")
        }
        hideAllFilterView(); updateCollectionDataAccrodingFilters()
    }
    
    ///hideAllFilterView...
    func hideAllFilterView(){ dataView.isHidden = true; itemView.isHidden = true; sortView.isHidden = true }
    
    ///updateCollectionDataAccrodingFilters...
    func updateCollectionDataAccrodingFilters(){
        if dataSelcetdTag != nil {
            self.showRappleActivity()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { self.hideRappleActivity() }
            if dataSelcetdTag == 0 { isSeeAll = true; isCheckedOnly = false; isUnCheckedOnly = false }
            else if dataSelcetdTag == 1 { isSeeAll = false; isCheckedOnly = true; isUnCheckedOnly = false  }
            else if dataSelcetdTag == 2 { isSeeAll = false; isCheckedOnly = false; isUnCheckedOnly = true  }
        }
        DispatchQueue.main.async { self.preprationTableView.reloadData() }
        
    }
    
    ///handleDataViewInnerBtnsAction...
    func handleDataViewInnerBtnsAction(tag: Int){
        dataBtns.forEach { btn in
            if btn.tag == tag {
                if let currentSelectedTag = dataSelcetdTag, currentSelectedTag == btn.tag { /// This button is already selected, so deselect it
                    dataSelcetdTag = nil; btn.titleLabel?.font = Constants.applyFonts_DMSans(style: .regular, size: 13)
                    btn.setTitleColor(UIColor(hex: "#8A8A8A"), for: .normal)
                } else { /// This button is not selected, so select it
                    dataSelcetdTag = btn.tag; btn.titleLabel?.font = Constants.applyFonts_DMSans(style: .Medium, size: 13)
                    btn.setTitleColor(UIColor(hex: "#003681"), for: .normal)
                }
            } else { ///// Deselect other buttons...
                btn.titleLabel?.font = Constants.applyFonts_DMSans(style: .regular, size: 13)
                btn.setTitleColor(UIColor(hex: "#8A8A8A"), for: .normal)
            }
        }; handleMainHeaderSelection()
    }
    
    ///handleitemViewInnerBtnAction...
    func handleItemViewInnerBtnAction(tag: Int){
        itemsBtn.forEach { btn in
            if btn.tag == tag {
                if let currentSelectedTag = itemSelectedTag, currentSelectedTag == btn.tag { /// This button is already selected, so deselect it
                    itemSelectedTag = nil; btn.titleLabel?.font = Constants.applyFonts_DMSans(style: .regular, size: 13)
                    btn.setTitleColor(UIColor(hex: "#8A8A8A"), for: .normal)
                } else { /// This button is not selected, so select it
                    itemSelectedTag = btn.tag; btn.titleLabel?.font = Constants.applyFonts_DMSans(style: .Medium, size: 13)
                    btn.setTitleColor(UIColor(hex: "#003681"), for: .normal)
                }
            } else { /// Deselect other buttons/
                btn.titleLabel?.font = Constants.applyFonts_DMSans(style: .regular, size: 13)
                btn.setTitleColor(UIColor(hex: "#8A8A8A"), for: .normal)
            }
        };  handleMainHeaderSelection()
    }
    
    ///handleSortedViewInnerBtnAction...
    func handleSortedViewInnerBtnAction(tag: Int){
        sortedBtns.forEach { btn in
            if btn.tag == tag {
                if let currentSelectedTag = sortedSelecetdTag, currentSelectedTag == btn.tag { /// This button is already selected, so deselect it
                    sortedSelecetdTag = nil; btn.titleLabel?.font = Constants.applyFonts_DMSans(style: .regular, size: 13)
                    btn.setTitleColor(UIColor(hex: "#8A8A8A"), for: .normal)
                } else { /// This button is not selected, so select it
                    sortedSelecetdTag = btn.tag; btn.titleLabel?.font = Constants.applyFonts_DMSans(style: .Medium, size: 13)
                    btn.setTitleColor(UIColor(hex: "#003681"), for: .normal)
                }
            } else { /// Deselect other buttons
                btn.titleLabel?.font = Constants.applyFonts_DMSans(style: .regular, size: 13)
                btn.setTitleColor(UIColor(hex: "#8A8A8A"), for: .normal)
            }
        };  handleMainHeaderSelection()
    }
    
    
    
    //MARK: - Actions...
    
    ///backBtnAction...
    @IBAction func backBtnAction(_ sender: Any) { self.popToRootViewController() }
    
    ///DidChangeSegmentController...
    @IBAction func DidChangeSegmentController(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 { PreparingHeaderLabel.isHidden = true; selectedTab = 0; getPackingOrPreprationCategoriesAndItems(type: "packing-list") }
        else { PreparingHeaderLabel.isHidden = false; selectedTab = 1; getPackingOrPreprationCategoriesAndItems(type: "prepration-list") }
    }
    
    ///sharePackingListBtnAction...
    @IBAction func sharePackingListBtnAction(_ sender: Any) { nowCreateAnPDFFileAndShare() }
    
    ///printpackingListBtnAction...
    @IBAction func printpackingListBtnAction(_ sender: Any) {
        self.pushViewController(storyboard: "Home", identifier: "PrintViewController")
    }
    
    ///printAndShareCloseBtnAction...
    @IBAction func printAndShareCloseBtnAction(_ sender: Any) {
        shareAndPrintDetailView.animateHideToBottom(duration: 0.3) { self.ShareAndPrintMainView.isHidden = true }
    }
    
    ///quantityBtnAction...
    @IBAction func quantityBtnAction(_ sender: UIButton) { updateCounter(tag: sender.tag) }
    
    ///saveItemDetailsBtnAction...
    @IBAction func saveItemDetailsBtnAction(_ sender: Any) { if selectedTab == 0 { handleSaveItemDetailBtnAction() } }
    
    ///bagPackBtnAction...
    @IBAction func bagPackBtnAction(_ sender: UIButton) { updateItemsBagPackType(tag: sender.tag) }
    
    ///backPackMainOptionBtnAction...
    @IBAction func backPackMainOptionBtnAction(_ sender: UIButton) { handleBackPackMainOptionBtnAction(tag: sender.tag) }
    
    ///closeItemBtnAction..
    @IBAction func closeItemBtnAction(_ sender: Any) { handleItemDetailHideViewAction() }
    
    ///showCategoryListForItemsBtnAction...
    @IBAction func showCategoryListForItemsBtnAction(_ sender: Any) { CatehoryDropDown.show() }
    
    ///dataViewBtnAction...
    @IBAction func dataViewBtnAction(_ sender: Any) { handleDataViewBtnAction() }
    
    ///itemViewBtnAction...
    @IBAction func itemViewBtnAction(_ sender: Any) { handleItemViewBtnAction() }
    
    ///sortViewBtnAction...
    @IBAction func sortViewBtnAction(_ sender: Any) { handleSortViewBtnAction() }
    
    ///dataViewInnerBtnsAction...
    @IBAction func dataViewInnerBtnsAction(_ sender: UIButton) { handleDataViewInnerBtnsAction(tag: sender.tag) }
    
    ///itemViewInnerBtnAction...
    @IBAction func itemViewInnerBtnAction(_ sender: UIButton) { handleItemViewInnerBtnAction(tag: sender.tag) }
    
    ///sortedViewInnerBtnAction...
    @IBAction func sortedViewInnerBtnAction(_ sender: UIButton) { handleSortedViewInnerBtnAction(tag: sender.tag) }
    
}

//MARK: - CollectionView Delegate & DataSource ...
extension PackingListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    ///numberOfItemsInSection...
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedTab == 0 { return currentCategories.count } else { return preprationData.count }
    }
    
    ///cellForItemAt...
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PackingPreprationCategoryCell
        if selectedTab == 0 { cell.data = currentCategories[indexPath.item]; cell.preprationData = nil } else { cell.preprationData = preprationData[indexPath.item]; cell.data = nil }
        return cell
    }
    
    ///sizeForItemAt...
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if selectedTab == 0 {
            let category = currentCategories[indexPath.item]; var width: CGFloat = 70
            let estimatedWidth = estimatedTextWidth(for: category.name ?? "", font: Constants.applyFonts_DMSans(style: .Medium, size: 12), width: collectionView.frame.width)
            if estimatedWidth > 70 { width = estimatedWidth }
            return CGSize(width: width, height: 70)
        }
        else {
            let category = preprationData[indexPath.item]; var width: CGFloat = 70
            let estimatedWidth = estimatedTextWidth(for: category.title, font: Constants.applyFonts_DMSans(style: .Medium, size: 12), width: collectionView.frame.width)
            if estimatedWidth > 70 { width = estimatedWidth }
            return CGSize(width: width, height: 70)
        }
    }
    
}

// MARK: - TableView View DataScorce and Delegate...
extension PackingListVC: UITableViewDataSource, UITableViewDelegate {
    
    ///numberOfRowsInSection...
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(categoriesWithItemData)
        if !categoriesWithItemData.isEmpty {
            var totalNumbersOfRow = 0
            
            if isCheckedOnly {
                categoriesWithItemData.forEach { data in
                    var checkedOnly = 0
                    data.items?.forEach({ item in if item.isChecked ?? false { checkedOnly = checkedOnly + 1 } })
                    if checkedOnly > 0 { totalNumbersOfRow = totalNumbersOfRow + 1 }
                }
            }
            
            else if isUnCheckedOnly {
                categoriesWithItemData.forEach { data in
                    var unCheckedOnly = 0
                    data.items?.forEach({ item in   if (item.isChecked ?? false) == false { unCheckedOnly = unCheckedOnly + 1 } })
                    if unCheckedOnly > 0 { totalNumbersOfRow = totalNumbersOfRow + 1 }
                }
            }
            
            else if isSeeAll { totalNumbersOfRow = categoriesWithItemData.count }
            return totalNumbersOfRow
        }
        else { return 0 }
        
        
        
        
    }
    
    ///cellForRowAt...
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifeir, for: indexPath) as! ShopingListTableViewCell
        cell.reloadForDeleteList = self.reloadForDeleteList; cell.isSeeAll = self.isSeeAll; cell.isReloadOnItemAdded = self.isReloadOnItemAdded
        cell.isCheckedOnly = self.isCheckedOnly; cell.indexPath = indexPath; cell.isUnCheckedOnly = self.isUnCheckedOnly
        cell.packingNewDataSource = categoriesWithItemData[indexPath.row]
        cell.setUpBGView(); cell.dataForPackingAndPreprationList = categoriesWithItemData[indexPath.row]
        self.viewDidLayoutSubviews(); cell.delegateForPackingList = self
        return cell
    }
    
}


//MARK: - Network layer...
extension PackingListVC {
    
    ///getPackingOrPreprationCategoriesAndItems...
    func getPackingOrPreprationCategoriesAndItems(type: String){
        if let trip  = trip {
            self.showRappleActivity(); packingAndPreprationData.removeAll()
            Constants.tripSavaServcesManager.getPackingOrPreprationCategoriesAndItems(tripId: trip.id ?? "", type: type) { resultent in
                switch resultent {
                case .success(let response): self.hideRappleActivity(); self.packingAndPreprationData = response.list ?? []; self.handleSuccessResponse()
                case .failure(let error): self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " -> \n\(error)")
                }
            }
        } else { self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " -> Trip not found") }
    }
    
    ///handleSuccessResponse..
    func handleSuccessResponse(){
        categoriesWithItemData.removeAll(); categoryNameList.removeAll(); dropDownCategoryList.removeAll()
        for item in packingAndPreprationData {
            if let category = item.primaryCategory {
                /// Check if a category with the same adminCategoryId already exists
                if let index = categoriesWithItemData.firstIndex(where: { $0.name == category.name }) {
                    var existingCategory = categoriesWithItemData[index]
                    existingCategory.items?.append(item);  categoriesWithItemData[index] = existingCategory
                }
                else { /// If not, create a new category and add the item to it
                    let newCategoryWithItem = CategoriesWithItems( id: category.id, name: category.name, adminCategoryId: category.adminCategoryId, icon: category.icon, items: [item] ); categoriesWithItemData.append(newCategoryWithItem)
                }
            }
        }
        
        if selectedTab == 0 {
            currentCategories.removeAll(); categoriesWithItemData.forEach { category in
                let updatedCategory = PackingOrPackingCategory(id: category.id, name: category.name, adminCategoryId: category.adminCategoryId, icon: category.icon)
                currentCategories.append(updatedCategory)
                let dropDownCategory = DropDownCategoryList(categoryName: category.name, categoryImgUrl: category.icon?.inactiveIcon, categoryId: category.id)
                if let name = category.name { dropDownCategoryList.append(dropDownCategory); categoryNameList.append(name) }
            }
        }
        CatehoryDropDown.dataSource = categoryNameList; CatehoryDropDown.reloadInputViews()
        self.categoriesCollection.reloadData(); self.preprationTableView.reloadData()
        bottomView.isHidden = true; bottomDetailsView.isHidden = true
    }
    
    ///updateItemDetailsNow...
    func updateItemDetailsNow(tripId: String, categoryId: String, itemId: String, listType: String, isChecked: Bool, quantity: Int, bagType: String, priority: Bool, isToBuy: Bool, toBuy: Bool, primaryCategory: String, isCommingForIsCheckedOnly: Bool){
        if !isCommingForIsCheckedOnly { self.showRappleActivity() }
        Constants.tripSavaServcesManager.updatePackingList(tripId: tripId, categoryId: categoryId, itemId: itemId, listType: listType, isChecked: isChecked, quantity: quantity, bagType: bagType, priority: priority, isToBuy: isToBuy, toBuy: toBuy, primaryCategory: primaryCategory) { resultent in
            switch resultent {
            case .success(let response): self.hideRappleActivity(); self.packingAndPreprationData = response.list ?? []; self.handleSuccessResponse()
            case .failure(let error): self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " -> \n\(error)")
            }
        }
    }
 
    
} 
