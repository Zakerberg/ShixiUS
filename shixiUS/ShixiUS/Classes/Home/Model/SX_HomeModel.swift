//
//  SX_HomeModel.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/20/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  SX_Model 

/*
 纵使高原上的风 吹不散  执着的背影
 纵使清晨前的霜 融不化  心头的温热
 你静守在月下
 悄悄地来
 悄悄地走
 仓央嘉措
 */

import UIKit
import SwiftyJSON

// ==============================================================================================
// MARK: - 首页广告 index/AD
// ==============================================================================================
struct SX_HomeADModel {
    
    var title: String?
    var url: String?
    var image: String?
    var type: String?
    
    init(jsonData: JSON) {
        title          = jsonData["title"].string
        url            = jsonData["url"].string
        image          = jsonData["image"].string
        type           = jsonData["type"].string
    }
}

// ===================================================================++++++++++++++++++++++++++++
// MARK: - 首页 index/index
// ===================================================================++++++++++++++++++++++++++++
struct SX_HomeModel {
    
    var training: SX_HomeTrainingModel
    var jobs: SX_HomeJobsModel
    var train:SX_HomeTrainModel
    
    init(jsonData: JSON) {
        training       = SX_HomeTrainingModel(jsonData: jsonData["training"])
        jobs           = SX_HomeJobsModel(jsonData: jsonData["jobs"])
        train          = SX_HomeTrainModel(jsonData: jsonData["train"])
    }
}

struct SX_HomeTrainingModel {
    
    var id:String?
    var title:String?
    var price:String?
    var image:String?
    
    init(jsonData: JSON) {
        id             = jsonData["id"].string
        title          = jsonData["title"].string
        price          = jsonData["price"].string
        image          = jsonData["image"].string
    }
}

struct SX_HomeJobsModel {
    
    var id:Int?
    var name: String?
    var trade:String?
    var address:String?
    var nature:String?
    
    init(jsonData: JSON) {
        id             = jsonData["id"].int
        name           = jsonData["name"].string
        trade          = jsonData["trade"].string
        address        = jsonData["address"].string
        nature         = jsonData["nature"].string
    }
}

struct SX_HomeTrainModel {
    
    var id:String?
    var name:String?
    var price:String?
    var image:String?
    var category:String?
    
    init(jsonData: JSON) {
        id             = jsonData["id"].string
        name           = jsonData["name"].string
        price          = jsonData["price"].string
        category       = jsonData["category"].string
        image          = jsonData["image"].string
    }
}

// ==============================================================================================
// MARK: - 实训项目列表页 ! ! ! /training/index
// ==============================================================================================
struct SX_TrainingModel {
    
    var search: TrainingSearchModel
    var lists:TrainingListModel
    var type:TrainingTypeModel
    var country:TrainingCountryModel
    var sort:TrainingSortModel
    
    init(jsonData: JSON) {
        search         = TrainingSearchModel(jsonData: jsonData["search"])
        lists          = TrainingListModel(jsonData: jsonData["lists"])
        type           = TrainingTypeModel(jsonData: jsonData["type"])
        country        = TrainingCountryModel(jsonData: jsonData["country"])
        sort           = TrainingSortModel(jsonData: jsonData["sort"])
    }
}

struct TrainingSearchModel {
    
    var type:Int?
    var country:Int?
    var sort:String?
    var order:String?
    
    init(jsonData: JSON) {
        type           = jsonData["type"].int
        country        = jsonData["country"].int
        sort           = jsonData["sort"].string
        order          = jsonData["order"].string
    }
}

struct TrainingListModel {
    
    var id: String?
    var title:String?
    var image:String?
    var price:String?
    
    init(jsonData: JSON) {
        id             = jsonData["id"].string
        title          = jsonData["title"].string
        image          = jsonData["image"].string
        price          = jsonData["price"].string
    }
}

struct TrainingTypeModel {
    var id: String?
    var name:String?
    
    init(jsonData: JSON) {
        id             = jsonData["id"].string
        name           = jsonData["name"].string
    }
}

struct TrainingCountryModel {
    
    var id: String?
    var name:String?
    var en_name:String?
    
    init(jsonData: JSON) {
        id             = jsonData["id"].string
        name           = jsonData["name"].string
        en_name        = jsonData["en_name"].string
    }
}

struct TrainingSortModel {
    
    var name:String?
    var sort:String?
    var order:String?
    
