//
//  SX_Regex.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/30. 
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  基于NSRegularExpression api 的正则处理工具类

/*
 梦停留在最初的浪漫
 不管时光翻越了多少山峦
 你一直在我身边
 */

import UIKit

public struct Regex {
    private let regularExpression: NSRegularExpression
    
    // 使用正则表达式进行初始化
    public init(_ pattern: String, options: options = []) throws {
        regularExpression = try NSRegularExpression(
            pattern: pattern,
            options:options.toNSRegularExpressions
        )
    }
}












