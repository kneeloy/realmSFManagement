//
//  Sales.swift
//  RealmSFManagement
//
//  Created by chakrni5 on 25/02/2020.
//  Copyright © 2020 Niloy. All rights reserved.
//

import Foundation
import RealmSwift

class Sales: Object {

    @objc dynamic var salesID: String = UUID().uuidString
    @objc dynamic var salesName: String = ""
    @objc dynamic var startDate: Date?
    @objc dynamic var endDate: Date?
    @objc dynamic var status: Int = 0
    @objc dynamic var order: Order?
    let ofRoute = LinkingObjects(fromType: Route.self, property: "sales")

    override static func primaryKey() -> String? {
        return "salesID"
    }

}