    init(jsonData: JSON) {
        name           = jsonData["name"].string
        sort           = jsonData["sort"].string
        order          = jsonData["order"].string
    }
}

// ==============================================================================================
// MARK: - 实训项目详情 /training/view/id/实训id
// ==============================================================================================
struct SX_TrainingDetailModel {
    
    var id:String?
    var image:String?
    var title:String?
    var outset_city:String?
    var features:String?
    var expense:String?
    var destine:String?
    var training: TrainingDetailTrainingModel
    var details: TrainingDetailDetailsModel
    var schedule:TrainingDetailScheduleModel
    var collection:Int?
    var collection_type:String?
    
    init(jsonData: JSON) {
        training       = TrainingDetailTrainingModel(jsonData: jsonData["training"])
        details        = TrainingDetailDetailsModel(jsonData: ["details"])
        schedule       = TrainingDetailScheduleModel(jsonData: ["schedule"])
    }
}

struct TrainingDetailTrainingModel {
    
    var id: String?
    var title:String?
    
    init(jsonData: JSON) {
        id             = jsonData["id"].string
        title          = jsonData["title"].string
    }
}

struct TrainingDetailDetailsModel {
    
    var id: String?
    var date:String?
    var price:String?
    
    init(jsonData: JSON) {
        id             = jsonData["id"].string
        date           = jsonData["date"].string
        price          = jsonData["price"].string
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
        sort           = jsonData["sort"].int
        title          = jsonData["title"].string
        location       = jsonData["location"].string
        repast         = jsonData["repast"].string
        traffic        = jsonData["traffic"].string
        content        = jsonData["content"].string
    }
}

// ==============================================================================================
// MARK: - 实训报名页 /training/apply
// ==============================================================================================
struct SX_TrainingApplyModel {
    
    var uid:String?
    var training:String?
    var detail:String?
    var title:String?
    var country:TrainingApplyCountryModel
    var member:TrainingApplyMemberModel
    
    init(jsonData: JSON) {
        uid             = jsonData["uid"].string
        training        = jsonData["training"].string
        detail          = jsonData["detail"].string
        title           = jsonData["title"].string
        country         = TrainingApplyCountryModel(jsonData: jsonData["country"])
        member          = TrainingApplyMemberModel(jsonData: jsonData["member"])
    }
}

struct TrainingApplyCountryModel {
    
    var id:String?
    var name:String?
    var en_name:String?
    
    init(jsonData: JSON) {
        id              = jsonData["id"].string
        name            = jsonData["name"].string
        en_name         = jsonData["en_name"].string
    }
}

struct TrainingApplyMemberModel {
    
    var fullname:String?
    var intl_code:String?
    var telephone:String?
    var wechat:String?
    var email:String?
    
    init(jsonData: JSON) {
        fullname        = jsonData["fullname"].string
        intl_code       = jsonData["intl_code"].string
        telephone       = jsonData["telephone"].string
        wechat          =  jsonData["wechat"].string
        email           = jsonData["email"].string
    }
}

// ==============================================================================================
// MARK: - 实训报名提交 /training/apply
// ==============================================================================================
struct SX_TrainingApplyConfirmModel {
    
    var number: String?
    
    init(jsonData: JSON) {
        number          = jsonData["number"].string
    }
}

// ==============================================================================================
// MARK: - 培训列表页面 /train/index
// ==============================================================================================
struct SX_TrainModel {
    
    var search: TrainSearchModel
    var lists:TrainListModel
    var type:TrainTypeModel
    var course:TrainCourseModel
    var sort:TrainSortModel
    
    init(jsonData: JSON) {
        search         = TrainSearchModel(jsonData: jsonData["search"])
        lists          = TrainListModel(jsonData: jsonData["lists"])
        type           = TrainTypeModel(jsonData: jsonData["type"])
        course         = TrainCourseModel(jsonData: jsonData["course"])
        sort           = TrainSortModel(jsonData: jsonData["sort"])
    }
}

struct TrainSearchModel {
    
    var type:String?
    var course:String?
    var sort:String?
    var order:String?
    
    init(jsonData: JSON) {
        type           = jsonData["type"].string
        course         = jsonData["course"].string
        sort           = jsonData["sort"].string
        order          = jsonData["order"].string
    }
}

struct TrainListModel {
    
    var id: String?
    var name:String?
    var series_name:String?
    var category_name:String?
    var image:String?
    var price:String?
    
