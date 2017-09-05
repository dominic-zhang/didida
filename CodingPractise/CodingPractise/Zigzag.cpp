//
//  Zigzag.cpp
//  CodingPractise
//
//  Created by Dominic Zhang on 5/9/17.
//  Copyright © 2017 Dominic Zhang. All rights reserved.
//

#include "Zigzag.hpp"
#include "gtest/gtest.h"
#include <string>

/*
 The string "PAYPALISHIRING" is written in a zigzag pattern on a given number of rows like this: (you may want to display this pattern in a fixed font for better legibility)

 P   A   H   N
 A P L S I I G
 Y   I   R
 And then read line by line: "PAHNAPLSIIGYIR"
 Write the code that will take a string and make this conversion given a number of rows:

 string convert(string text, int nRows);
 convert("PAYPALISHIRING", 3) should return "PAHNAPLSIIGYIR".
 */

using namespace std;

string convert(string s, int numRows)
{
	if (numRows < 3)
		return "";

	string result;
	int delta = numRows * 2 - 2;
	int stringLen = static_cast<int>(s.length());
	for (int row = 0; row < numRows; row++)
	{
		int k = 0;
		while (k*delta - row < stringLen)
		{
			int left = k*delta - row;
			int right = k*delta + row;

			if (left == right) // first row
				result.append(string(1, s[left]));
			else if (right - left == delta) // last row
			{
				result.append(string(1, s[right]));
			}
			else
			{
				if (left > 0)
					result.append(string(1, s[left]));
				if (right < s.length())
					result.append(string(1, s[right]));
			}
			k++;
		}
	}
	return result;
}

TEST(ZiaZagTest, 3rows)
{
	string s = convert("PAYPALISHIRING", 3);
	EXPECT_STREQ("PAHNAPLSIIGYIR", s.c_str());
}

TEST(ZiaZagTest, 4rows)
{
	string s = convert("PAYPALISHIRING", 4);
	EXPECT_STREQ("PINALSIGYAHRPI", s.c_str());
}
