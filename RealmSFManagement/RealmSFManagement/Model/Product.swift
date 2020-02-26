//
//  Product.swift
//  RealmSFManagement
//
//  Created by chakrni5 on 25/02/2020.
//  Copyright © 2020 Niloy. All rights reserved.
//

import Foundation
import RealmSwift

class Product: Object {

    @objc dynamic var productID: String = UUID().uuidString
    @objc dynamic var productName: String = ""
    

    override static func primaryKey() -> String? {
        return "productID"
    }

}
