//
//  SalesViewController.swift
//  RealmSFManagement
//
//  Created by chakrni5 on 25/02/2020.
//  Copyright © 2020 Niloy. All rights reserved.
//

import UIKit

import RealmSwift

class SalesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    let realm: Realm
    var sales: List<Sales>?
    @IBOutlet weak var tableView: UITableView!
    
    required init?(coder: NSCoder) {
        let config = SyncUser.current?.configuration(realmURL: Constants.REALM_URL, fullSynchronization: true)
        self.realm = try! Realm(configuration: config!)
        super.init(coder: coder)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        
        self.title = "SalesPlan"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sales?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SalesCellReuseIdentifier") as! SalesTableViewCell
        guard let sales = sales else {
            return cell
        }
        //Not yet a ViewModel though
        cell.salesCellVM = sales[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        updateSalesStatus(rowId: indexPath.row)
        if let orderViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderController") as? OrderViewController {
            orderViewController.order = sales?[indexPath.row].order
            orderViewController.sale = sales?[indexPath.row]
            navigationController?.pushViewController(orderViewController, animated: true)
        }
    }
    
    private func updateSalesStatus(rowId: Int) {
        guard let sales = sales else { return }
        
        let sale = sales[rowId]
        try! realm.write {
            sale.status = 1
            sale.startDate = Date()
        }
    }

}
