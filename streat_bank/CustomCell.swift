//
//  CustomCell.swift
//  test1
//
//  Created by Mohammed ALZAHRANI on 11/08/16.
//  Copyright © 2016 Mohammed ALZAHRANI. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {


    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descr: UILabel!
    @IBOutlet weak var state: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
