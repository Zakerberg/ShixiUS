//
//  SX_HomeModel.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/20/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  HomeModel

/*
 
 */

import UIKit
import ObjectMapper
import SwiftyJSON

class SX_HomeADModel {
    
    var title: String?
    var url: String?
    var image: String?
    var type: String?

    init(jsonData: JSON) {
        title = jsonData["title"].string
        url   = jsonData["url"].string
        image = jsonData["image"].string
        type  = jsonData["type"].string
    }
}

@objcMembers
class SX_HomeModel: NSObject {

    var training: SX_HomeTrainingModel?
    var jobs: SX_HomeJobsModel?
    var train:SX_HomeTrainModel?

    init(dic: [String: Any]) {
        super.init()
        setValuesForKeys(dic)
    }    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
    }
}

struct SX_HomeTrainingModel {

    var title:String?
    var price:String?
    var image:String?

    init(jsonData: JSON) {
        title = jsonData["title"].string
        price = jsonData["price"].string
        image = jsonData["image"].string
    }
}

struct SX_HomeJobsModel {

    var name: String?
    var trade:String?
    var address:String?
    var nature:String?

    init(jsonData: JSON) {
        name    = jsonData["name"].string
        trade   = jsonData["trade"].string
        address = jsonData["address"].string
        nature  = jsonData["nature"].string
    }
}

class SX_HomeTrainModel {

    var name:String?
    var price:String?
    var image:String?
    var category:String?

    init(jsonData: JSON) {
        name     = jsonData["name"].string
        price    = jsonData["price"].string
        category = jsonData["price"].string
        image    = jsonData["image"].string
    }
}



