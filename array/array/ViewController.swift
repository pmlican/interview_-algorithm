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
        test2()
    }

    func test1() {
        var nums1 = [1,2,0,0,0,0]
        let nums2 = [2,5,6,8]
        // 注意这里是，m = 2, n = 4，m是不包括0的，这样写是保证m有足够空间容纳n
        Solution.merge1(&nums1, 2, nums2, 4)
        print(nums1)
    }
    func test2() {
        var arr = [12,3,10,8,6,7,11,13,9] // 3,6,7,8,9,10,11,12,13 => 9
//        var arr = [1,5,6,2,10,3] // 1,2,3,5,6,10 => 3
        
        let mid = Solution.findMedian(arr: &arr)
        print(mid)
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
        // 这里要处理 num2 还有剩余的情况，因为num1保证有足够空间容纳num2， 因为 m <= n
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
     [12,3,10,8,6,7,11,13,9]
     */
    static func findMedian(arr: inout [Int]) -> Int {
        //使用快排思想，任意挑选一个元素，以该元素为支点，划分集合为两部分。
        //如果左侧集合的长度==(n-1)/2，那么支点就是中位数。
        //如果左侧集合的长度<(n-1)/2，那么中位数在右侧，反之，中位数载左侧。
        let i = 0
        let j = arr.count - 1
        let mid = (arr.count - 1) / 2
        var div = partSort1(arr: &arr, start: i, end: j)
        while div != mid {
            if mid < div {
                div = partSort1(arr: &arr, start: i, end: div - 1)
            } else {
                div = partSort1(arr: &arr, start: div + 1, end: j)
            }
        }
        return arr[mid]
    }
    static func partSort(arr: inout [Int], start: Int, end: Int) -> Int {
        var i = start
        var j = end
        //选取关键字
        let key = arr[j]
        
        while i < j {
            //左边找比key大的值
            while i < j && arr[i] <= key {
                i += 1
            }
            //右边找比key小的值
            while i < j && arr[j] >= key {
                j -= 1
            }
            if i < j {
                //找到之后交换左右的值
                let temp = arr[i]
                arr[i] = arr[j]
                arr[j] = temp
            }
        }
        // j在中间位置，把key的值放到j的位置交换， 左边比key小，右边比key大
        let temp = arr[j]
        arr[j] = arr[end]
        arr[end] = temp
        // 这里return j 和 i 是一样的
        return j
    }

    static func partSort1(arr: inout [Int], start: Int, end: Int) -> Int {
        var i = start
        var j = end
        //选取关键字
        let key = arr[j]
        
        while i < j {
            //左边找比key大的值
            while i < j && arr[i] <= key {
                i += 1
            }
            arr[j] = arr[i]
            //右边找比key小的值
            while i < j && arr[j] >= key {
                j -= 1
            }
            arr[i] = arr[j]
        }
        arr[j] = key
        
        return j
    }
    
}


