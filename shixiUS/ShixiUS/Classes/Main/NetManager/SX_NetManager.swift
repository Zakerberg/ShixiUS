//
//  SX_NetManager.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/17/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  Net

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
import Alamofire

let SX_GROUP_TOKEN : String = "SX_GROUP_TOKEN"

enum SXMethod {
    case GET
    case POST
}

class SX_NetManager {
    class func requestData(type : SXMethod, URlString: String, parameters : [String : String]? = nil,  finishCallBack : @escaping (_ responseCall : Data)->()){
        
        let type = type == SXMethod.GET ? HTTPMethod.get : HTTPMethod.post
        // 配置 HTTPHeaders
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "charset":"utf-8",
            ]
        
        Alamofire.request(URlString, method: type, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            // 处理 cookie
            
            if let headerFields = response.response?.allHeaderFields as? [String: String] {
                let url = response.request?.url
                let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url!)
                var cookieArray = [ [HTTPCookiePropertyKey : Any ] ]()
                for cookie in cookies {
                    cookieArray.append(cookie.properties!)
                }
                if !(UserDefaults.standard.object(forKey: SX_GROUP_TOKEN) != nil){
                    // 保存 cookie
                    UserDefaults.standard.set(cookieArray, forKey: SX_GROUP_TOKEN)
                }else{
                    print("token\(String(describing: UserDefaults.standard.object(forKey: SX_GROUP_TOKEN)))")
                }
            }
            
            //  let headerFields = response.response?.allHeaderFields as! [String: String]
            
            SXLog("Method:\(type)请求\nURL: \(URlString)\n请求参数: \(String(describing: parameters))")
            if parameters != nil{
                print(response.request?.url ?? "url")
                
                print(parameters ?? String())
            }
            
            guard let result = response.result.value else {
                print(response.result.error ?? "错误❌")
                return
            }
            
            guard let dict = result as? [String : Any] else {
                return
            }
            
            // 返回字典类型 Data
            if let dataDict = dict["data"] as? [String : Any] {
                
                let jsonData = try? JSONSerialization.data(withJSONObject: dataDict, options: .prettyPrinted)
                SXLog(dict)
                if jsonData != nil {
                    finishCallBack(jsonData!)
                    return
                }
            }
            
            // 返回数组类型Data
            if ((dict["data"] as? [Any]) != nil) {
                let arrData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                SXLog(dict)
                if arrData != nil {
                    finishCallBack(arrData!)
                }
            }
            
            if let Dict = dict as? [String : Any] {
                
                let Data = try? JSONSerialization.data(withJSONObject: Dict, options: .prettyPrinted)
                SXLog(dict)
                if Data != nil {
                    finishCallBack(Data!)
                    return
                }
            }
        }
    }
}

