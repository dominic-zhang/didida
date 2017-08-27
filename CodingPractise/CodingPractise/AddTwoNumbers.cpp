//
//  AddTwoNumbers.cpp
//  CodingPractise
//
//  Created by Dominic Zhang on 12/8/17.
//  Copyright © 2017 Dominic Zhang. All rights reserved.
//

#include "AddTwoNumbers.hpp"
#include "gtest/gtest.h"

/*

You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
Output: 7 -> 0 -> 8
 
*/

/**
 * Definition for singly-linked list.
 */

struct ListNode {
	int val;
	ListNode *next;
	ListNode(int x) : val(x), next(NULL) {}
};

ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
	ListNode dummyHeader(0);
	ListNode* current = &dummyHeader;
	int carryOn = 0;
	while (l1 != nullptr || l2 != nullptr)
	{
		int val1 = l1 != nullptr ? l1->val : 0;
		int val2 = l2 != nullptr ? l2->val : 0;
		current->next = new ListNode((val1 + val2 + carryOn) % 10);
		current = current->next;
		carryOn = (val1 + val2 + carryOn) / 10;
		if (l1 != nullptr)
			l1 = l1->next;
		if (l2 != nullptr)
			l2 = l2->next;
	}
	if (carryOn > 0)
		current->next = new ListNode(carryOn);
	return dummyHeader.next;
}

TEST(AddTwoNumbersTest, SameLengthNoCarryOn)
{
	ListNode l1[] = {ListNode(1), ListNode(2), ListNode(3)};
	l1[0].next = &l1[1];
	l1[1].next = &l1[2];

	ListNode l2[] = {ListNode(1), ListNode(2), ListNode(3)};
	l2[0].next = &l2[1];
	l2[1].next = &l2[2];

	auto result = addTwoNumbers(l1, l2);
	EXPECT_EQ(2, result->val);
	EXPECT_EQ(4, result->next->val);
	EXPECT_EQ(6, result->next->next->val);
}

TEST(AddTwoNumbersTest, DifferentLengthNoCarryOn)
{
	ListNode l1[] = {ListNode(1), ListNode(2)};
	l1[0].next = &l1[1];

	ListNode l2[] = {ListNode(1), ListNode(2), ListNode(3)};
	l2[0].next = &l2[1];
	l2[1].next = &l2[2];

	auto result = addTwoNumbers(l1, l2);
	EXPECT_EQ(2, result->val);
	EXPECT_EQ(4, result->next->val);
	EXPECT_EQ(3, result->next->next->val);
}

TEST(AddTwoNumbersTest, DifferentLengthWithCarryOn)
{
	ListNode l1[] = {ListNode(6), ListNode(7)};
	l1[0].next = &l1[1];

	ListNode l2[] = {ListNode(6), ListNode(7), ListNode(3)};
	l2[0].next = &l2[1];
	l2[1].next = &l2[2];

	auto result = addTwoNumbers(l1, l2);
	EXPECT_EQ(2, result->val);
	EXPECT_EQ(5, result->next->val);
	EXPECT_EQ(4, result->next->next->val);
}

TEST(AddTwoNumbersTest, DifferentLengthWithCarryOnOnLastDigit)
{
	ListNode l1[] = {ListNode(6), ListNode(7)};
	l1[0].next = &l1[1];

	ListNode l2[] = {ListNode(6), ListNode(7), ListNode(9)};
	l2[0].next = &l2[1];
	l2[1].next = &l2[2];

	auto result = addTwoNumbers(l1, l2);
	EXPECT_EQ(2, result->val);
	EXPECT_EQ(5, result->next->val);
	EXPECT_EQ(0, result->next->next->val);
	EXPECT_EQ(1, result->next->next->next->val);
}
