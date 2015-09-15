//
//  main.swift
//  PrimeFactors
//
//  Created by Dominic Zhang on 15/09/2015.
//  Copyright (c) 2015 Dominic Zhang. All rights reserved.
//

import Foundation

class PrimeFactors
{
	func calculatePrimeFactors(n: Int) -> Array<Int>
	{
		var localN = n
		var factors: [Int] = []
		for (var candidate = 2; localN > 1; candidate++)
		{
			while (localN % candidate == 0)
			{
				factors += [candidate]
				localN = localN / candidate
			}
		}

		return factors
	}
}

class UnitTest
{
	func oneHasNoPrimeFactor()
	{
		var pf = PrimeFactors();
		assert(pf.calculatePrimeFactors(1).isEmpty, "oneHasNoPrimeFactor failed");
	}

	func twoHasItselfAsPrimeFactor()
	{
		var pf = PrimeFactors();
		assert(pf.calculatePrimeFactors(2) == [2], "twoHasItselfAsPrimeFactor failed");
	}

	func threeHasItselfAsPrimaryFactor()
	{
		var pf = PrimeFactors();
		assert(pf.calculatePrimeFactors(3) == [3], "threeHasItselfAsPrimaryFactor failed");
	}

	func fourHasTwoTimesTwoAsPrimeFactors()
	{
		var pf = PrimeFactors();
		assert(pf.calculatePrimeFactors(4) == [2, 2], "fourHasTwoTimesTwoAsPrimeFactors");
	}

	func fiveHasItselfAsPrimeFactor()
	{
		var pf = PrimeFactors();
		assert(pf.calculatePrimeFactors(5) == [5], "fiveHasItselfAsPrimeFactor");
	}

	func sixHasTwoAndThreeAsPrimeFactors()
	{
		var pf = PrimeFactors();
		assert(pf.calculatePrimeFactors(6) == [2, 3], "sixHasTwoAndThreeAsPrimeFactors");
	}

	func eightHasThreeTimesTwoAsPrimeFactors()
	{
		var pf = PrimeFactors();
		assert(pf.calculatePrimeFactors(8) == [2, 2, 2], "eightHasThreeTimesTwoAsPrimeFactors");
	}

	func nineHasTwoTimesThreeAsPrimeFactors()
	{
		var pf = PrimeFactors();
		assert(pf.calculatePrimeFactors(9) == [3, 3], "nineHasTwoTimesThreeAsPrimeFactors");
	}

	func oneeightoHasTwoTimesTwoAndTwoTimesThreeAndFiveAsPrimeFactors()
	{
		var pf = PrimeFactors();
		assert(pf.calculatePrimeFactors(180) == [2,2,3,3,5], "oneeightoHasTwoTimesTwoAndTwoTimesThreeAndFiveAsPrimeFactors");
	}
}

var unitTest = UnitTest();
unitTest.oneHasNoPrimeFactor();
unitTest.twoHasItselfAsPrimeFactor();
unitTest.threeHasItselfAsPrimaryFactor();
unitTest.fourHasTwoTimesTwoAsPrimeFactors();
unitTest.fiveHasItselfAsPrimeFactor();
unitTest.sixHasTwoAndThreeAsPrimeFactors();
unitTest.eightHasThreeTimesTwoAsPrimeFactors();
unitTest.nineHasTwoTimesThreeAsPrimeFactors();
unitTest.nineHasTwoTimesThreeAsPrimeFactors();

