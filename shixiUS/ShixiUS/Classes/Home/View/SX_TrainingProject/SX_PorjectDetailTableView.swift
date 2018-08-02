//
//  SX_PorjectDetailTableView.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/2/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  项目详情TableView

import UIKit

private let kScrollStopNotificationName = "scrollStop" // 滚动停止通知

protocol  SX_ProjectDetailTableViewDelegate {
    // 悬停的位置
    func tableViewHeightForStayPosition(tableView: UITableView) -> CGFloat
}

enum SX_PorjectDetailTableViewType {
    case Main
    case Sub
}

class SX_PorjectDetailTableView: UITableView {
    
    var canScroll: Bool?
    var delegate_StayPosition: SX_ProjectDetailTableViewDelegate?
    
    var type: SX_PorjectDetailTableViewType? {
        didSet{
            self.canScroll = self.type == .Sub ? false:true
        }
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        NotificationCenter.default.addObserver(self, selector: #selector(scrollTop), name: NSNotification.Name(rawValue: kScrollStopNotificationName), object: nil)
        self.canScroll = false
        self.showsVerticalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NotificationCenter.default.addObserver(self, selector: #selector(scrollTop), name: NSNotification.Name(rawValue: kScrollStopNotificationName), object: nil)
        self.canScroll = false
        self.showsVerticalScrollIndicator = false
    }
    
    override func setContentOffset(_ contentOffset: CGPoint, animated: Bool) {
        super.setContentOffset(contentOffset, animated: animated)
        SXLog("+++++++++++++++++++++++++++++")
        
        let y = contentOffset.y
        if self.type == .Main {  //main类型
            var stayPosition = CGFloat(self.tableHeaderView!.frame.height) // 默认停留的位置
            stayPosition = self.delegate_StayPosition!.tableViewHeightForStayPosition(tableView: self) // 获取到停留的位置
            if self.canScroll == true {
                if y > stayPosition {
                    contentOffset.y == stayPosition
                    super.setContentOffset(contentOffset, animated: true)
                    self.canScroll = false
                    // 发送通知，主类不可滚动
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: kScrollStopNotificationName), object: self, userInfo: nil)
                } else { // Main正常滚动
                    super.setContentOffset(contentOffset, animated: true)
                }
            } else { // Main 禁止滚动
                contentOffset.y == stayPosition
                super.setContentOffset(contentOffset, animated: true)
            }
        } else if self.type == .Sub { // sub类型
            if self.canScroll == true {
                if y < 0 {
                    contentOffset.y == 0
                    super.setContentOffset(contentOffset, animated: true)
                    self.canScroll = false
                    // 发送通知，子类不可滚动
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: kScrollStopNotificationName), object: self, userInfo: nil)
                } else { // sub正常滚动
                    super.setContentOffset(contentOffset, animated: true)
                }
            } else { // sub 禁止滚动
                contentOffset.y == 0
                super.setContentOffset(contentOffset, animated: true)
            }
        } else {
            super.setContentOffset(contentOffset, animated: true)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// ===============================================================================================================================
// MARK: - SX_ProjectDetailTableViewDelegate
// ===============================================================================================================================
extension SX_PorjectDetailTableView: SX_ProjectDetailTableViewDelegate {
    
    func tableViewHeightForStayPosition(tableView: UITableView) -> CGFloat {
        
        return 100.FloatValue
    }
}

// ===============================================================================================================================
// MARK: - Noti & UIGestureRecognizerDelegate
// ===============================================================================================================================
extension SX_PorjectDetailTableView: UIGestureRecognizerDelegate {
    
    @objc func scrollTop(notification: Notification) {
        SXLog("收到滚动停止通知")
        let table = notification.object as! SX_PorjectDetailTableView
        if self != table {
            self.canScroll = true // 发送通知的table和当前self不是同一个时，则需要滚动
        }
        // 把其他所有的sub都移动到顶部,除去主的，其他table皆不能滚动
        if table.type == .Sub {
            self.setContentOffset(CGPoint.zero, animated: true)
            self.canScroll = false
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.type == .Main {
            return true
        }
        return false
    }
}

