//
//  TableViewCell.swift
//  Task
//
//  Created by apple on 13/03/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleNameOutlet: UILabel!
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var descriptionOutlet: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