    init(jsonData: JSON) {
        id             = jsonData["id"].string
        name           = jsonData["title"].string
        series_name    = jsonData["series_name"].string
        category_name  = jsonData["category_name"].string
        image          = jsonData["image"].string
        price          = jsonData["price"].string
    }
}

struct TrainTypeModel {
    var id: String?
    var name:String?
    
    init(jsonData: JSON) {
        id             = jsonData["id"].string
        name           = jsonData["name"].string
    }
}

struct TrainCourseModel {
    
    var id: String?
    var name:String?
    
    init(jsonData: JSON) {
        id             = jsonData["id"].string
        name           = jsonData["name"].string
    }
}

struct TrainSortModel {
    
    var name:String?
    var sort:String?
    var order:String?
    
    init(jsonData: JSON) {
        name           = jsonData["name"].string
        sort           = jsonData["sort"].string
        order          = jsonData["order"].string
    }
}


// ==============================================================================================
// MARK: - 培训详情页 /train/view/id/培训id
// ==============================================================================================
struct SX_TrainDetailModel {
    
    
    
    
}


// ==============================================================================================
// MARK: - 职位列表页 /job/index
// ==============================================================================================

struct SX_JobModel {
    
    var search: JobSearchModel
    var lists:JobListModel
    var type:JobTypeModel
    var nature:JobNatureModel
    var duration:JobDurationModel
    var setter:JobSetterModel
    
    init(jsonData: JSON) {
        search         = JobSearchModel(jsonData: jsonData["search"])
        lists          = JobListModel(jsonData: jsonData["lists"])
        type           = JobTypeModel(jsonData: jsonData["type"])
        nature         = JobNatureModel(jsonData: jsonData["nature"])
        duration       = JobDurationModel(jsonData: ["duration"])
        setter         = JobSetterModel(jsonData: jsonData["setter"])
    }
}

struct JobSearchModel {
    
    var type:String?
    var nature:String?
    var duration:String?
    var setter:String?
    
    init(jsonData: JSON) {
        type           = jsonData["type"].string
        nature         = jsonData["nature"].string
        duration       = jsonData["duration"].string
        setter         = jsonData["setter"].string
    }
}

struct JobListModel {
    
    var id: String?
    var title:String?
    var address:String?
    var duration:String?
    var nature:String?
    var time:String?
    
    init(jsonData: JSON) {
        id             = jsonData["id"].string
        title          = jsonData["title"].string
        address        = jsonData["address"].string
        duration       = jsonData["duration"].string
        nature         = jsonData["nature"].string
        time           = jsonData["time"].string
    }
}

struct JobTypeModel {
    var id: String?
    var name:String?
    
    init(jsonData: JSON) {
        id             = jsonData["id"].string
        name           = jsonData["name"].string
    }
}

struct JobNatureModel {
    
    var id: String?
    var name:String?
    
    init(jsonData: JSON) {
        id             = jsonData["id"].string
        name           = jsonData["name"].string
    }
}

struct JobDurationModel {
    
    var id: String?
    var name:String?
    
    init(jsonData: JSON) {
        id             = jsonData["id"].string
        name           = jsonData["name"].string
    }
}

struct JobSetterModel {
    
    var id: String?
    var name:String?
    
    init(jsonData: JSON) {
        id             = jsonData["id"].string
        name           = jsonData["name"].string
    }
}


// ==============================================================================================
// MARK: - 职位详情页 /job/view/id/职位id
// ==============================================================================================
struct SX_JobDetailModel {
    
    var id: String?
    var title:String?
    var time:String?
    var trade_name:String?
    var address:String?
    var amount:String?
    var duration_id:String?  // 1.兼职 2.全职
    var duration_name:String?
    var nature_id:String?    // 1.兼职 2.全职
    var nature_name:String?
    var wages:String?
    var duty:String?
    var requirement:String?
    var collection:String?
    var apply:String?
    var collection_type:String?
    
    init(jsonData: JSON) {
        id              = jsonData["id"].string
        title           = jsonData["title"].string
        time            = jsonData["time"].string
        trade_name      = jsonData["trade_name"].string
        address         = jsonData["address"].string
        amount          = jsonData["amount"].string
        duration_id     = jsonData["duration_id"].string
        duration_name   = jsonData["duration_name"].string
        nature_id       = jsonData["nature_id"].string
        nature_name     = jsonData["nature_name"].string
        wages           = jsonData["wages"].string
        duty            = jsonData["duty"].string
        requirement     = jsonData["requirement"].string
        collection      = jsonData["collection"].string
        apply           = jsonData["apply"].string
        collection_type = jsonData["collection_type"].string
    }
}

