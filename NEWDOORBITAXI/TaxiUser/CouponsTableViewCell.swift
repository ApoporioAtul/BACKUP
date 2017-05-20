//
//  CouponsTableViewCell.swift
//  TaxiApp
//
//  Created by AppOrio on 22/08/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import UIKit

class CouponsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var coupon_code: UILabel!
    
   
    @IBOutlet weak var expirydate: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
