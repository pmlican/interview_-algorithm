//
//  ViewController.swift
//  heap
//
//  Created by Can Lee on 2020/3/9.
//  Copyright © 2020 Can Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    /*
  堆：分为最大堆和最小堆。例如：最大堆，每个父节点都大于其子节点。用数组实现树状结构似乎比较奇怪，但它在时间和空间上都很高效的
  注意：堆的根节点是最大或最小元素，但其他元素的排序顺序是不可预测的。例如，最大元素始终位于max-heap中的索引0处，但最小元素不一定是最后一个元素。 —— 唯一的保证是，最小元素是叶节点之一，但不知道是哪一个。
     
     堆是用数组表示的一个类似二叉树，用数组索引表示他们的关系，省去了指针开销
         10
        /  \
       7    2
      / \
     5   1
     [ 10, 7, 2, 5, 1 ]
     parent(i) = floor((i - 1)/2)
     left(i)   = 2i + 1
     right(i)  = 2i + 2

     // 数学部分：
         0
       /   \
      1      2
     / \    /  \
    3   4   5      6
   / \  /\  / \   / \
  7 8  9 10 11 12 13 14
     heap高度指从根节点到最低叶子节点的距离:
     h = floor(log2(n)) = floor(log2(15)) = floor(3.91) = 3
     levels = h + 1 = 4
     
     最后一级节点数： 2^3 = 8
     除了最后一级节点的总数： 2^3 - 1 = 7
     总共节点数 2^(h+1) - 1 = 2^4 - 1 = 16 - 1 = 15

数组索引和level之间的关系
level: 1    2       3
     [10,| 7, 9,| 5, 1, 2, 8]
     
         10
        /  \
      7       9
     /  \    /  \
    5   1    2   8
     */
    
    /*
     堆思路:
     1.需要一个shiftDown操作函数
     2.需要一个shiftUp操作函数
     3.需要左子节点，右子节点，父节点计算公式
     4.需要一个nodes数组展示里面的元素
     
     插入操作：在数组末尾添加元素，再做shiftUp操作
     删除操作：1.删除叶子节点，把叶子放到堆顶，做shiftDown操作
     2.删除任意节点，判断是不是叶子节点，如果是叶子节点直接删除，否则把要删除的节点与数组最后一个元素交换，然后做shiftDown和shiftUp操作，然后removeLast
     构建堆操作： O(n)时间效率 ,基于shiftDown， 因为 floor(n/2)到n-1时叶子节点，可以跳过， 从floor(n/2)倒序遍历到0 做shiftDown操作
    O(nlogn)时间效率，直接遍历数组，然后调用insert操作
     */

}

