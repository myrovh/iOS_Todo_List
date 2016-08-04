//
//  ReminderViewCell.swift
//  Reminder List
//
//  Created by Dyson Talbot Sunderland Hamilton on 4/08/2016.
//  Copyright © 2016 myrovh. All rights reserved.
//

import UIKit

class ReminderViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
