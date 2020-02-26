//
//  User.swift
//  RealmSFManagement
//
//  Created by chakrni5 on 25/02/2020.
//  Copyright © 2020 Niloy. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {

    @objc dynamic var userId: String = UUID().uuidString
    @objc dynamic var route: String = ""
    @objc dynamic var userName: String = ""
    @objc dynamic var homeAddress: String?
    @objc dynamic var businessAddress: String?
    @objc dynamic var mobileNo: String?
    @objc dynamic var homePhoneNo: String?
    @objc dynamic var officePhoneNo: String?
    let routes = List<Route>()
    

    override static func primaryKey() -> String? {
        return "userId"
    }

}
