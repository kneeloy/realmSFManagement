//
//  OrderDetail.swift
//  RealmSFManagement
//
//  Created by chakrni5 on 25/02/2020.
//  Copyright © 2020 Niloy. All rights reserved.
//

import Foundation
import RealmSwift

class OrderDetails: Object {

    @objc dynamic var orderID: String = UUID().uuidString
    @objc dynamic var productID: String = UUID().uuidString
    @objc dynamic var orderCount: Int = 0
    let ofOrder = LinkingObjects(fromType: Order.self, property: "orderDetail")

}
