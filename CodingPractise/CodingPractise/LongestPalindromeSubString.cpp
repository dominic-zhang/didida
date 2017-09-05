//
//  LongestPalindromeSubString.cpp
//  CodingPractise
//
//  Created by Dominic Zhang on 4/9/17.
//  Copyright © 2017 Dominic Zhang. All rights reserved.
//

#include "LongestPalindromeSubString.hpp"
#include "gtest/gtest.h"
#include <string>
#include <map>

/*
 Given a string s, find the longest palindromic substring in s. You may assume that the maximum length of s is 1000.

 Example:

 Input: "babad"

 Output: "bab"

 Note: "aba" is also a valid answer.
 Example:

 Input: "cbbd"

 Output: "bb"
*/

using namespace std;

pair<int, int> extendPalindrome(string s, int position)
{
	pair<int, int> palindrome;

	// odd length
	int left = position - 1;
	int right = position + 1;
	while (left >=0 && right < s.length() && s[left] == s[right])
	{
		left--;
		right++;
	}

	if (right - left > 2)
	{
		palindrome.first = left + 1;
		palindrome.second = right - left - 1;
	}

	// even length
	left = position;
	right = position + 1;
	while (left >=0 && right < s.length() && s[left] == s[right])
	{
		left--;
		right++;
	}

	if (right - left > 1)
	{
		palindrome.first = left + 1;
		palindrome.second = right - left -1;
	}

	return palindrome;
}

string longestPalindrome(string s)
{
	if (s.empty())
		return "";

	if (s.length() == 1)
		return s;

	pair<int, int> longestPalindromePostion;

	for (int position = 0; position < s.length(); position++)
	{
		const auto& palindrome = extendPalindrome(s, position);
		if (palindrome.second > longestPalindromePostion.second)
			longestPalindromePostion = palindrome;
	}

	return s.substr(longestPalindromePostion.first, longestPalindromePostion.second);
}

TEST(LongestPalindromeTest, EmptyString)
{
	const auto& palindrome = longestPalindrome("");
	EXPECT_TRUE(palindrome.empty());
}

TEST(LongestPalindromeTest, SingleCharacterString)
{
	const auto& p = longestPalindrome("s");
	EXPECT_STREQ("s", p.c_str());
}

TEST(LongestPalindromeTest, OddLengthPalindrome)
{
	auto palindrome = longestPalindrome("iseenursesruning");
	EXPECT_STREQ("nursesrun", palindrome.c_str());
}

TEST(LongestPalindromeTest, EvenLengthPalindrome)
{
	auto palindrome = longestPalindrome("iseenurseesruning");
	EXPECT_STREQ("nurseesrun", palindrome.c_str());
}
