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

double findMedianSortedArrays(vector<int>& nums1, vector<int>& nums2) {
	return 0.0;
}

TEST(MedianOfTwoSortedArraysTest, totalNumberIsEven)
{
	vector<int> v1 = {1, 3, 5}, v2 = {2, 4, 6};
	double result = findMedianSortedArrays(v1, v2);
	EXPECT_EQ(3.5, result);
}

TEST(MedianOfTwoSortedArraysTest, totalNumbeIsOdd)
{
	vector<int> v1 = {1, 3, 5}, v2 = {2, 4, };
	double result = findMedianSortedArrays(v1, v2);
	EXPECT_EQ(3, result);
}
