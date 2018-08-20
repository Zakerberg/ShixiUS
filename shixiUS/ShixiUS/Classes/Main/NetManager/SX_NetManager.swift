//
//  SX_NetManager.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/17/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

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



















