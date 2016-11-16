//
//  PrimeFactors.swift
//  PrimeFactors
//
//  Created by Dominic Zhang on 16/09/2015.
//  Copyright (c) 2015 Dominic Zhang. All rights reserved.
//

import Foundation

class PrimeFactors {
	func calculatePrimeFactors(number: Int) -> Array<Int>
	{
		var n = number
		var factors: Array<Int> = []
		for (var candidate = 2; n > 1; candidate++)
		{
			while (n % candidate == 0)
			{
				factors += [candidate]
				n = n / candidate
			}
		}

		return factors
	}
}