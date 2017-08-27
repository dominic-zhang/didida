//
//  LongestSubStringWithoutRepeating.cpp
//  CodingPractise
//
//  Created by Dominic Zhang on 12/8/17.
//  Copyright © 2017 Dominic Zhang. All rights reserved.
//

#include "LongestSubStringWithoutRepeating.hpp"
#include "gtest/gtest.h"
#include <string>

using namespace std;

/*
 
 Given a string, find the length of the longest substring without repeating characters.

 Examples:

 Given "abcabcbb", the answer is "abc", which the length is 3.

 Given "bbbbb", the answer is "b", with the length of 1.

 Given "pwwkew", the answer is "wke", with the length of 3. Note that the answer must be a substring, "pwke" is a subsequence and not a substring.

*/

int lengthOfLongestSubstring(string s) {
	if (s.empty())
		return 0;

	int start = 0, end = 1;
	int length = 0;
	while (end < s.length())
	{
		for (int i = start; i < end; i++)
		{
			if (s[i] == s[end])
			{
				start = i + 1;
				break;
			}
		}
		if (end - start + 1 > length)
			length = end - start + 1;
		end++;
	}
	return length;
}

TEST(LongestSubStringWithoutRepeatingTest, emptyString)
{
	int length = lengthOfLongestSubstring("");
	EXPECT_EQ(0, length);
}

TEST(LongestSubStringWithoutRepeatingTest, singleCharacterRepeating)
{
	int length = lengthOfLongestSubstring("bbbbb");
	EXPECT_EQ(1, length);
}

TEST(LongestSubStringWithoutRepeatingTest, threeCharactersRepeating)
{
	int length = lengthOfLongestSubstring("abcabc");
	EXPECT_EQ(3, length);
}

TEST(LongestSubStringWithoutRepeatingTest, fourCharactersRepeating)
{
	int length = lengthOfLongestSubstring("abcdabcd");
	EXPECT_EQ(4, length);
}

TEST(LongestSubStringWithoutRepeatingTest, arbitaryCharacters)
{
	int length = lengthOfLongestSubstring("pwwkew");
	EXPECT_EQ(3, length);
}
