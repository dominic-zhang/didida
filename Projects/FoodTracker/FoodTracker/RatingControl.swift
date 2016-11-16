//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Fan Zhang on 7/10/2016.
//  Copyright © 2016 Fan Zhang. All rights reserved.
//

import UIKit

class RatingControl: UIView {

	var rating = 0 {
		didSet {
			setNeedsLayout()
		}
	}
	var ratingButtons = [UIButton]()
	let spacing = 5
	let starCount = 5
	let buttonSize = 44

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		for _ in 0 ..< starCount {
			let emptyStarImage = UIImage(named: "emptyStar")
			let filledStarImage = UIImage(named: "filledStar")

			let button = UIButton()
			button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchDown)
			button.setImage(emptyStarImage, for: .normal)
			button.setImage(filledStarImage, for: .selected)
			button.setImage(filledStarImage, for: [.highlighted, .selected])
			button.adjustsImageWhenHighlighted = false
			ratingButtons += [button]
			addSubview(button)
		}
	}

	override func layoutSubviews() {
		for (index, button) in ratingButtons.enumerated() {
			var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
			buttonFrame.origin.x += CGFloat(index * (buttonSize + spacing))
			button.frame = buttonFrame
		}
		updateButtonSelectionStatus()
	}

	override var intrinsicContentSize: CGSize {
		let width = starCount * buttonSize + (starCount - 1) * spacing
		return CGSize(width: width, height: buttonSize)
	}

	func ratingButtonTapped(button: UIButton) {
		rating = ratingButtons.index(of: button)! + 1
		updateButtonSelectionStatus()
	}

	func updateButtonSelectionStatus() {
		for (index, button) in ratingButtons.enumerated() {
			button.isSelected = index < rating
		}
	}

}
