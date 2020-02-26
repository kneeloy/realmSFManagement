//
//  Route.swift
//  RealmSFManagement
//
//  Created by chakrni5 on 25/02/2020.
//  Copyright © 2020 Niloy. All rights reserved.
//

import Foundation
import RealmSwift

class Route: Object {

    @objc dynamic var routeID: String = UUID().uuidString
    @objc dynamic var routeName: String = ""
    @objc dynamic var startDate: Date?
    @objc dynamic var endDate: Date?
    @objc dynamic var status: Int = 0
    let ofuser = LinkingObjects(fromType: User.self, property: "routes")
    let sales = List<Sales>()

    override static func primaryKey() -> String? {
        return "routeID"
    }

}
