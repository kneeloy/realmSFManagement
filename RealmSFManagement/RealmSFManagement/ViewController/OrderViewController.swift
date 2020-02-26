//
//  OrderViewController.swift
//  RealmSFManagement
//
//  Created by chakrni5 on 25/02/2020.
//  Copyright © 2020 Niloy. All rights reserved.
//

import UIKit
import RealmSwift

class OrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    let realm: Realm
    var sale: Sales?
    var order: Order?
    var products: Results<Product>
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var orderCount: [String] = ["1","2","3","4","5","6","7","8","9","10"]
    var selectedCount: Int = 0
    var selectedProductId: String?
    
    var orderNotificationToken: NotificationToken?
    var orderDetailNotificationToken: NotificationToken?
    
    @IBOutlet weak var tableView: UITableView!
    
    required init?(coder: NSCoder) {
        let config = SyncUser.current?.configuration(realmURL: Constants.REALM_URL, fullSynchronization: true)
        self.realm = try! Realm(configuration: config!)
        self.products = realm.objects(Product.self)
        super.init(coder: coder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        picker.dataSource = self
        picker.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addProduct))
        
        self.title = "Orders"
        
        
        orderNotificationToken = order?.observe { [weak self] (changes) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .change:
                // Results are now populated and can be accessed without blocking the UI
                tableView.reloadData()
            case .deleted:
                tableView.reloadData()
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc private func addProduct() {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)

        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
            
    }
    
   //Add
      @objc private func onDoneButtonTapped() {
        if let order = sale?.order {
        } else {
            self.order = Order()
            self.order?.orderID = UUID().uuidString
            self.order?.orderStatus = 0
            try! realm.write {
                sale?.order = self.order
            }
        }
          if let productId = selectedProductId, let order = sale?.order {
              let newOrderItem = OrderDetails()
              newOrderItem.orderID = order.orderID
              newOrderItem.orderCount = selectedCount
              newOrderItem.productID = productId
            
              try! realm.write {
                if order.orderDetail.count > 0 {
                    order.orderDetail.append(newOrderItem)
                } else {
                    order.orderDetail.append(objectsIn: [newOrderItem])
                }
                  
                  realm.add(order)
              }
          } else {
          }
          
          toolBar.removeFromSuperview()
          picker.removeFromSuperview()
      }
   
   //Delete
   private func deleteItemAtRow(rowId: Int) -> Bool {
       guard let order = order else {
           return false
       }
       try! realm.write {
           realm.delete(order.orderDetail[rowId])
       }
       return true
   }
   
   //Edit
   private func editOrderItemAtIndex(index: IndexPath) {
       let alertController = UIAlertController(title: "Edit Item", message: "", preferredStyle: .alert)

       alertController.addAction(UIAlertAction(title: "Edit", style: .default, handler: {[weak self]
           alert -> Void in
           guard let order = self?.order else {
               return
           }
           let textField = alertController.textFields![0] as UITextField
           let orderDetail = order.orderDetail[index.row]
           let orderCount = textField.text ?? ""
           try! self?.realm.write {
               orderDetail.orderCount = Int(orderCount) ?? 0
           }
        self?.tableView.reloadData()
       }))
       alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
       alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
           textField.placeholder = "New Order value"
       })
       self.present(alertController, animated: true, completion: nil)
   }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order?.orderDetail.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCellReuseIdentifier") as! OrderTableViewCell
        guard let order = order else {
            return cell
        }
        //Not yet a ViewModel though
        cell.orderDetailCellVM = order.orderDetail[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editOrderItemAtIndex(index: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if (deleteItemAtRow(rowId: indexPath.row)) {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return products.count
        } else {
            return orderCount.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return products[row].productName
        } else {
            return orderCount[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedProductId = products[row].productID
        } else {
            selectedCount = Int(orderCount[row]) ?? 0
        }
    }

}
