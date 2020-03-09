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

     
     */

}

