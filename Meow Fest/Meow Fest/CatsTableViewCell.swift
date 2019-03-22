//
//  CatsTableViewCell.swift
//  Meow Fest
//
//  Created by Brian Sakhuja on 12/12/18.
//  Copyright © 2018 Brian Sakhuja. All rights reserved.
//

import UIKit

class CatsTableViewCell: UITableViewCell {


    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
