//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by Fan Zhang on 30/10/2016.
//  Copyright © 2016 Fan Zhang. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var photoImageView: UIImageView!
	@IBOutlet weak var ratingControl: RatingControl!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
