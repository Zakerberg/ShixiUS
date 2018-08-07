//
//  SX_MineApplyScrollView.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/7/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

class SX_MineApplyScrollView: UIView {
    
    typealias scrollToCurrentView = ((_ view: UIView)-> Void)
    typealias endScrollIndex = ((_ index: NSInteger)-> Void)
    typealias listScrollViewDidScroll = ((_ scrollView: UIScrollView)-> Void)
    
    var scrollView: UIScrollView?
    var listViewArray: NSMutableArray?
    var scrollToCurrentView: scrollToCurrentView?
    var endScrollIndex: endScrollIndex?
    var listScrollViewDidScroll: listScrollViewDidScroll?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        listViewArray = NSMutableArray()
        self.clipsToBounds = true
        creatTheScrollView()
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// ===============================================================================================================================
// MARK: - Other Method
// ===============================================================================================================================
extension SX_MineApplyScrollView {
    
    func creatTheScrollView() {
        scrollView = UIScrollView().addhere(toSuperView: self).layout(snapKitMaker: { (make) in
            make.edges.equalToSuperview()
        }).config({ (scrollView) in
            scrollView.delegate = self
            scrollView.isPagingEnabled = true
            scrollView.contentSize = CGSize(width: SCREEN_WIDTH*3, height: SCREEN_HEIGHT)
        })
    }
    
    // 停止滚动
    func endScroll() {
        let currentPageIndex = Int(scrollView!.contentOffset.x / scrollView!.frame.size.width + 1)
        if listViewArray!.count > currentPageIndex - 1 {
            let currentView = listViewArray![currentPageIndex - 1] as? UIView
            if self.scrollToCurrentView != nil {
                self.scrollToCurrentView?(currentView!)
            }
            if self.endScrollIndex != nil {
                self.endScrollIndex?(currentPageIndex)
            } else {
                SXLog("数组越界+++")
            }
        }
    }
    
    /// 滑动到对应的列表?
    func scrollToListWithIndex(index: NSInteger) {
        SXLog("index-----\(index)")
        let offset = CGPoint(x: self.frame.size.width * CGFloat(index), y: 0)
        UIView.animate(withDuration: 0.25) {
            self.scrollView?.contentOffset = offset
        }
        endScroll()
    }
    
    func addListView(listView: UIView) {
        
        // 数组 记录 列表的View
        listViewArray?.add(listView)
        SXLog("listViewArray ----------\(String(describing: listViewArray?.count))")
        // 重新设置Frame
        listView.frame = CGRect(x: Int(self.frame.size.width) * (listViewArray!.count - 1), y: 0, width: Int(self.frame.size.width), height: Int(self.frame.size.height))
        
        // 滑动View 添加 列表View
        scrollView?.addSubview(listView)
        // 显示范围
        scrollView?.contentSize = CGSize(width: listViewArray!.count.FloatValue * scrollView!.frame.size.width, height: scrollView!.frame.size.height)
    }
}


// ===============================================================================================================================
// MARK: - UIScrollViewDelegate
// ===============================================================================================================================
extension SX_MineApplyScrollView: UIScrollViewDelegate {
    
    
    
    
    
    
    
}



