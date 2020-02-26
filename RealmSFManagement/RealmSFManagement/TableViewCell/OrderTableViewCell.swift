//
//  OrderTableViewCell.swift
//  RealmSFManagement
//
//  Created by chakrni5 on 25/02/2020.
//  Copyright © 2020 Niloy. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

     @IBOutlet weak var productName: UILabel!
     @IBOutlet weak var orderCount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var orderDetailCellVM : OrderDetails? {
    didSet {
        productName.text = orderDetailCellVM?.productID
        if let count = orderDetailCellVM?.orderCount {
            orderCount.text = String(count)
        } else {
            orderCount.text = ""
        }
        }
    }

}
