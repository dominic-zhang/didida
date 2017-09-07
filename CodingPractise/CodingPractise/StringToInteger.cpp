//
//  StringToInteger.cpp
//  CodingPractise
//
//  Created by Dominic Zhang on 7/9/17.
//  Copyright © 2017 Dominic Zhang. All rights reserved.
//

#include "StringToInteger.hpp"
#include "gtest/gtest.h"
#include <string>
#include <cmath>

/*
 Implement atoi to convert a string to an integer.

 Hint: Carefully consider all possible input cases. If you want a challenge, please do not see below and ask yourself what are the possible input cases.

 Notes: It is intended for this problem to be specified vaguely (ie, no given input specs). You are responsible to gather all the input requirements up front.
 */
using namespace std;

int myAtoi(string str) {
	int result = 0;

	int leadingWhiteSpaceLength = 0;
	bool leadingWhiteSpaceFinish = false;
	int tailingNonDigitalLength = static_cast<int>(str.length());
	bool tailingNonDigitalFinish = false;
	for (int i = 0; i < str.length(); i++)
	{
		if ((str[i] == ' ' || str[i] == '\t') && !leadingWhiteSpaceFinish)
			leadingWhiteSpaceLength++;
		else
			leadingWhiteSpaceFinish = true;

		char c = str[str.length() - 1 - i];
		if ((c < '0' || c > '9') && !tailingNonDigitalFinish)
			tailingNonDigitalLength--;
		else
			tailingNonDigitalFinish = true;
	}
	str = str.substr(leadingWhiteSpaceLength, tailingNonDigitalLength - leadingWhiteSpaceLength);

	int sign = 1;
	if (str[0] == '-')
	{
		sign = -1;
		str = str.substr(1, str.length()-1);
	}
	else if (str[0] == '+')
	{
		str = str.substr(1, str.length()-1);
	}

	for (int i = 0; i < str.length(); i++) {
		char c = str[str.length() - 1 - i];
		if (c < '0' || c > '9')
			return 0;
		result += (c - '0') * pow(10, i);
		if (result < 0)
			return sign > 0 ? INT_MAX : INT_MIN;
	}
	return result * sign;
}

TEST(StringToIntegerTest, zero)
{
	EXPECT_EQ(0, myAtoi("0"));
}

TEST(StringToIntegerTest, invalidString)
{
	EXPECT_EQ(0, myAtoi("a"));
}

TEST(StringToIntegerTest, numberWithoutSign)
{
	EXPECT_EQ(123, myAtoi("123"));
}

TEST(StringToIntegerTest, numberWithPositiveSign)
{
	EXPECT_EQ(123, myAtoi("+123"));
}

TEST(StringToIntegerTest, numberWithNegativeSign)
{
	EXPECT_EQ(-123, myAtoi("-123"));
}

TEST(StringToIntegerTest, positiveNumberOverflow)
{
	EXPECT_EQ(INT_MAX, myAtoi("3147483647"));
}

TEST(StringToIntegerTest, negativeNumberOverflow)
{
	EXPECT_EQ(INT_MIN, myAtoi("-3147483647"));
}

TEST(StringToIntegerTest, leadingWhiteSpace)
{
	EXPECT_EQ(123, myAtoi("  \t123"));
}

TEST(StringToIntegerTest, tailingNonDigitalCharacters)
{
	EXPECT_EQ(123, myAtoi("123abc"));
}

