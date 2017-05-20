//
//  YourrideTableViewCell.swift
//  TaxiApp Driver
//
//  Created by AppOrio on 07/02/17.
//  Copyright © 2017 Apporio. All rights reserved.
//

import UIKit

class YourrideTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var datetimelabel: UILabel!
    
    @IBOutlet weak var pickuplabel: UILabel!
    
    @IBOutlet weak var ongoinglabel: UILabel!
    
    @IBOutlet weak var cancelimage: UIImageView!
    
    @IBOutlet weak var redimage: UIImageView!
    @IBOutlet weak var dropuplabel: UILabel!
    
    @IBOutlet weak var dotimage: UIImageView!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
