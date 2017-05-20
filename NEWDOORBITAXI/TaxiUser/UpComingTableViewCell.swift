//
//  UpComingTableViewCell.swift
//  TaxiApp
//
//  Created by AppOrio on 03/09/16.
//  Copyright © 2016 apporio. All rights reserved.
//

import UIKit

class UpComingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var locationlabel: UILabel!
    
    @IBOutlet weak var timelabel: UILabel!
    
    @IBOutlet weak var deletebutton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
