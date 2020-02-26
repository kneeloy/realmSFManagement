//
//  Order.swift
//  RealmSFManagement
//
//  Created by chakrni5 on 25/02/2020.
//  Copyright © 2020 Niloy. All rights reserved.
//

import Foundation
import RealmSwift

class Order: Object {

    @objc dynamic var orderID: String = UUID().uuidString
    @objc dynamic var orderStatus: Int = 0
    let ofsale = LinkingObjects(fromType: Sales.self, property: "order")
    
    let orderDetail = List<OrderDetails>()

    override static func primaryKey() -> String? {
        return "orderID"
    }

}

