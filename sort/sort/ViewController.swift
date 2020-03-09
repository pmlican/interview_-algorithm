//
//  ViewController.swift
//  sort
//
//  Created by Can Lee on 2020/3/8.
//  Copyright © 2020 Can Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var arr = [3,5,1,9,5,2]
//        Sort.inserSort(arr: &arr)
//        Sort.quick(arr: &arr, low: 0, high: arr.count - 1)
        let arr1 = Sort.merge(arr: arr)
        print(arr1)
    }

}


class Sort {
    //选择排序：每次循环找出最小值，然后交换位置
    static func selection(arr: inout [Int]) {
        let count = arr.count
        for i in 0..<count-1 { // 外层循环表示循环多少趟
            var minIndex = i
            for j in i+1..<count { //内层循环表示比较多少次
                if arr[j] < arr[minIndex] {
                    minIndex = j
                }
            }
            if minIndex != i {
                let temp = arr[minIndex]
                arr[minIndex] = arr[i]
                arr[i] = temp
            }
        }
        
    }
    //冒泡排序：相邻元素两两比较
    static func bubble(arr: inout [Int]) {
        let count = arr.count
        for i in 0..<count-1 { // 外层循环表示循环多少趟
            for j in 0..<count-1-i { //内层循环表示比较多少次
                if arr[j] > arr[j+1] {
                    let temp = arr[j]
                    arr[j] = arr[j+1]
                    arr[j+1] = temp
                }
            }
        }
    }

    //插入排序：和选择排序类似，类似打牌，每次抽取一张，与前面元素比较，然后插入到最前面
    static func inserSort(arr: inout [Int]) {
        let count = arr.count
        for i in 1..<count {
            // 记录标记
            var j = i
            //取出当前标记位元素
            let temp = arr[j]
            //前面元素大于当前标记位元素，j>0要在前面，不然数组越界
            while j > 0 && temp < arr[j-1] {
                //前面元素往后挪动
                arr[j] = arr[j-1]
                //移动指针
                j -= 1
            }
            // 插入到空出的位置
            arr[j] = temp
        }
    }
    
    /*快排: 以第0个元素作为支点，操作左右高低指针，比较两个元素大小，小的在左侧，大的在右侧。然后左递归，右递归
    *递归要有出口，把问题化为子问题解决
    *分区方案有很多种：lomuto分区，hoare分区，DutchFlag分区
    *支点选择方案： 如何选择一个好的支点，一种是三个中间值，一种是随机取值
    let pivotIndex = Int.random(in: low...high)
    (a[pivotIndex], a[high]) = (a[high], a[pivotIndex])
    [3,5,1,9,5,2]
     */
    static func quick(arr: inout [Int], low: Int, high: Int) {
        //递归出口
        if low >= high {
            return
        }
        var i = low
        var j = high
        //以low作为key
        let key = arr[i]
        while i < j {
            //注意：一定要从右边开始比较，因为是以左边第0个元素作为支点。并且是arr[j] 大于等于 key，元素相等的情况下也要保持位置不变
            //从右边边比较,大于key保持位置不变
            while i < j && arr[j] >= key {
                j -= 1
            }
            // 如果小于key交换位置
            arr[i] = arr[j]
            // 从左边开始比较，比key小的数位置不变
            while i < j && arr[i] <= key {
                i += 1
            }
            // 只要出现一个比key大的数，将这个数放入右边j的位置
            arr[j] = arr[i]

        }
        arr[i] = key //将key放入i的位置，则左侧数都比key小，右侧数都比key大
        // 左递归
        quick(arr: &arr, low: low, high: i - 1)
        // 右递归
        quick(arr: &arr, low: i + 1, high: high)
    }
    
    /*
     归并排序：有两种解法自上向下，自下向上
     自上而下：比较容易理解，先无脑分，在递归合并
     自下而上：迭代法，利用双缓冲数组（二维数组），index=0读取，index=1写入
    */
    
    static func merge(arr: [Int]) -> [Int] {
        // 递归出口，保证分解的最小数组的count>1
        // 注意是大于1
        guard arr.count > 1 else {
            return arr
        }
        // 二分分解
        let m = arr.count / 2
        //注意这里的写法： Array(arr[0..<m]) 把0..<m 拷贝到新的数组
        let left = merge(arr: Array(arr[0..<m]))
        let right = merge(arr: Array(arr[m..<arr.count]))
        
        //合并左堆右堆
        return merge(left: left, right: right)
    }
    
    //辅助函数，用于递归合并左堆和右堆
    static func merge(left: [Int], right: [Int]) -> [Int] {
        // 定义左右指针
        var l = 0
        var r = 0
        var arr = [Int]()
        //这里指定数组容量，节省空间
        arr.reserveCapacity(left.count + right.count)
        // 判断数组越界
        while l < left.count && r < right.count {
            // 比较大小，把小的放到数组里面
            if left[l] < right[r] {
                arr.append(left[l])
                l += 1
            } else if left[l] > right[r] {
                arr.append(right[r])
                r += 1
            } else {
                arr.append(left[l])
                l += 1
                arr.append(right[r])
                r += 1
            }
        }
        // 如果左堆还有剩余，全部加入到数组
        while l < left.count {
            arr.append(left[l])
            l += 1
        }
        // 如果右堆有剩余，全部加入到数组
        while r < right.count {
            arr.append(right[r])
            r += 1
        }
        return arr
    }
}
