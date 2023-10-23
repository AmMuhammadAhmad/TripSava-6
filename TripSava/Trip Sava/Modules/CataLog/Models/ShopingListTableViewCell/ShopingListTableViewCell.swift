//
//  ShopingListTableViewCell.swift
//  TripsavaApkDesign
//
//  Created by HF on 12/06/2023.
//

import UIKit

class ShopingListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets...
    @IBOutlet weak var shopingListCityLbl: UILabel!
    @IBOutlet weak var shopingListItemStack: UIStackView!
    @IBOutlet weak var shopingListCellView: UIView!
    @IBOutlet weak var dropBownBtn: UIButton!
    @IBOutlet weak var toggleBtn: UIButton!
    @IBOutlet weak var addItemButton: UIButton!
    @IBOutlet weak var addBtnHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var checkAllBtn: UIButton!
    @IBOutlet weak var seeAllBtn: UIButton!
    @IBOutlet weak var toBuyBtn: UIButton! 
    @IBOutlet weak var deleteBtn: UIButton!
    
    // MARK: - Variables...
    var delegate: ShopingListViewController?
    var delegateForPackingList: PackingListVC?
    var isReloadOnItemAdded: Bool?
    var indexPath: IndexPath?
    var newDataSource: ShoppingListResults?
    var isSeeAll: Bool?; var isCheckedOnly: Bool?; var isUnCheckedOnly: Bool?
    var dropDownIsChecked = false
    var reloadForDeleteList: Bool?
    var packingNewDataSource: CategoriesWithItems?
    var emptyItemsIndex: [IndexPath] = []
    
    ///dataForShoppingListVC...
    var dataForShoppingListVC: ShoppingListResults? {
        didSet {
            ///handle data
            guard let data = dataForShoppingListVC else { return }
            shopingListItemStack.removeFullyAllArrangedSubviews()
            shopingListCityLbl.text = data.name
            dropBownBtn.isHidden = true
            
            if let items = data.items {
                if items.isEmpty { emptyView.isHidden = false }
                else { emptyView.isHidden = true }
                for (_, value) in items.enumerated() {
                     
                    ///hide that if already check...
                    if (value.isChecked ?? false) && (isSeeAll ?? false) {
                        let customView = CustomPackingView()
                        customView.heightAnchor.constraint(equalToConstant: 40).isActive = true
                        customView.label.text = value.name; customView.itemId = value.id!
                        if value.isChecked ?? false { customView.radioButton.setImage(UIImage(named: "SeeAllCheck"), for: .normal) }
                        else { customView.radioButton.setImage(UIImage(named: "uncheckedTick"), for: .normal) }
                        customView.label.textColor = UIColor(hex: "#CCCCCC")
                        
                        // handle btn actions...
                        /// check btn acttion...
                        customView.radioBtnAction = { itemId in
                            var selectedItem: ShoppingListItems?
                            data.items?.forEach({ item in  if item.id == itemId { selectedItem = item } })
                            if let item = selectedItem {
                                ///Update the item checked btn action...
                                self.updateShoppingListItem(name: item.name ?? "", isChecked: !(item.isChecked ?? false), shoppingListId: data.id ?? "", itemId: item.id ?? "", customView: customView)
                            }
                        }
                        
                        ///shopBtnAction...
                        customView.shopBtnAction = { itemId in
                            var selectedItem: ShoppingListItems?
                            data.items?.forEach({ item in  if item.id == itemId { selectedItem = item } })
                            if let name = selectedItem?.name { self.goToSearchproductNow(itemName: name) }
                        }
                        
                        ///update spacing of stack view...
                        if customView.label.countLines() == 2 { shopingListItemStack.spacing = 20 } else { shopingListItemStack.spacing = 0 }
                        shopingListItemStack.addArrangedSubview(customView)
                        customView.addSwipeToDeleteGesture(item: value) { removedItem in
                            self.delegate?.showCustomDeletMessageView(message: "Are you sure you want to delete this item?", deleteBtnAction: {
                                self.deleteShoppinhListItem(shoppingListId: data.id ?? "", itemId: removedItem.id ?? "")
                            })
                        }
                    }
                    else { /// else show only that are not checked...
                        if !(value.isChecked ?? false) {
                            let customView = CustomPackingView()
                            customView.heightAnchor.constraint(equalToConstant: 40).isActive = true
                            customView.label.text = value.name; customView.itemId = value.id!
                            if value.isChecked ?? false { customView.radioButton.setImage(UIImage(named: "check"), for: .normal) }
                            else { customView.radioButton.setImage(UIImage(named: "uncheckedTick"), for: .normal) }
                            
                            // handle btn actions...
                            /// check btn acttion...
                            customView.radioBtnAction = { itemId in
                                var selectedItem: ShoppingListItems?
                                data.items?.forEach({ item in  if item.id == itemId { selectedItem = item } })
                                if let item = selectedItem {
                                    ///Update the item checked btn action...
                                    self.updateShoppingListItem(name: item.name ?? "", isChecked: !(item.isChecked ?? false), shoppingListId: data.id ?? "", itemId: item.id ?? "", customView: customView)
                                }
                            }
                            
                            ///shopBtnAction...
                            customView.shopBtnAction = { itemId in
                                var selectedItem: ShoppingListItems?
                                data.items?.forEach({ item in  if item.id == itemId { selectedItem = item } })
                                if let name = selectedItem?.name { self.goToSearchproductNow(itemName: name) }
                            }
                            
                            ///update spacing of stack view...
                            if customView.label.countLines() == 2 { shopingListItemStack.spacing = 20 } else { shopingListItemStack.spacing = 0 }
                            shopingListItemStack.addArrangedSubview(customView)
                            
                            customView.addSwipeToDeleteGesture(item: value) { removedItem in
                                self.delegate?.showCustomDeletMessageView(message: "Are you sure you want to delete this item?", deleteBtnAction: {
                                    self.deleteShoppinhListItem(shoppingListId: data.id ?? "", itemId: removedItem.id ?? "")
                                })
                            }
                        }
                    }
                }
            }
            else { emptyView.isHidden = false }
              
            /// Handel the Add new Item...
            if isReloadOnItemAdded ?? false  {
                let addItemView = CustomAddNewItem()
                addItemView.heightAnchor.constraint(equalToConstant: 60).isActive = true
                addItemView.AddBtnAction  = { itemName in 
                    if let items = data.items {
                        let isItemContain = items.contains { item in  item.name?.contains(itemName) == true }
                        
                        if isItemContain {
                            let addBtnAction = UIAlertAction(title: "Add", style: .default) { isComplected in
                                self.shopingListItemStack.arrangedSubviews.forEach { subview in  if subview.tag == 100 { subview.removeFromSuperview() } }
                                self.shopingListItemStack.reloadInputViews(); self.addItemButton.isHidden = false; self.addBtnHeightAnchor.constant = 44
                                self.addNewItemIntoShoppingList(trip: "", product: "", name: itemName, isCustom: true)
                            }
                            self.delegate?.presentAlertAndGotoThatYesNoFunction(withTitle: "Alert", message: "This item has already been added. Do you want to add this item again?", OKAction: addBtnAction)
                        }
                        else {
                            self.shopingListItemStack.arrangedSubviews.forEach { subview in  if subview.tag == 100 { subview.removeFromSuperview() } }
                            self.shopingListItemStack.reloadInputViews(); self.addItemButton.isHidden = false; self.addBtnHeightAnchor.constant = 44
                            self.addNewItemIntoShoppingList(trip: "", product: "", name: itemName, isCustom: true)
                        }
                    }
                }
                shopingListItemStack.addArrangedSubview(addItemView); shopingListItemStack.reloadInputViews()
                addItemButton.isHidden = true; addBtnHeightAnchor.constant = 0; emptyView.isHidden = true
            }
            else { addItemButton.isHidden = false; addBtnHeightAnchor.constant = 44 }
            if reloadForDeleteList ?? false { if (data.items?.count ?? 0) <= 0 { emptyView.isHidden = false } else { emptyView.isHidden = true } }
             
            ///update dropdownBtns...
            self.updateDropDownView()
        }
    }
   
    ///dataForPackingListVC...
    var dataForPackingListVC: Bool? {
        didSet {
            shopingListItemStack.removeFullyAllArrangedSubviews()
            let customView1 = CustomPrepationView(); let customView2 = CustomPrepationView(); let customView3 = CustomPrepationView()
            customView3.DescriptionLable.text = "Amet diam et quis praesent."; customView3.lineLable.isHidden = true
            shopingListItemStack.addArrangedSubview(customView1); shopingListItemStack.addArrangedSubview(customView2)
            shopingListItemStack.addArrangedSubview(customView3); dropBownBtn.isHidden = false
            if customView1.label.countLines() == 2 { shopingListItemStack.spacing = 20 } else { shopingListItemStack.spacing = 0 }
        }
    }
    
     
    ///dataForPackingAndPreprationList...
    var dataForPackingAndPreprationList: CategoriesWithItems? {
        didSet {
            guard let data = dataForPackingAndPreprationList else { return }
            shopingListItemStack.removeFullyAllArrangedSubviews()
            shopingListCityLbl.text = data.name; dropBownBtn.isHidden = false
             
            if let items = data.items {
                
                print(items)
                
                if items.isEmpty {
                    
                    emptyView.isHidden = false;
                    
                    
                } else { emptyView.isHidden = true }
                
                
                for (_, value) in items.enumerated() {
                    
                    if isSeeAll == true && isCheckedOnly == false && isUnCheckedOnly == false {
                        let customView = CustomPrepationView()
//                        customView.heightAnchor.constraint(equalToConstant: 40).isActive = true
                        customView.label.text = value.name; customView.itemId = value.id!
                        if value.isChecked ?? false { customView.radioButton.setImage(UIImage(named: "SeeAllCheck"), for: .normal); customView.label.textColor = UIColor(hex: "#CCCCCC") }
                        else { customView.radioButton.setImage(UIImage(named: "uncheckedTick"), for: .normal) }
                        customView.updateTags()
                        
                        // handle btn actions...
                        /// check btn acttion...
                        customView.radioBtnAction = { itemId in
                            customView.radioButton.isUserInteractionEnabled = false
                            if value.isChecked ?? false { customView.radioButton.setImage(UIImage(named: "uncheckedTick"), for: .normal) }
                            else { customView.radioButton.setImage(UIImage(named: "check"), for: .normal); customView.label.textColor = UIColor(hex: "#CCCCCC") }
                            DispatchQueue.main.asyncAfter(deadline: .now() ) { self.delegateForPackingList?.itemIsCheckUpdated(selecetdItem: value) }
                        }
                        
                        ///Handle didTapItemBtnAction...
                        customView.item = value
                        customView.didTapItemBtnAction = { item in
                            self.delegateForPackingList?.didTapOnItem(item: item)
                        }
                         
                        ///update spacing of stack view...
                        if customView.label.countLines() == 2 { shopingListItemStack.spacing = 20 } else { shopingListItemStack.spacing = 0 }
                        shopingListItemStack.addArrangedSubview(customView)
//                        customView.addSwipeToDeleteGesture(item: value) { removedItem in
//                            self.delegate?.showCustomDeletMessageView(message: "Are you sure you want to delete this item?", deleteBtnAction: {
//                                self.deleteShoppinhListItem(shoppingListId: data.id ?? "", itemId: removedItem.id ?? "")
//                            })
//                        }
                    }
                     
                    ///hide that if already check...
                    else if (value.isChecked ?? false) && (isCheckedOnly == true) {
                        let customView = CustomPrepationView()
//                        customView.heightAnchor.constraint(equalToConstant: 40).isActive = true
                        customView.label.text = value.name; customView.itemId = value.id!
                        if value.isChecked ?? false { customView.radioButton.setImage(UIImage(named: "SeeAllCheck"), for: .normal) }
                        else { customView.radioButton.setImage(UIImage(named: "uncheckedTick"), for: .normal) }
                        customView.label.textColor = UIColor(hex: "#CCCCCC")
                        customView.updateTags()
                        
                        // handle btn actions...
                        /// check btn acttion...
                        customView.radioBtnAction = { itemId in
                            customView.radioButton.isUserInteractionEnabled = false
                            if value.isChecked ?? false { customView.radioButton.setImage(UIImage(named: "uncheckedTick"), for: .normal) }
                            else { customView.radioButton.setImage(UIImage(named: "check"), for: .normal); customView.label.textColor = UIColor(hex: "#CCCCCC") }
                            DispatchQueue.main.asyncAfter(deadline: .now() ) { self.delegateForPackingList?.itemIsCheckUpdated(selecetdItem: value) }
                        }
                        
                        ///Handle didTapItemBtnAction...
                        customView.item = value
                        customView.didTapItemBtnAction = { item in
                            self.delegateForPackingList?.didTapOnItem(item: item)
                        }
                         
                        ///update spacing of stack view...
                        if customView.label.countLines() == 2 { shopingListItemStack.spacing = 20 } else { shopingListItemStack.spacing = 0 }
                        shopingListItemStack.addArrangedSubview(customView)
//                        customView.addSwipeToDeleteGesture(item: value) { removedItem in
//                            self.delegate?.showCustomDeletMessageView(message: "Are you sure you want to delete this item?", deleteBtnAction: {
//                                self.deleteShoppinhListItem(shoppingListId: data.id ?? "", itemId: removedItem.id ?? "")
//                            })
//                        }
                    }
                    else  if !(value.isChecked ?? false) && isUnCheckedOnly == true { /// else show only that are not checked...
                        if !(value.isChecked ?? false) {
                            let customView = CustomPrepationView()
                            //customView.heightAnchor.constraint(equalToConstant: 42).isActive = true
                            customView.label.text = value.name; customView.itemId = value.id!
                            customView.numberBtn.setTitle("\(Int(value.quantity ?? 1))", for: .normal)
                            
                            
                            if (value.quantity ?? 0) >= 2 { customView.isQuantity = true }
                            if value.proTip != "" { customView.isProtips = true }
                            customView.isShoppingList = value.toBuy ?? false
                            customView.isproirty = value.priority ?? false
                            customView.updateTags()
                            
                            if value.isChecked ?? false { customView.radioButton.setImage(UIImage(named: "check"), for: .normal) }
                            else { customView.radioButton.setImage(UIImage(named: "uncheckedTick"), for: .normal) }
                            
                            // handle btn actions...
                            /// check btn acttion...
                            customView.radioBtnAction = { itemId in
                                customView.radioButton.isUserInteractionEnabled = false
                                if value.isChecked ?? false {
                                    customView.radioButton.setImage(UIImage(named: "check"), for: .normal) }
                                else {
                                    customView.radioButton.setImage(UIImage(named: "SeeAllCheck"), for: .normal); customView.label.textColor = UIColor(hex: "#CCCCCC") }
                                DispatchQueue.main.asyncAfter(deadline: .now()) { self.delegateForPackingList?.itemIsCheckUpdated(selecetdItem: value) }
                            }
                            
                            
                            ///Handle didTapItemBtnAction...
                            customView.item = value
                            customView.didTapItemBtnAction = { item in
                                self.delegateForPackingList?.didTapOnItem(item: item)
                            }
                            
                             
                            ///update spacing of stack view...
                            if customView.label.countLines() == 2 { shopingListItemStack.spacing = 20 } else { shopingListItemStack.spacing = 0 }
                            shopingListItemStack.addArrangedSubview(customView)
                            
//                            customView.addSwipeToDeleteGesture(item: value) { removedItem in
//                                self.delegate?.showCustomDeletMessageView(message: "Are you sure you want to delete this item?", deleteBtnAction: {
//                                    self.deleteShoppinhListItem(shoppingListId: data.id ?? "", itemId: removedItem.id ?? "")
//                                })
//                            }
                        }
                    }
                }
            }
            else { emptyView.isHidden = false }
              
            /// Handel the Add new Item...
            if isReloadOnItemAdded ?? false  {
                let addItemView = CustomAddNewItem()
                addItemView.heightAnchor.constraint(equalToConstant: 60).isActive = true
                addItemView.AddBtnAction  = { itemName in
                    if let items = data.items {
                        let isItemContain = items.contains { item in  item.name?.contains(itemName) == true }
                        
                        if isItemContain {
                            let addBtnAction = UIAlertAction(title: "Add", style: .default) { isComplected in
                                self.shopingListItemStack.arrangedSubviews.forEach { subview in  if subview.tag == 100 { subview.removeFromSuperview() } }
                                self.shopingListItemStack.reloadInputViews(); self.addItemButton.isHidden = false; self.addBtnHeightAnchor.constant = 44
                                self.addNewItemIntoShoppingList(trip: "", product: "", name: itemName, isCustom: true)
                            }
                            self.delegate?.presentAlertAndGotoThatYesNoFunction(withTitle: "Alert", message: "This item has already been added. Do you want to add this item again?", OKAction: addBtnAction)
                        }
                        else {
                            self.shopingListItemStack.arrangedSubviews.forEach { subview in  if subview.tag == 100 { subview.removeFromSuperview() } }
                            self.shopingListItemStack.reloadInputViews(); self.addItemButton.isHidden = false; self.addBtnHeightAnchor.constant = 44
                            self.addNewItemIntoShoppingList(trip: "", product: "", name: itemName, isCustom: true)
                        }
                    }
                }
                shopingListItemStack.addArrangedSubview(addItemView); shopingListItemStack.reloadInputViews()
                addItemButton.isHidden = true; addBtnHeightAnchor.constant = 0; emptyView.isHidden = true
            }
            else {
                addItemButton.isHidden = false; addBtnHeightAnchor.constant = 44
                
            }
            if reloadForDeleteList ?? false { if (data.items?.count ?? 0) <= 0 { emptyView.isHidden = false } else { emptyView.isHidden = true } }
             
            ///update dropdownBtns...
           // self.updateDropDownView()
            
            
            
            print(emptyItemsIndex)
             
            
            
            
        }
    }
     
    
    
    
    
    
    
    
    //MARK: - Cell Init Methods...
    
    ///awakeFromNib...
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Functions...
    
    ///goToSearchproductNow..
    func goToSearchproductNow(itemName: String){
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SearchProductsResultsViewController") as! SearchProductsResultsViewController
        controller.isCommingForSearchProduct = true; controller.searchItemText = itemName
        delegate?.navigationController?.pushViewController(controller, animated: true)
    }
    
    ///updateDropDownView...
    func updateDropDownView(){
        guard let list = dataForShoppingListVC else { return }
        let allItemsChecked = list.items?.allSatisfy { $0.isChecked == true }
        
        if list.name == "Need to buy" { /// this is custom shopping list...
            toBuyBtn.isHidden = true; seeAllBtn.isHidden = true; checkAllBtn.isHidden = true; deleteBtn.isHidden = false; toggleBtn.isHidden = false
        }
        
        if list.items?.count == 0 { /// whne list is empty no item is added...
            toBuyBtn.isHidden = true; seeAllBtn.isHidden = true; checkAllBtn.isHidden = true; deleteBtn.isHidden = true; toggleBtn.isHidden = true
        }
        else {
            if allItemsChecked ?? false { /// when list is all check...
                toBuyBtn.isHidden = true; checkAllBtn.isHidden = true; seeAllBtn.isHidden = false; deleteBtn.isHidden = false; toggleBtn.isHidden = false
            } else { toBuyBtn.isHidden = true; checkAllBtn.isHidden = false; seeAllBtn.isHidden = false; deleteBtn.isHidden = false; toggleBtn.isHidden = false }
            
            if list.items?.count ?? 0 > 1 {
                if isSeeAll ?? false {
                    seeAllBtn.isHidden = true;
                    let anyItemChecked = list.items?.contains { $0.isChecked == false }
                    if anyItemChecked! { toBuyBtn.isHidden = false } else { toBuyBtn.isHidden = true }
                }
                else {
                    toBuyBtn.isHidden = true
                    let anyItemChecked = list.items?.contains { $0.isChecked == true }
                    if anyItemChecked! { seeAllBtn.isHidden = false } else { seeAllBtn.isHidden = true }
                }
            }
            else { toBuyBtn.isHidden = true ;seeAllBtn.isHidden = true }
        }
    }
    
    ///handleSeeAllBtnAction...
    func handleSeeAllBtnAction(){
        isSeeAll = true; dropDownIsChecked.toggle(); dropDownView.isHidden.toggle()
        self.delegate?.updateCollectionView(isReloadOnItemAdded: false, indexPath: self.indexPath!, newData: self.newDataSource, isSeeAll: self.isSeeAll!, reloadForDeleteList: false)
        seeAllBtn.isHidden = true; toBuyBtn.isHidden = false
    }
    
    ///handleToBuyBtnAction...
    func handleToBuyBtnAction(){
        isSeeAll = false; dropDownIsChecked.toggle(); dropDownView.isHidden.toggle()
        self.delegate?.updateCollectionView(isReloadOnItemAdded: false, indexPath: self.indexPath!, newData: self.newDataSource, isSeeAll: self.isSeeAll!, reloadForDeleteList: false)
        seeAllBtn.isHidden = false; toBuyBtn.isHidden = true
    }
     
    ///handleCheckAllBtnAction...
    func handleCheckAllBtnAction(){
        guard let list = dataForShoppingListVC else { return }; self.checkAllItemsOfList(listId: list.id ?? "")
    }
    
    ///handleDeleteShoppingList..
    func handleDeleteShoppingListAction(){
        self.delegate?.showCustomDeletMessageView(message: "Are you sure you want to delete this Shopping list?", deleteBtnAction: {
            guard let list = self.dataForShoppingListVC else { return }; self.deleteShoppingList(listId: list.id ?? "")
        })
    }
    
    ///handleSwipeToDelete...
    private func handleSwipeToDelete(for view: UIView) {
        UIView.animate(withDuration: 0.3, animations: { view.alpha = 0.0 }) { _ in  view.removeFromSuperview() }
    }
    
    // MARK: - Button Actions...
    
    ///addItemBtnAction...
    @IBAction func addItemBtnAction(_ sender: Any) {
        if let packingDelegate = delegateForPackingList {
            packingDelegate.updateCollectionView(isReloadOnItemAdded: true, indexPath: indexPath!, newData: packingNewDataSource, isSeeAll: isSeeAll!, reloadForDeleteList: false)
        }
        else { delegate?.updateCollectionView(isReloadOnItemAdded: true, indexPath: indexPath!, newData: newDataSource, isSeeAll: isSeeAll!, reloadForDeleteList: false) }
         
    }
    
    ///optionBtnAction...
    @IBAction func showDropDownBtnAction(_ sender: Any) { dropDownIsChecked.toggle(); dropDownView.isHidden.toggle() }
    
    ///hideDropDownBtnAction...
    @IBAction func hideDropDownBtnAction(_ sender: Any) { dropDownIsChecked.toggle(); dropDownView.isHidden = true }
    
    ///checkAllBtnAction...
    @IBAction func checkAllBtnAction(_ sender: Any) { handleCheckAllBtnAction() }
    
    ///seeAllBtnAction...
    @IBAction func seeAllBtnAction(_ sender: Any) { handleSeeAllBtnAction() }
    
    ///toBuyBtnAction...
    @IBAction func toBuyBtnAction(_ sender: Any) { handleToBuyBtnAction() }
    
    ///deleteBtnAction...
    @IBAction func deleteBtnAction(_ sender: Any) { handleDeleteShoppingListAction() }
    
    
}

