//
//  ScanCell.swift
//  ObjectLibrary
//
//  Created by Daniel Stepanov on 2/17/16.
//  Copyright © 2016 Daniel Stepanov. All rights reserved.
//

import UIKit

class ScanCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var scanTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
