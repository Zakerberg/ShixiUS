//
//  SX_HomeAPI.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/21/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  首页API

import UIKit
import Moya
import SwiftyJSON

//初始化请求的provider
let SX_NetProvider = MoyaProvider<Home>()

// ==========================================================================================================================
// MARK: - 请求分类 -- HOME
// ==========================================================================================================================
public enum Home {
    case channels
    case playlist(String)
}

extension Home: TargetType {
    
    //服务器地址
    public var baseURL: URL {
        return URL(string: "https://www.shixi.com")!
    }
    
    //各个请求的具体路径
    public var path: String {
        
        return ""
    }
    
    //请求类型
    public var method: Moya.Method {
        return .get
    }
    
    //请求任务事件（这里附带上参数)
    public var task: Task {
        switch self {
        case .playlist(let channel):
            var params: [String: Any] = [:]
            params["channel"] = channel
            params["type"] = "n"
            params["from"] = "mainsite"
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    //请求头
    public var headers: [String: String]? {
        return nil
    }
}

