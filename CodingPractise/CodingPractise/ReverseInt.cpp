//
//  ReverseInt.cpp
//  CodingPractise
//
//  Created by Dominic Zhang on 6/9/17.
//  Copyright © 2017 Dominic Zhang. All rights reserved.
//

#include "ReverseInt.hpp"
#include "gtest/gtest.h"
#include <stack>
#include <cmath>

/*
 Reverse digits of an integer.

 Example1: x = 123, return 321
 Example2: x = -123, return -321

 Note:
 The input is assumed to be a 32-bit signed integer. Your function should return 0 when the reversed integer overflows.
 */

using namespace std;

int reverse(int x) {
	if (x == 0)
		return 0;
	int fabX = fabs(x);
	int sign = x / fabX;

	int result = 0;
	while (fabX > 0)
	{
		result = result * 10 + fabX % 10;
		if (result < 0)
			return 0;
		fabX /= 10;
	}

	return result * sign;
}

TEST(ReverseIntTest, Zero)
{
	EXPECT_EQ(0, reverse(0));
}

TEST(ReverseIntTest, positiveOverflow)
{
	EXPECT_EQ(0, reverse(2147483647));
}

TEST(ReverseIntTest, negativeOverflow)
{
	EXPECT_EQ(0, reverse(-2147483647));
}

TEST(ReverseIntTest, reversePositiveInt)
{
	EXPECT_EQ(123, reverse(321));
}

TEST(ReverseIntTest, reverseNegativeInt)
{
	EXPECT_EQ(-123, reverse(-321));
}
