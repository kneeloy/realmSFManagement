//
//  RouteViewController.swift
//  RealmSFManagement
//
//  Created by chakrni5 on 25/02/2020.
//  Copyright © 2020 Niloy. All rights reserved.
//

import UIKit

import UIKit
import RealmSwift

class RouteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let realm: Realm
    var routes: List<Route>?
    var userId: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    //ToDo Initial cold launch of the app fails to sync down the data rom server
    required init?(coder: NSCoder) {
        
        let config = SyncUser.current?.configuration(realmURL: Constants.REALM_URL, fullSynchronization: true)
        self.realm = try! Realm(configuration: config!)
        
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        
        self.title = "RoutePlan"
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SignOut", style: .plain, target: self, action: #selector(logOut))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let userId = userId else { return }
        let user = realm.object(ofType: User.self, forPrimaryKey: userId)
        routes = user?.routes
        tableView.reloadData()
        self.navigationItem.setHidesBackButton(true, animated: true);
    }

    @objc private func logOut() {
        SyncUser.current?.logOut()
        navigationController?.popViewController(animated: true)
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
        return routes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RuteCellReuseIdentifier") as! RouteTableViewCell
        
        //Not yet a ViewModel though
        cell.routeCellVM = routes?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        updateRouteStatus(rowId: indexPath.row)
        if let salesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SalesController") as? SalesViewController {
            salesViewController.sales = routes?[indexPath.row].sales
            navigationController?.pushViewController(salesViewController, animated: true)
        }
        
    }
    
    private func updateRouteStatus(rowId: Int) {
        guard let route = routes?[rowId] else { return }
        try! realm.write {
            route.status = 1
            route.startDate = Date()
        }
    }
}
