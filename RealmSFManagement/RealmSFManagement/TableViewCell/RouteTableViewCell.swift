//
//  RouteTableViewCell.swift
//  RealmSFManagement
//
//  Created by chakrni5 on 25/02/2020.
//  Copyright © 2020 Niloy. All rights reserved.
//

import UIKit

class RouteTableViewCell: UITableViewCell {

     @IBOutlet weak var routeName: UILabel!
     @IBOutlet weak var startDate: UILabel!
     @IBOutlet weak var endDate: UILabel!
     @IBOutlet weak var status: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var routeCellVM : Route? {
    didSet {
        routeName.text = routeCellVM?.routeName
        startDate.text = getdateString(fromDate: routeCellVM?.startDate)
        endDate.text = getdateString(fromDate: routeCellVM?.endDate)
        status.text = getStatus(fromStatus: routeCellVM?.status)
        }
    }
    
    private func getdateString(fromDate: Date?) -> String {
        guard let date = fromDate else { return "Not Started" }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // edited
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from:date)
    }
    
    //Ideally this should be done sing Enum
    private func getStatus(fromStatus: Int?) -> String {
        guard let status = fromStatus else { return "Not Started" }
        
        if status == 0 {
            return "Not Started"
        } else if status == 1 {
            return "Started"
        } else if status == 2 {
            return "Pended"
        } else if status == 3 {
            return "Closed"
        } else if status == 4 {
            return "Cancelled"
        } else {
            return "N/A"
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        routeName.text = ""
    }
}
