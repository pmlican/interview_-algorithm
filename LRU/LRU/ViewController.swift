//
//  ViewController.swift
//  LRU
//
//  Created by wanghaiwei on 2020/3/12.
//  Copyright © 2020 Shenzhen Hupzon Energy Technology Co., Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cache = LRU(capacity: 2)
        cache.put(key: 1, value: 1)
        cache.put(key: 2, value: 2)
        print(cache.get(key: 1))     // 返回1
        cache.put(key: 3, value: 3)  //该操作会使key2作废
        print(cache.get(key: 2))    // 返回-1
        cache.put(key: 4, value: 4) // 该操作会使key1作废
        print(cache.get(key: 1))  // 返回-1
        print(cache.get(key: 3)) //返回3
        print(cache.get(key: 4)) //返回4
    }


}


class DLinkedNode {
    var key: Int
    var value: Int
    var pre: DLinkedNode?
    var next: DLinkedNode?
    init(value: Int, key: Int) {
        self.value = value
        self.key = key
    }
}


class LRU {
    // 使用双向链表的一个好处是不需要额外信息删除一个节点，同时可以在常数时间内从头部或尾部插入删除节点。
    // 一个需要注意的是，在双向链表实现中，这里使用一个伪头部和伪尾部标记界限，这样在更新的时候就不需要检查是否是 null 节点
    var head: DLinkedNode? = nil
    var tail: DLinkedNode? = nil
    var size = 0
    var capacity = 0
    var cache = [Int: DLinkedNode]()
    
    // 插入在head之后
    func addNode(node: DLinkedNode) {
        node.pre = head
        node.next = head?.next
        
        head?.next?.pre = node
        head?.next = node
    }
    // 移除任意一个node
    func removeNode(node: DLinkedNode?) {
        let pre = node?.pre
        let next = node?.next
        
        pre?.next = next
        next?.pre = pre
    }
    
    func moveToHead(node: DLinkedNode) {
        // 断开node连接
        removeNode(node: node)
        // 把它插入到head之后
        addNode(node: node)
    }
    
    //移除最后一个节点
    func popTail() -> DLinkedNode? {
        let res = tail?.pre
        removeNode(node: res)
        return res
    }
    
    // 以下几个是操作函数
    init(capacity: Int) {
        self.capacity = capacity
        self.size = 0
        head = DLinkedNode(value: 0, key: 0)
        tail = DLinkedNode(value: 0, key: 0)
        head?.next = tail
        tail?.pre = head
    }
    
    func get(key: Int) -> Int {
        let node = cache[key]
        //如果在缓存中
        if let node = node {
            //把它挪到head之后
            moveToHead(node: node)
            return node.value
        } else {
            // 缓存没找到就返回-1
            return -1
        }
    }
    func put(key: Int, value: Int) {
        let node = cache[key]
        // 如果新添加的节点存在
        if let node = node {
            //更新值
            node.value = value
            //移动到head后面
            moveToHead(node: node)
        } else {
            //创建新节点
            let newNode = DLinkedNode(value: value, key: key)
            //添加到缓存
            cache[key] = newNode
            //把它插入到head后面
            addNode(node: newNode)
            //更新size值
            size += 1
            //如果size超过容量值
            if size > capacity {
                //把最后一个节点移除
                //更新size值
                let tail = popTail()
                if let key = tail?.key {
                    cache[key] = nil
                    size -= 1
                }
            }
        }
    }
}
