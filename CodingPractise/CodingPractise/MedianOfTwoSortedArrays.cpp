//
//  MedianOfTwoSortedArrays.cpp
//  CodingPractise
//
//  Created by Dominic Zhang on 12/8/17.
//  Copyright © 2017 Dominic Zhang. All rights reserved.
//

#include "MedianOfTwoSortedArrays.hpp"
#include "gtest/gtest.h"
#include <vector>

/*
 
 There are two sorted arrays nums1 and nums2 of size m and n respectively.

 Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).

 Example 1:
 nums1 = [1, 3]
 nums2 = [2]

 The median is 2.0
 Example 2:
 nums1 = [1, 2]
 nums2 = [3, 4]

 The median is (2 + 3)/2 = 2.5

 */

using namespace std;

double findMedianSortedArrays(vector<int>& nums1, vector<int>& nums2)
{
	size_t n = nums1.size();
	size_t m = nums2.size();

	if (n < m)
	{
		std::swap(nums1, nums2);
		std::swap(n, m);
	}

	size_t i = m / 2;
	size_t j = 0;
	size_t iUpperBound = m;
	size_t iLowerBound = 0;
	while (true)
	{
		j = (m + n + 1) / 2 - i;

		if (j > 1 && nums1[j-1] > nums2[i])
		{
			iLowerBound = i;
			i = (i + iUpperBound) / 2;
			continue;
		}
		else if (i > 1 && nums2[i - 1] > nums1[j])
		{
			iUpperBound = i;
			i = (i + iLowerBound) / 2;
			continue;
		}
		else
		{
			break;
		}
	}

	if ((m + n) % 2 == 0)
	{
		return (std::max(nums1[j - 1], nums2[i - 1]) + std::min(nums1[j], nums2[i])) / 2.0;
	}
	else
	{
		return std::max(nums1[j - 1], nums2[i - 1]);
	}
}

TEST(MedianOfTwoSortedArraysTest, totalNumberIsEven)
{
	vector<int> v1 = {1, 3, 5, 7, 9, 11, 13, 15, 17, 19}, v2 = {2, 4, 6, 8};
	double result = findMedianSortedArrays(v1, v2);
	EXPECT_EQ(7.5, result);
}

TEST(MedianOfTwoSortedArraysTest, totalNumbeIsOdd)
{
	vector<int> v1 = {1, 3, 5, 7, 9, 11, 13, 15, 17, 19}, v2 = {2, 4, 6, 8, 10};
	double result = findMedianSortedArrays(v1, v2);
	EXPECT_EQ(8, result);
}

TEST(MedianOfTwoSortedArraysTest, TwoVectorsHaveSameLength)
{
	vector<int> v1 = {1, 3, 5, 7, 9, 11, 13, 15}, v2 = {17, 19, 21, 23, 25, 27, 29, 31};
	double result = findMedianSortedArrays(v1, v2);
	EXPECT_EQ(16, result);
}

//TEST(MedianOfTwoSortedArraysTest,
