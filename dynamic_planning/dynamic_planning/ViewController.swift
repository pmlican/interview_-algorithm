//
//  ViewController.swift
//  dynamic_planning
//
//  Created by Can Lee on 2020/3/9.
//  Copyright © 2020 Can Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let res = climbStairs1(n: 10)
        print(res)
    }
    /*
     动态规划: 动态规划算法通常基于一个递推公式及一个或多个初始状态。 当前子问题的解将由上一次子问题的解推出。
     三个核心要素：最优子结构，边界，状态转移方程
     效果：可以是O(n^2)的时间复杂度降低为O(n)
     例子：爬楼梯，斐波拉契数
     */
    
    /*
     题目描述：有 N 阶楼梯，每次可以上一阶或者两阶，求有多少种上楼梯的方法。
     思路一： f(n) = f(n-1) + f(n-2) ，例如爬10步的阶梯，最一步要么走1个台阶，要么走2个台阶
     思路二： 备忘录模式，额外增加一个字典
     思路三： 动态规划：当前步数为，前两个台阶步数之和，可以用个变量记录
     ----------------------------------------------
     台阶数| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10
     ----------------------------------------------
     走法数| 1 | 2 | 3 | 5 |
     */
    
    //递归法：
    func climbStairs1(n: Int) -> Int {
        if n < 3 {
            return n
        }
        return climbStairs1(n: n-1) + climbStairs1(n: n-2)
    }
    //动态规划：
    func climbStairs(n: Int) -> Int {
        if n == 1 {
            return 1
        }
        var a = 1
        var b = 2
        for _ in 3...n {
            let sum = a + b
            a = b
            b = sum
        }
        return b
    }
    
    //MARK:斐波那契数
    /*
     斐波那契数，通常用 F(n) 表示，形成的序列称为斐波那契数列。该数列由 0 和 1 开始，后面的每一项数字都是前面两项数字的和。
     F(0) = 0,   F(1) = 1
     F(N) = F(N - 1) + F(N - 2), 其中 N > 1.
     输入：2
     输出：1
     解释：F(2) = F(1) + F(0) = 1 + 0 = 1.
     0, 1, 1, 2, 3, 5
     */
    func fib(n: Int) -> Int {
        if n <= 1 {
            return n
        }
        if n == 2 {
            return 1
        }
        var temp = 0
        var a = 1
        var b = 1
        for _ in 3...n {
            temp = a + b
            b = a
            a = temp
        }
        return temp
    }
    
    func fib1(n: Int) -> Int {
        if n <= 1 {
            return n
        }
        return fib1(n: n-1) + fib1(n: n-2)
    }

}

