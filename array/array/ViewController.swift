//
//  ViewController.swift
//  array
//
//  Created by Can Lee on 2020/3/8.
//  Copyright © 2020 Can Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var nums1 = [1,2,0,0,0,0]
        let nums2 = [2,5,6,8]
        // 注意这里是，m = 2, n = 4，m是不包括0的，这样写是保证m有足够空间容纳n
        Solution.merge1(&nums1, 2, nums2, 4)
        print(nums1)
    }


}
/*
 给你两个有序整数数组 nums1 和 nums2，请你将 nums2 合并到 nums1 中，使 num1 成为一个有序数组。

 说明:
 
 初始化 nums1 和 nums2 的元素数量分别为 m 和 n 。
 你可以假设 nums1 有足够的空间（空间大小大于或等于 m + n）来保存 nums2 中的元素。

 输入:
 nums1 = [1,2,3,0,0,0], m = 3
 nums2 = [2,5,6],       n = 3

 输出: [1,2,2,3,5,6]
 
 解法一：双指针，从头比较大小，但因为nums1作为输出数组，所以要把nums1拷贝一份，所以需要额外的存储空间O(m)
 解法二：双指针从后遍历，再加一个p指针指向nums1数组的尾部，从后面添加。
 如果我们从结尾开始改写 nums1 的值又会如何呢？这里没有信息，因此不需要额外空间。

 */
class Solution {
    //MARK: 合并两个有序数组
    // 有序数组合并,注意的是合并到nums1,所以nums1是inout修饰
    static func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        let nums1copy = Array(nums1[0..<m])
        var p1 = 0 // 指向nums1copy
        var p2 = 0 // 指向nums2
        var i = 0 // 执行num1
        while p1 < m && p2 < n {
            if nums1copy[p1] < nums2[p2] {
                nums1[i] = nums1copy[p1]
                p1 += 1
            } else {
                nums1[i] = nums2[p2]
                p2 += 1
            }
            i += 1
        }
        while p1 < m {
            nums1[i] = nums1copy[p1]
            p1 += 1
            i += 1
        }
        while p2 < n {
            nums1[i] = nums2[p2]
            p2 += 1
            i += 1
        }
    }
    
    static func merge1(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var p1 = m - 1
        var p2 = n - 1
        var p = m + n - 1
        
        while p1 >= 0 && p2 >= 0 {
            if nums1[p1] < nums2[p2] {
                nums1[p] = nums2[p2]
                p -= 1
                p2 -= 1
            } else {
                nums1[p] = nums1[p1]
                p -= 1
                p1 -= 1
            }
        }
        // 这里要处理 num2 还有剩余的情况，因为num1保证有足够空间容纳num2
        while p2 >= 0 {
            nums1[p] = nums2[p2]
            p2 -= 1
            p -= 1
        }
        // 或者是这种写法
//        if p2 >= 0 {
//            nums1[0...p2] = nums2[0...p2]
//        }
    }
    
    //MARK: 求无序数组的中位数
    /*
     解法一： 先排序后取中位数
     解法二： 利用快排思想， 效率最优
     */
    
    
}


