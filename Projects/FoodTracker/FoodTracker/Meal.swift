//
//  Meal.swift
//  FoodTracker
//
//  Created by Fan Zhang on 30/10/2016.
//  Copyright © 2016 Fan Zhang. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
	// MARK: Properties

	var name: String
	var photo: UIImage?
	var rating: Int
	var comments: String

	// MARK: Archiving Paths

	static let DocumentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
	static let ArchiveURL = DocumentDirectory.appendingPathComponent("meals")

	// MARK: Types

	struct PropertyKey {
		static let nameKey = "name"
		static let photoKey = "photo"
		static let ratingKey = "rating"
		static let commentsKey = "comments"
	}

	init?(name: String, photo: UIImage?, rating: Int, comments: String) {

		self.name = name
		self.photo = photo
		self.rating = rating
		self.comments = comments

		super.init()

		if name.isEmpty || rating < 0 {

			return nil
		}
	}

	func encode(with aCoder: NSCoder) {
		aCoder.encode(name, forKey: PropertyKey.nameKey)
		aCoder.encode(photo, forKey: PropertyKey.photoKey)
		aCoder.encode(rating, forKey: PropertyKey.ratingKey)
		aCoder.encode(comments, forKey: PropertyKey.commentsKey)
	}

	required convenience init?(coder aDecoder: NSCoder) {
		let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
		let photo = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as? UIImage
		let rating = aDecoder.decodeInteger(forKey: PropertyKey.ratingKey)
		let comments = aDecoder.decodeObject(forKey: PropertyKey.commentsKey) as! String

		self.init(name: name, photo: photo, rating: rating, comments: comments)
	}
}
