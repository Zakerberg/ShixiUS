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
import SwiftyJSON

// ==============================================================================================
// MARK: - 首页
// ==============================================================================================
struct SX_HomeADModel {
    
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

struct SX_HomeModel {
    
    var training: SX_HomeTrainingModel
    var jobs: SX_HomeJobsModel
    var train:SX_HomeTrainModel
    
    init(jsonData: JSON) {
        training = SX_HomeTrainingModel(jsonData: jsonData["training"])
        jobs     = SX_HomeJobsModel(jsonData: jsonData["jobs"])
        train    = SX_HomeTrainModel(jsonData: jsonData["train"])
    }
}

struct SX_HomeTrainingModel {
    
    var id:String?
    var title:String?
    var price:String?
    var image:String?
    
    init(jsonData: JSON) {
        id    = jsonData["id"].string
        title = jsonData["title"].string
        price = jsonData["price"].string
        image = jsonData["image"].string
    }
}

struct SX_HomeJobsModel {
    
    var id:Int?
    var name: String?
    var trade:String?
    var address:String?
    var nature:String?
    
    init(jsonData: JSON) {
        id      = jsonData["id"].int
        name    = jsonData["name"].string
        trade   = jsonData["trade"].string
        address = jsonData["address"].string
        nature  = jsonData["nature"].string
    }
}

struct SX_HomeTrainModel {
    
    var id:String?
    var name:String?
    var price:String?
    var image:String?
    var category:String?
    
    init(jsonData: JSON) {
        id       = jsonData["id"].string
        name     = jsonData["name"].string
        price    = jsonData["price"].string
        category = jsonData["category"].string
        image    = jsonData["image"].string
    }
}

// ==============================================================================================
// MARK: - 实训项目 ! ! !
// ==============================================================================================
struct SX_TrainingModel {
    
    var search: TrainingSearchModel
    var lists:TrainingListModel
    var type:TrainingTypeModel
    var country:TrainingCountryModel
    var sort:TrainingSortModel
    
    init(jsonData: JSON) {
        search  = TrainingSearchModel(jsonData: jsonData["search"])
        lists   = TrainingListModel(jsonData: jsonData["lists"])
        type    = TrainingTypeModel(jsonData: jsonData["type"])
        country =  TrainingCountryModel(jsonData: jsonData["country"])
        sort    = TrainingSortModel(jsonData: jsonData["sort"])
    }
}

struct TrainingSearchModel {
    
    var type:Int?
    var country:Int?
    var sort:String?
    var order:String?
    
    init(jsonData: JSON) {
        type    = jsonData["type"].int
        country = jsonData["country"].int
        sort    = jsonData["sort"].string
        order   = jsonData["order"].string
    }
}

struct TrainingListModel {
    
    var id: String?
    var title:String?
    var image:String?
    var price:String?
    
    init(jsonData: JSON) {
        id    = jsonData["id"].string
        title = jsonData["title"].string
        image = jsonData["image"].string
        price = jsonData["price"].string
    }
}

struct TrainingTypeModel {
    var id: String?
    var name:String?
    
    init(jsonData: JSON) {
        id   = jsonData["id"].string
        name = jsonData["name"].string
    }
}

struct TrainingCountryModel {
    
    var id: String?
    var name:String?
    var en_name:String?
    
    init(jsonData: JSON) {
        id      = jsonData["id"].string
        name    = jsonData["name"].string
        en_name = jsonData["en_name"].string
    }
}

struct TrainingSortModel {
    
    var name:String?
    var sort:String?
    var order:String?
    
    init(jsonData: JSON) {
        name  = jsonData["name"].string
        sort  = jsonData["sort"].string
        order = jsonData["order"].string
    }
}

// ==============================================================================================
// MARK: - 实训项目详情
// ==============================================================================================
struct SX_TrainingDetailModel {
    
    var id:Int?
    var image:String?
    var title:String?
    var outset_city:String?
    var features:String?
    var destine:String?
    var training: TrainingDetailTrainingModel
    var details: TrainingDetailDetailsModel
    var schedule:TrainingDetailScheduleModel
    var collection:Int?
    var collection_type:String?
    
}

struct TrainingDetailTrainingModel {
    
    var id: String?
    var title:String?
    
    init(jsonData: JSON) {
        id   = jsonData["id"].string
        title = jsonData["title"].string
    }
}

struct TrainingDetailDetailsModel {
    
    var id: String?
    var date:String?
    var price:String?
    
    init(jsonData: JSON) {
        id    = jsonData["id"].string
        date  = jsonData["date"].string
        price = jsonData["price"].string
    }
}

struct TrainingDetailScheduleModel {
    
    var sort:Int?
    var title:String?
    var location:String?
    var repast:String?
    var traffic:String?
    var content:String?
    
    init(jsonData: JSON) {
        sort     = jsonData["sort"].int
        title    = jsonData["title"].string
        location = jsonData["location"].string
        repast   = jsonData["repast"].string
        traffic  = jsonData["traffic"].string
        content  = jsonData["content"].string
    }
}

// ==============================================================================================
// MARK: -
// ==============================================================================================









