//
//  SelectCardCell.swift
//  TaxiUser
//
//  Created by AppOrio on 01/03/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class SelectCardCell: UITableViewCell {
    
    
    @IBOutlet weak var cardNumber: UILabel!
    
    @IBOutlet weak var expiryDate: UILabel!
    
    @IBOutlet weak var payButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
