//
//  ViewController.swift
//  linkedList
//
//  Created by Can Lee on 2020/3/8.
//  Copyright © 2020 Can Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let n1 = Node(4)
        let n2 = Node(3)
        let n3 = Node(2)
        let n4 = Node(1)

        n1.next = n2
        n2.next = n3
        n3.next = n4
        print(n1)
        
        let reNode = Solution.reverseLinkedList(head: n1)
        print(reNode)
    }


}

// 链表相关算法

class Solution {

    // 反转链表: 头差法
    static func reverseLinkedList(head: Node?) -> Node? {
        var p = head
        var newH: Node?
        while p != nil {
            // 先取出next
            let next = p?.next
            // 改变原头节点指向新的空节点
            p?.next = newH
            // 移动新头结点指针
            newH = p
            // 移动p指针继续遍历
            p = next
        }
        //返回新的头节点
        return newH
    }
    
}

// 定义节点
class Node {
    var value: Int
    var next: Node?
    init(_ value: Int) {
        self.value = value
        self.next = nil
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        var temp: Node? = self
        var str = ""
        while temp != nil {
            str += "\(temp!.value)->"
            temp = temp?.next
        }
        return str
    }
}