// =======================================================================================
// MARK: - 海外就业报名页 /job/apply
// =======================================================================================
struct SX_OverseaApplyModel {
    
    var uid:String?
    var job:String?
    var title:String?
    var member:OverseaMemberModel
    
    init(jsonData: JSON) {
        uid             = jsonData["uid"].string
        job             = jsonData["job"].string
        title           = jsonData["title"].string
        member          = OverseaMemberModel(jsonData: jsonData["member"])
    }
}

struct OverseaMemberModel {
    
    var intl_code:String?
    var telephone:String?
    var wechat:String?
    
    init(jsonData: JSON) {
        intl_code       = jsonData["intl_code"].string
        telephone       = jsonData["telephone"].string
        wechat          = jsonData["wechat"].string
    }
}

struct OverseaApplyCommit {
    
    var number:String?
    
    init(jsonData: JSON) {
        number          = jsonData["number"].string
    }
}

// ===================================================================++++++++++++++++++++++++++++
// MARK: - 会员中心 ! ! !
// ===================================================================++++++++++++++++++++++++++++
struct VIPCenterModel {
    
    var job:VIPCenterJobModel
    var training:VIPCenterTrainingModel
    var train:VIPCenterTrainModel
    
    init(jsonData: JSON) {
        job             = VIPCenterJobModel(jsonData: jsonData["job"])
        training        = VIPCenterTrainingModel(jsonData: jsonData["training"])
        train           = VIPCenterTrainModel(jsonData: jsonData["train"])
    }
}

struct VIPCenterJobModel {
    
    var id:String?
    var title:String?
    var trade_name:String?
    var address:String?
    var duration_id:String?
    var duration_name:String?
    
    init(jsonData: JSON) {
        id              = jsonData["id"].string
        title           = jsonData["title"].string
        trade_name      = jsonData["trade_name"].string
        address         = jsonData["address"].string
        duration_id     = jsonData["duration_id"].string
        duration_name   = jsonData["duration_name"].string
    }
}

struct VIPCenterTrainingModel {
    
    var id:String?
    var title:String?
    var outset_city:String?
    var count:String?
    
    init(jsonData: JSON) {
        id              = jsonData["id"].string
        title           = jsonData["title"].string
        outset_city     = jsonData["outset_city"].string
        count           = jsonData["count"].string
    }
}

struct VIPCenterTrainModel {
    
    var id:String?
    var title:String?
    var time:String?
    
    init(jsonData: JSON) {
        id              = jsonData["id"].string
        title           = jsonData["title"].string
        time            = jsonData["time"].string
    }
}

// =======================================================================================
// MARK: -  我的界面 - 我的收藏
// =======================================================================================
struct SX_MyCollectionJobModel {
    
    var lists: JobCollectionListModel
    
    init(jsonData: JSON) {
        lists = JobCollectionListModel(jsonData: jsonData["lists"])
    }
}

struct JobCollectionListModel {
    
    var id:String?
    var title:String?
    var trade_name:String?
    var address:String?
    var duration_id:String?
    var duration_name:String?
    
    init(jsonData:JSON) {
        id              = jsonData["id"].string
        title           = jsonData["title"].string
        trade_name      = jsonData["trade_name"].string
        address         = jsonData["address"].string
        duration_id     = jsonData["duration_id"].string
        duration_name   = jsonData["duration_name"].string
    }
}

struct SX_MyCollectionTrainModel {
    
    var lists: TrainCollectionListModel
    
    init(jsonData: JSON) {
        lists = TrainCollectionListModel(jsonData: jsonData["lists"])
    }
}

struct TrainCollectionListModel {
    
    var id:String?
    var title:String?
    var outset_city:String?
    var count:String?
    
    init(jsonData:JSON) {
        id              = jsonData["id"].string
        title           = jsonData["title"].string
        outset_city     = jsonData["outset_city"].string
        count           = jsonData["count"].string
    }
}

struct SX_MyCollectionTrainingModel {
    
    var lists: TrainingCollectionListModel
    
    init(jsonData: JSON) {
        lists = TrainingCollectionListModel(jsonData: jsonData["lists"])
    }
}

struct TrainingCollectionListModel {
    
    var id:String?
    var title:String?
    var time:String?
    
    init(jsonData:JSON) {
        id              = jsonData["id"].string
        title           = jsonData["title"].string
        time            = jsonData["time"].string
    }
}
