//
//  NewYourRideTableViewCell.swift
//  TaxiUser
//
//  Created by AppOrio on 31/03/17.
//  Copyright © 2017 apporio. All rights reserved.
//

import UIKit

class NewYourRideTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainview: UIView!
    
    @IBOutlet weak var firstlocation: UILabel!
    
    @IBOutlet weak var secondlocation: UILabel!
    
    @IBOutlet weak var firstmapimageview: UIImageView!
    
    @IBOutlet weak var secondimageview: UIImageView!
    
    @IBOutlet weak var datelabel: UILabel!
    
    @IBOutlet weak var statuslabel: UILabel!
    
    @IBOutlet weak var pricelabel: UILabel!
    
    
    @IBOutlet weak var carnamelabel: UILabel!
    @IBOutlet weak var driverimage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
