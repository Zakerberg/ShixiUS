//
//  SX_AddressModel.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/6.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

/*
 我揽着你的头发，不长也不短
 每一丝都穿过我的指尖
 在清晨，在午后，在每个夜里
 */

import UIKit

struct SXCountryModel {
    var countryDictionary: Dictionary<String,SXProvincesModel> = [:]
    var provincesArray: [String] = []
    init(dic:Dictionary<String,Dictionary<String,Array<String>>>){
        for (key,value) in dic{
            let model = SXProvincesModel(dic: value)
            countryDictionary[key] = model
            provincesArray.append(key)
        }
    }
}

struct SXProvincesModel{
    var provincesDictionary: Dictionary<String,SXCityModel> = [:]
    var cityArray: [String] = []
    init(dic:Dictionary<String,Array<String>>){
        for (key,value) in dic{
            let model = SXCityModel(Arr: value)
            provincesDictionary[key] = model
            cityArray.append(key)
        }
    }
}

struct SXCityModel {
    var areaArray: Array<String> = []
    init(Arr:Array<String>){
        for str in Arr{
            areaArray.append(str)
        }
    }
}
