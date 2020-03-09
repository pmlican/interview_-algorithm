//
//  ViewController.swift
//  findSuperviews
//
//  Created by Can Lee on 2020/3/8.
//  Copyright © 2020 Can Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v1 = UIView()
        let v2 = UIView()
        let v3 = UIView()
        let v4 = UIView()
        
        v1.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        v2.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        v1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        v2.frame = CGRect(x: 50, y: 0, width: 50, height: 50)
        
        v3.backgroundColor = UIColor.red
        v3.frame = CGRect(x: 0, y: 100, width: 100, height: 100)
        
        v4.backgroundColor = UIColor.blue
        v4.frame = CGRect(x: 0, y: 100, width: 200, height: 200)
        
        
        view.addSubview(v4)
        v4.addSubview(v3)
        v3.addSubview(v1)
        v3.addSubview(v2)
        let superView = Find.findLastCommonSuperView(v1: v1, v2: v2)
        print(superView)
        let superViews = Find.findCommonSuperViews(v1: v1, v2: v2)
        print(superViews)
    }


}

class Find {
    // 找到两个子视图的共同父视图
    static func findCommonSuperViews(v1: UIView, v2: UIView) -> [UIView] {
        let arr1 = findSuperViews(view: v1)
        let arr2 = findSuperViews(view: v2)
        var all = [UIView]()
        var i = 0
        //判断数组越界
        while i < min(arr1.count, arr2.count) {
            //倒序查找
            let super1 = arr1[arr1.count-1-i]
            _ = arr2[arr2.count-1-i]

            if super1 == super1 {
                all.append(arr1[i])
                i += 1
            } else {
                // 找到第一个不同时结束循环
                break
            }
        }
        return all
    }
    
    //找到最近的共同父视图
    static func findLastCommonSuperView(v1: UIView, v2: UIView) -> UIView? {
        let arr1 = findSuperViews(view: v1)
        let arr2 = findSuperViews(view: v2)
        
        var i = 0
        
        while i < min(arr1.count, arr2.count) {
            let super1 = arr1[i]
            let super2 = arr2[i]
            if super1 == super2 {
                return super1
            }
            i += 1
        }
        return nil
    }
    
    static func findSuperViews(view: UIView) -> [UIView] {
        var temp = view.superview
        var arr = [UIView]()
        while temp != nil {
            arr.append(temp!)
            temp = temp?.superview
        }
        return arr
    }
}

