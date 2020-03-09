//
//  ViewController.swift
//  hash
//
//  Created by Can Lee on 2020/3/8.
//  Copyright © 2020 Can Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let str = "abaccdeff"
        let c = Solution.firstUniqChar(str)
        print(c)
    }
    
    // 在字符串 s 中找出第一个只出现一次的字符。如果没有，返回一个单空格。
}
/*
 s = "abaccdeff"
 返回 "b"

 s = ""
 返回 " "

 限制：
 0 <= s 的长度 <= 50000
 
 思路：字符是一个长度为8的数据类型，因此总共有可能256种可能。
 每个字母根据其ASCII码值作为数组下标对应数组的一个数字。
 数组中存储的是每个字符的出现次数

 例如字母a,对应ASCII值时97，数组索引下标为97
 */

class Solution {
    static func firstUniqChar(_ s: String) -> Character {
        var target: Character = " "
        // 第一次遍历，先把字符串每个字母出现次数，存到256的数组
        var arr = Array(0..<256).map { _ in return 0}
        for c in s {
            if let ascii = c.asciiValue {
                let idx = Int(ascii)
                arr[idx] += 1
            }
        }
        
        // 从头遍历存储的数组，找到第一个为1的字符
        for c in s {
            if let ascii = c.asciiValue {
                let idx = Int(ascii)
                if arr[idx] == 1 {
                    target = c
                    break
                }
            }
        }
        return target
    }
}
