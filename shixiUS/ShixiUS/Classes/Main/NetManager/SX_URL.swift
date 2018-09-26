//
//  SX_URL.swift
//  ShixiUS
//
//  Created by Michael 柏 on 9/8/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

let SHIXIUS = "http://api.shixigroup.com"

/*
  注:
  1.返回值字段：status    状态
              msg       信息
              field     字段
              data      数据
 
 2.成功返回状态值为200，
   错误返回状态值为202，
   登录超时返回状态值为203
 */

// =======================================================================================
// MARK: - 登 陆 & 注 册
// =======================================================================================

/// 注册 (post)
let SX_Register              = SHIXIUS + "/signin/reghandle"
/// 登录 (post)
let SX_LogIn                 = SHIXIUS + "/signup/uphandle"
/// 退出登录 (get)
let SX_LogOut                = SHIXIUS + "/signup/signout"


// =======================================================================================
// MARK: - 首 页 ! ! !
// =======================================================================================

/// banner广告位 (get)
let SX_HomeAD                 = SHIXIUS + "/index/ad"
/// 首页 (post)
let SX_Home                   = SHIXIUS + "/index/index"

// =======================================================================================
// MARK: - 首 页 实训 培训 职位
// =======================================================================================

/// 实训列表页 (get)
let SX_TrainingList           = SHIXIUS + "/training/index"
/// 实训详情页 (get)
let SX_TrainingDetail         = SHIXIUS + "/training/view/id/" //此处后面还要加培训id
/// 实训报名页 (get)
let SX_TrainingApply          = SHIXIUS + "/training/apply"
/// 实训报名(确定) (post)
let SX_TrainingApplyConfirm   = SHIXIUS + "/training/apply"
/// 培训列表页 
let SX_TrainIndex             = SHIXIUS + "/train/index"
/// 职位列表页 (get)
let SX_JobIndex               = SHIXIUS + "/job/index"
/// 职位详情界面 (get)
let SX_JobDetail              = SHIXIUS + "/job/view/id" //此处后面还要加培训id
/// 海外就业报名页 (get)
let SX_Oversea_Apply          = SHIXIUS + "/job/apply"
/// 海外就业报名页 (post)
let SX_Oversea_Apply_Confirm  = SHIXIUS + "/job/apply"

// =======================================================================================
// MARK: - 会员中心 ! ! !
// =======================================================================================
/// 我的收藏 (get)
let SX_VIPCenter_MyCollection = SHIXIUS + "/mycollection/index"
/// 添加我的收藏 (get)
let SX_VIPCenter_Add          = SHIXIUS + "/mycollection/add"

// =======================================================================================
// MARK: - 我的 ! ! !
// =======================================================================================
/// 上传图片 (post)
let SX_Mine_UploadImage       = SHIXIUS + "/common/uploadimage"