//MARK: - Network layer...
extension ShopingListTableViewCell {
    
    ///addNewItemIntoShoppingList...
    func addNewItemIntoShoppingList(trip: String, product: String, name: String, isCustom: Bool){
        delegate?.showRappleActivity()
        Constants.tripSavaServcesManager.addNewItemIntoShoppingList(trip: trip, product: product, name: name, isCustom: isCustom) { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true {
                    self.newDataSource = response.shoppingList
                    self.emptyView.isHidden = true
                    self.delegate?.updateCollectionView(isReloadOnItemAdded: false, indexPath: self.indexPath!, newData: self.newDataSource, isSeeAll: self.isSeeAll!, reloadForDeleteList: false)
                    self.delegate?.hideRappleActivity()
                }
                else {
                    self.delegate?.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " Item Not added please try again")
                    self.delegate?.hideRappleActivity()
                }
                
            case .failure(_):
                self.delegate?.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " Item Not added please try again")
                self.delegate?.hideRappleActivity()
            }
        }
    }
    
    ///updateShoppingListItem..
    func updateShoppingListItem(name: String, isChecked: Bool, shoppingListId: String, itemId: String, customView: CustomPackingView){
        delegate?.showRappleActivity()
        Constants.tripSavaServcesManager.updateShoppingListItem(name: name, isChecked: isChecked, shoppingListId: shoppingListId, itemId: itemId) { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true {
                    self.newDataSource = response.shoppingList
                    self.emptyView.isHidden = true
                    customView.radioButton.setImage(UIImage(named: "check"), for: .normal)
                    customView.radioButton.isUserInteractionEnabled = false; self.delegate?.hideRappleActivity()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.delegate?.updateCollectionView(isReloadOnItemAdded: false, indexPath: self.indexPath!, newData: self.newDataSource, isSeeAll: self.isSeeAll!, reloadForDeleteList: false)
                    }
                }
                else {
                    self.delegate?.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " Item Not update please try again")
                    self.delegate?.hideRappleActivity()
                }
                
            case .failure(_):
                self.delegate?.presentAlert(withTitle: "Alert", message: Constants.errorMsg + " Item Not updated please try again")
                self.delegate?.hideRappleActivity()
            }
        }
    }
    
    
    
     
    ///checkAllItemsOfList...
    func checkAllItemsOfList(listId: String) {
        delegate?.showRappleActivity()
        Constants.tripSavaServcesManager.checkAllItemsOfList(listId: listId) { resultent in
            switch resultent {
            case .success(let response):
                if response.status == true {
                    self.delegate?.updateCollectionView(isReloadOnItemAdded: false, indexPath: self.indexPath!, newData: response.shoppingList, isSeeAll: self.isSeeAll!, reloadForDeleteList: false)
                    self.delegate?.hideRappleActivity(); self.dropDownIsChecked.toggle(); self.dropDownView.isHidden.toggle()
                }
                else { self.delegate?.hideRappleActivity(); self.delegate?.presentAlert(withTitle: "Alert", message: Constants.errorMsg) }
            case .failure(_):
                self.delegate?.hideRappleActivity(); self.delegate?.presentAlert(withTitle: "Alert", message: Constants.errorMsg)
            }
        }
    }
    
    ///deleteShoppingList..
    func deleteShoppingList(listId: String){
        delegate?.showRappleActivity()
        Constants.tripSavaServcesManager.deleteShoppingList(listId: listId) { resultent in
            switch resultent {
                
            case .success(let response):
                if response.status == true {
                    self.reloadForDeleteList = true
                    let emptyData = ShoppingListResults(items: [], trip: "", name: "Need to Buy", status: "", createdBy: "", createdAt: "", updatedAt: "", id: "")
                    self.delegate?.updateCollectionView(isReloadOnItemAdded: false, indexPath: self.indexPath!, newData: emptyData, isSeeAll: self.isSeeAll!, reloadForDeleteList: self.reloadForDeleteList ?? false)
                    self.delegate?.hideRappleActivity(); self.dropDownIsChecked.toggle(); self.dropDownView.isHidden.toggle()
                }
                else { self.delegate?.hideRappleActivity(); self.delegate?.presentAlert(withTitle: "Alert", message: Constants.errorMsg) }
            case .failure(_): self.delegate?.hideRappleActivity(); self.delegate?.presentAlert(withTitle: "Alert", message: Constants.errorMsg)
            }
        }
    }
    
    ///deleteShoppinhListItem...
    func deleteShoppinhListItem(shoppingListId: String, itemId: String){
        delegate?.showRappleActivity()
        Constants.tripSavaServcesManager.deleteShoppinhListItem(shoppingListId: shoppingListId, itemId: itemId) { resultent in
            switch resultent {
                
            case .success(let response):
                self.delegate?.hideRappleActivity()
                if response.status == true {
                    self.delegate?.updateCollectionView(isReloadOnItemAdded: false, indexPath: self.indexPath!, newData: response.shoppingList, isSeeAll: self.isSeeAll!, reloadForDeleteList: false)
                }
                else { self.delegate?.hideRappleActivity(); self.delegate?.presentAlert(withTitle: "Alert", message: Constants.errorMsg) }
                
            case .failure(_): self.delegate?.hideRappleActivity(); self.delegate?.presentAlert(withTitle: "Alert", message: Constants.errorMsg)
            }
        }
    }
    
    
    
    
    
    
    
    
    
}

 
