//
//  ShopingListViewController.swift
//  TripsavaApkDesign
//
//  Created by HF on 14/06/2023.
//

import UIKit

class ShopingListViewController: UIViewController {
    
    
    // MARK: - Outlets...
    @IBOutlet weak var shopingListTableView: UITableView!
    
    
    // MARK: - Variables...
    let identifeir = "ShopingListTableViewCell"
    let headerIdentifier = "HeaderTableViewCell"
    let footerIdentifire = "ShopingListFooterTableViewCell"
    let customCellIdentifire = "CustomCell"
    var shoppingListDataSource: [ShoppingListModel] = []
    var isReloadOnItemAdded: Bool = false
    var shoppingList: [ShoppingListResults] = []
    var isSeeAll: Bool = true
    var reloadForDeleteList: Bool = false
     
    
    // MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Functions...
    
    ///setupView...
    func setupView(){
        registerTableViewCells()
        updateData()
    }
    
    ///updateData...
    func updateData(){
        getAllShoppingList()
    }
    
    
    ///registerTableViewCells...
    func registerTableViewCells(){
        shopingListTableView.register(UINib(nibName: identifeir, bundle: nil), forCellReuseIdentifier: identifeir)
        shopingListTableView.register(UINib(nibName: customCellIdentifire, bundle: nil), forCellReuseIdentifier: customCellIdentifire)
    }
    
    ///updateCollectionView...
    func updateCollectionView(isReloadOnItemAdded: Bool, indexPath: IndexPath, newData: ShoppingListResults?, isSeeAll: Bool, reloadForDeleteList: Bool){
        self.isReloadOnItemAdded = isReloadOnItemAdded; self.isSeeAll = isSeeAll; self.reloadForDeleteList = reloadForDeleteList
        /// handle reload on add item or just for reload ....
        if !isReloadOnItemAdded { shoppingList[indexPath.item] = newData!; shopingListTableView.reloadData() } else { shopingListTableView.reloadRows(at: [indexPath], with: .none) }
        
        updateBadge()
        
    }
    
    // MARK: - Button Actions...
    
    
}

// MARK: - TableView Delegate & DataSource...
extension ShopingListViewController: UITableViewDataSource, UITableViewDelegate {
     
    ///numberOfRowsInSection...
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return shoppingList.count }
    
    ///cellForRowAt...
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifeir, for: indexPath) as! ShopingListTableViewCell
        cell.setUpBGView(); cell.isReloadOnItemAdded = isReloadOnItemAdded; cell.indexPath = indexPath; cell.newDataSource = shoppingList[indexPath.item]
        cell.isSeeAll = isSeeAll; cell.delegate = self; cell.reloadForDeleteList = self.reloadForDeleteList
        cell.dataForShoppingListVC = shoppingList[indexPath.item] 
        return cell
    }
}


//MARK: - Network layer...
extension ShopingListViewController {
    
    ///getAllShoppingList...
    func getAllShoppingList(){
        self.showRappleActivity()
        Constants.tripSavaServcesManager.getShoppingList { resultent in
            switch resultent {
            case .success(let response):
                print(response)
                if response.status == true { self.shoppingList = []; self.shoppingList = response.shoppingList?.results ?? [];
                    self.handleIfPackingListIsEmpty(); self.updateBadge() }
                else { self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + Constants.closedMsg) }
            case .failure(_ ): self.hideRappleActivity(); self.presentAlert(withTitle: "Alert", message: Constants.errorMsg + Constants.closedMsg)
            }
        }
    }
    
    ///updateBadge...
    func updateBadge(){
        
        let totalItemCount = shoppingList.reduce(0) { (total, shoppingListResult) in
            if let items = shoppingListResult.items {
                let uncheckedItems = items.filter { $0.isChecked != true }
                return total + uncheckedItems.count
            } else {
                return total
            }
        }

        DispatchQueue.main.async {
            if let tabBarController = self.tabBarController {
                tabBarController.setBadgeValue("\(totalItemCount)", forIndex: 3)
            }
        }
        
        
       
    }
    
    ///handleIfPackingListIsEmpty...
    func handleIfPackingListIsEmpty(){
        if shoppingList.isEmpty {
            shoppingList.append(ShoppingListResults(items: [], trip: "", name: "Need to Buy", status: "", createdBy: "", createdAt: "", updatedAt: "", id: ""))
            self.shopingListTableView.reloadData()
        } else { self.shopingListTableView.reloadData() }
        self.hideRappleActivity()
    }
}
