//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Fan Zhang on 7/10/2016.
//  Copyright © 2016 Fan Zhang. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	// MARK: FoodTracker Tests

	// Tests to confirm that the Meal initializer returns when no name or a negative rating is provided.
	func testMealInitialization() {

		// Success case.
		let potentialItem = Meal(name: "Newest meal", photo: nil, rating: 5)
		XCTAssertNotNil(potentialItem)

		// Failure cases.
		let noName = Meal(name: "", photo: nil, rating: 0)
		XCTAssertNil(noName, "Empty name is invalid")

		let badRating = Meal(name: "Really bad rating", photo: nil, rating: -1)
		XCTAssertNil(badRating)
	}
    
}
