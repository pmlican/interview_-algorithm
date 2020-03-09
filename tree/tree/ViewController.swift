//
//  ViewController.swift
//  tree
//
//  Created by Can Lee on 2020/3/9.
//  Copyright © 2020 Can Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
              1
            /    \
           2      3
          /  \   /  \
         4   5  6    7
         BFS: 1,2,3,4,5,6,7
         DFS: 1,2,4,5,3,6,7
         
         */
        
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        let node4 = TreeNode(4)
        let node5 = TreeNode(5)
        let node6 = TreeNode(6)
        let node7 = TreeNode(7)
        
        node1.left = node2
        node1.right = node3
        
        node2.left = node4
        node2.right = node5
        
        node3.left = node6
        node3.right = node7
        
        let arr = Solution.preOrder(node1)
        print(arr)
        
        let arr1 = Solution.DFS(node1)
        print(arr1)
        
        let arr2 = Solution.BFS(node1)
        print(arr2)

        let depth = Solution.maxDepth(node1)
        print(depth)
        
        let isSymmetric = Solution.isSymmetric(node1)
        print(isSymmetric)
    }


}

/*
 树一般考察二叉树
 二叉树：主要是递归思想
 1.二叉树遍历
 按照顺序分为： 前序，中序，后序遍历。以根节点为顺序区别，比如前序遍历是：根，左，右
 按照广度优先和深度优先： BFS广度优先遍历（层序遍历），DFS深度优先遍历（前序遍历）
 2.二叉树构建
 构建二叉树一定要有中序遍历，来确定左右子树
 前序和后序是确定根节点
     - *  =  = =
 中序  9 3 15 20 7
      - =  = =  *
 后序  9 15 7 20 3
      * - =  =  =
 先序  3 9 20 15 7
 
 *代表根节点
 -代表左子树节点
 =代表右子树节点
 
 3.二叉树最近公共祖先
 
 4.二叉树最大深度
 */

class TreeNode {
    var value: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ value: Int) {
        self.value = value
        self.left = nil
        self.right = nil
    }
}

class Solution {
    //MARK: 遍历面试题
    // 递归前序遍历
    static func preOrder(_ root: TreeNode?) -> [Int] {
        var arr = [Int]()
        helper(root, arr: &arr)
        return arr
    }
    // 需要个辅助函数
    static func helper(_ node: TreeNode?, arr: inout [Int]) {
        if node == nil {return}
        // 其他的中序和后序，就是调下这里的位置
        arr.append(node!.value)
        helper(node?.left, arr: &arr)
        helper(node?.right, arr: &arr)
    }
    
    // 迭代方法：深度优先,前序：根，左，右。用辅助栈来实现
    static func DFS(_ root: TreeNode?) -> [Int] {
        var arr = [Int]()
        var stack = [root]
        while !stack.isEmpty {
            let node = stack.removeLast()
            // 先右，因为栈是先进后出
            if let right = node?.right {
                stack.append(right)
            }
            // 再左
            if let left = node?.left {
                stack.append(left)
            }
            arr.append(node!.value)
        }
        
        return arr
    }
    
    // 广度优选遍历。层序遍历。用辅助队列来实现
    static func BFS(_ root: TreeNode?) -> [Int] {
        var arr = [Int]()
        var queue = [root]
        // 判断队列是否为空
        while !queue.isEmpty {
            let node = queue.removeFirst()
            // 先左，先进先出
            if let left = node?.left {
                queue.append(left)
            }
            // 再右
            if let right = node?.right {
                queue.append(right)
            }
            arr.append(node!.value)
        }
        return arr
    }
    
    //MARK: 二叉树最大深度面试题
    /*
      3
     / \
    9  20
      /  \
     15   7
    最大深度为3
    */
    static func maxDepth(_ root: TreeNode?) -> Int {
        // 思路，递归左右叶子节点，比较它们最大值，再加1
        if root == nil {return 0} //递归出口
        return max(maxDepth(root?.left), maxDepth(root?.right)) + 1
    }
    //MARK: 判断二叉树是否对称
    /*
        1
       / \
      2   2
     / \ / \
    3  4 4  3   对称
     1
     / \
    2   2
     \   \
     3    3      不对称
    */
    static func isSymmetric(_ root: TreeNode?) -> Bool {
        // 思路，递归的子问题是什么，递归结束的条件是什么
        // 需要一个辅助函数，参数为，左右子节点
        return root == nil || symmetricHelper(root?.left, right: root?.right)
    }
    
    static func symmetricHelper(_ left: TreeNode?, right: TreeNode?) -> Bool {
        //递归出口
        if left == nil && right == nil {
            return true
        } // 这两个if判断不能调换，因为有先后顺序
        if left == nil || right == nil {
            return false
        }
        // 子问题: 1.左右值是否相等 2.左边的左边和右边的右边 3.左右和右左
        return (left?.value == right?.value)
            && symmetricHelper(left?.left, right: right?.right)
            && symmetricHelper(left?.right, right: right?.left)
        
    }
}
