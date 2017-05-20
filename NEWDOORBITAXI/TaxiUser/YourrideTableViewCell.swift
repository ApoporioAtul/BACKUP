//
//  YourrideTableViewCell.swift
//  TaxiUser
//
//  Created by AppOrio on 20/09/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import UIKit

class YourrideTableViewCell: UITableViewCell {
    
    @IBOutlet weak var carimage: UIImageView!
    
    @IBOutlet weak var datetimelabel: UILabel!
    
    @IBOutlet weak var pickuplabel: UILabel!
    
    @IBOutlet weak var ongoinglabel: UILabel!
    
    @IBOutlet weak var cancelimage: UIImageView!
    
    @IBOutlet weak var redimage: UIImageView!
    @IBOutlet weak var dropuplabel: UILabel!
    
    @IBOutlet weak var dotimage: UIImageView!
    
    @IBOutlet weak var driverimage: UIImageView!

    @IBOutlet weak var carname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
