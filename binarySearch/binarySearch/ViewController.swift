//
//  ViewController.swift
//  binarySearch
//
//  Created by Can Lee on 2020/3/8.
//  Copyright © 2020 Can Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nums = [-1,0,3,5,9,12]
        let target = 9
        let idx = Solution.search(nums, target)
        print(idx)
    }


}
/*
 给定一个 n 个元素有序的（升序）整型数组 nums 和一个目标值 target  ，写一个函数搜索 nums 中的 target，如果目标值存在返回下标，否则返回 -1。
 输入: nums = [-1,0,3,5,9,12], target = 9
 输出: 4
 解释: 9 出现在 nums 中并且下标为 4
 */

//note2: 有个细节要注意 midIndex = (lowerBound + upperBound) / 2 计算中间index如果用这种方式的话
//当数组count很大时，会导致int溢出,在64位的系统可能不会出现，但在32位系统肯定会出现这个问题

class Solution {
    static func search(_ nums: [Int], _ target: Int) -> Int {
        var low = 0
        var high = nums.count
        while low < high {
            // 这里计算
            let middle = low + (high - low)/2
            if target > nums[middle] {
                // 目标值大于中间值，则在右边
                low = middle + 1 // 要么这里+1
            } else if target < nums[middle] {
                // 目标值小于，则在左边，移动高指针到
                high = middle // 要么这里-1
            } else {
               return middle
            }
        }
        return -1
    }
}
