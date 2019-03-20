//
//  AnimationTableViewCell.swift
//  UIView Animations
//
//  Created by Brian Sakhuja on 3/20/19.
//  Copyright © 2019 Brian Sakhuja. All rights reserved.
//

import UIKit

class AnimationTableViewCell: UITableViewCell {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
