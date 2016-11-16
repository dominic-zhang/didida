//
//  PrimeFactorsTests.swift
//  PrimeFactorsTests
//
//  Created by Dominic Zhang on 16/09/2015.
//  Copyright (c) 2015 Dominic Zhang. All rights reserved.
//

import Cocoa
import XCTest

class PrimeFactorsTests: XCTestCase {

	var primeFactors: PrimeFactors?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

		primeFactors = PrimeFactors();
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testTwoHasItselfAsPrimeFactor()
	{
		XCTAssertEqual(primeFactors!.calculatePrimeFactors(2), [2], "")
	}

	func testThreeHasItselfAsPrimeFactor()
	{
		XCTAssertEqual(primeFactors!.calculatePrimeFactors(3), [3], "")
	}

	func testFourHasTwoTimesTwoAsPrimeFactors()
	{
		XCTAssertEqual(primeFactors!.calculatePrimeFactors(4), [2,2], "")
	}

	func testSixHasTwoAndThreeAsPrimeFactors()
	{
		XCTAssertEqual(primeFactors!.calculatePrimeFactors(6), [2,3], "")
	}

	func testEightHasThreeTimesTwoAsPrimeFactors()
	{
		XCTAssertEqual(primeFactors!.calculatePrimeFactors(8), [2,2,2], "")
	}

	func testNineHasTwoTimesThreeAsPrimeFactors()
	{
		XCTAssertEqual(primeFactors!.calculatePrimeFactors(9), [3,3], "")
	}
    
}
