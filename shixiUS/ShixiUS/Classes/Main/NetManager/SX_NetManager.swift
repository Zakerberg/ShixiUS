//
//  SX_NetManager.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/17/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//
/*
 
 那一天，
 我闭目在经殿的香雾中，
 蓦然听见你颂经中的真言；
 
 那一月，
 我摇动所有的经筒，
 不为超度，
 只为触摸你的指尖；
 
 那一年，
 磕长头匍匐在山路，
 不为觐见，
 只为贴着你的温暖；
 
 那一世，
 转山转水转佛塔，
 不为修来世，
 只为途中与你相见
 
 那一月，
 我轻转过所有经筒，
 不为超度，只为触摸你的指纹；
 
 那一年，我磕长头拥抱尘埃，
 不为朝佛，只为贴着你的温暖；
 
 那一世，我细翻遍十万大山，
 不为修来世，只为路中能与你相遇；
 
 只是，就在那一夜，我忘却了所有，
 抛却了信仰，舍弃了轮回，
 只为，那曾在佛前哭泣的玫瑰，
 早已失去旧日的光泽
 
 */

import UIKit
import Moya
import SwiftyJSON
import Alamofire

/// 超时时长
private var requestTimeOut:Double = 30
///成功数据的回调
typealias successCallback = ((String) -> (Void))
///失败的回调
typealias failedCallback = ((String) -> (Void))
///网络错误的回调
typealias errorCallback = (() -> (Void))



















