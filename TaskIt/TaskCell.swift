//
//  TaskCell.swift
//  TaskIt
//
//  Created by Sami on 02/01/15.
//  Copyright (c) 2015 Sami Paju. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    // Nämä UI elementit on mahdollista linkata tänne ViewControllerin sijasta, koska myCell joka on labeleiden superi käyttää tätä custom classia.
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
