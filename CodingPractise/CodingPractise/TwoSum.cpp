//
//  twoSum.cpp
//  CodingPractise
//
//  Created by Dominic Zhang on 12/8/17.
//  Copyright © 2017 Dominic Zhang. All rights reserved.
//

#include "TwoSum.hpp"
#include <vector>
#include <unordered_map>
#include "gtest/gtest.h"

/*

 Given an array of integers, return indices of the two numbers such that they add up to a specific target.

 You may assume that each input would have exactly one solution, and you may not use the same element twice.

 Example:
 Given nums = [2, 7, 11, 15], target = 9,

 Because nums[0] + nums[1] = 2 + 7 = 9,
 return [0, 1].
 
 */

using namespace std;

vector<int> twoSum(vector<int>& nums, int target) {
	unordered_map<int, int> cachedNumbers;
	for (int index = 0; index < nums.size(); index++)
	{
		int number = target - nums[index];
		if (cachedNumbers.find(number) != cachedNumbers.end())
		{
			return {cachedNumbers[number], index};
		}
		cachedNumbers[nums[index]] = index;
	}
	throw std::runtime_error("can't find result");
}

TEST(twoSumTest, AccendingSortedNumbers)
{
	vector<int> nums = {2, 7, 11, 15};
	int target = 9;
	auto result = twoSum(nums, target);
	vector<int> expectResult = {0, 1};
	EXPECT_EQ(expectResult, result);
}

TEST(twoSumTest, DescendingSortedNumbers)
{
	vector<int> nums = {35, 20, 13, 5};
	int target = 25;
	auto result = twoSum(nums, target);
	vector<int> expectResult = {1, 3};
	EXPECT_EQ(expectResult, result);
}

TEST(twoSumTest, UnorderedNumbers)
{
	vector<int> nums = {3, 9, 5, 13, 35, 20};
	int target = 40;
	auto result = twoSum(nums, target);
	vector<int> expectedResult = {2, 4};
	EXPECT_EQ(expectedResult, result);
}
