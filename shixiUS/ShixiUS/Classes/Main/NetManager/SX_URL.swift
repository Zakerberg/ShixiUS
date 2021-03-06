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
let SX_Register               = SHIXIUS + "/signin/reghandle"
/// 登录 (post)
let SX_LogIn                  = SHIXIUS + "/signup/uphandle"
/// 退出登录 (get)
let SX_LogOut                 = SHIXIUS + "/signup/signout"


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
let SX_TrainingDetail         = SHIXIUS + "/training/view/id/" //此处后面还要加实训id

/// 实训报名页
let SX_TrainingApply          = SHIXIUS + "/training/apply"

/// 培训列表页 
let SX_TrainIndex             = SHIXIUS + "/train/index"

/// 培训详情页
let SX_TrainDetail            = SHIXIUS + "/train/view/id/" //此处后面还要加培训id

/// 培训报名提交
let SX_TrainApply             = SHIXIUS + "/train/apply"

/// 职位列表页 (get)
let SX_JobIndex               = SHIXIUS + "/job/index"

/// 职位详情界面 (get)
let SX_JobDetail              = SHIXIUS + "/job/view/id/" //此处后面还要加职位id

/// 海外就业报名页 (get)
let SX_JobApply               = SHIXIUS + "/job/apply"

// =======================================================================================
// MARK: - 我的申请 ! ! !
// =======================================================================================
/// 我的申请 ----> (就业岗位) (get)
let SX_MyApplyJob             = SHIXIUS + "/myapply/job?"

/// 我的申请 ----> (职业培训) (get)
let SX_MyApplyTrain           = SHIXIUS + "/myapply/train?"

/// 我的申请 ----> (实训项目) (get)
let SX_MyApplyTraining        = SHIXIUS + "/myapply/training?"

/// 申请详情(就业岗位) (get)
let SX_ApplyJobDetail         = SHIXIUS + "/myapply/jobdetail?"

/// 申请详情(实训项目) (get)
let SX_ApplyTraininigDetail   = SHIXIUS + "/myapply/trainingdetail?"

/// 申请详情(职业培训) (get)
let SX_ApplyTrainDetail       = SHIXIUS + "/myapply/traindetail?"

/// 取消申请 (get)
let SX_ApplyCancel            = SHIXIUS + "/myapply/cancel"

/// 申请退款 (get)
let SX_ApplyRefund            = SHIXIUS + "/myapply/refundmoney?"

// 取消退款 (get)
let SX_ApplyRefundCancel      = SHIXIUS + "/myapply/cancelrefund"

/// 实训 申请进度 详情
let SX_Apply_TrainingProgress = SHIXIUS + "/myapply/trainingprocess?"

/// 培训 申请进度 详情
let SX_Apply_TrainProgress    = SHIXIUS + "/myapply/trainprocess?"

/// 就业岗位 申请进度 详情
let SX_Apply_JobProgress      = SHIXIUS + "/myapply/jobprocess?"

// =======================================================================================
// MARK: - 我的 ! ! !
// =======================================================================================

/// 我的收藏 (get)
let SX_VIPCenter_MyCollection = SHIXIUS + "/mycollection/index?"

/// 添加我的收藏 (get)
let SX_VIPCenter_Add          = SHIXIUS + "/mycollection/add?"

/// 上传图片 (post)
let SX_Mine_UploadImage       = SHIXIUS + "/common/uploadimage"

/// 上传文件 (post)
let SX_Mine_UploadFile        = SHIXIUS + "/common/upload"

/// 修改个人信息 (post)
let SX_Mine_FixInfo           = SHIXIUS + "/member/info"

// 付款记录 (get)
let SX_Mine_OrderRecord       = SHIXIUS + "/myorder/index?"

// 修改密码
let SX_Mine_FixPassword       = SHIXIUS + "/member/uppassword"

// 获取个人信息 (post)
let SX_Mine_GetInfo           = SHIXIUS + "/member/getinfo"

// 退出登录(post)
let SX_Mine_SignOut           = SHIXIUS + "/signup/signout"
