//
//  SX_PageContentView.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/3.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

/*
 我爱你，
 除非黄土枯骨，
 我愿守你百岁无忧。
 */

protocol SXPageContentViewDelegate: NSObjectProtocol {
    func pageContentViewScroll(progress: CGFloat, originalIndex: Int, targetIndex: Int)
}

import UIKit

class SX_PageContentView: UIView {
    
    weak var pageContentViewDelegate: SXPageContentViewDelegate?
    // 外界父控制器
    weak private var parentViewController: UIViewController?
    // 存储子控制器
    private var childViewControllers  = [UIViewController]()
    //记录加载的上一个控制器
    private var lastVC: UIViewController?
    //记录刚开始时的偏移量
    private var startOffsetX: CGFloat = 0
    //scrollView
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        
        scrollView.delegate                       = self
        scrollView.bounces                        = false
        scrollView.isPagingEnabled                = true
        scrollView.showsVerticalScrollIndicator   = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: CGFloat(self.childViewControllers.count) * self.width, height: 0)
        
        return scrollView
    }()
    
    convenience init(frame: CGRect, parentVC: UIViewController, childVCs: Array<UIViewController>) {
        self.init(frame: frame)
        self.parentViewController = parentVC
        self.childViewControllers = childVCs
        
        setupSubViews()
    }
    
    private func setupSubViews() {
        //处理偏移量
        let tempView = UIView(frame: CGRect.zero)
        self.addSubview(tempView)
        self.addSubview(scrollView)
    }
}

// ========================================================================
// MARK: - Other Method
// ========================================================================
extension SX_PageContentView {
    
    //给外界用以获取PageTitleView选中按钮的下标
    func setPageContentViewCurrentIndex(currentIndex: NSInteger) {
        if self.lastVC != nil {
            self.lastVC?.beginAppearanceTransition(false, animated: false)
            self.lastVC?.endAppearanceTransition()
        }
        
        let offsetX: CGFloat = CGFloat(currentIndex) * self.width
        
        //添加子控制器以及子控制器的 view
        let childVC: UIViewController = self.childViewControllers[currentIndex]
        self.parentViewController?.addChildViewController(childVC)
        childVC.beginAppearanceTransition(true, animated: false)
        self.scrollView.addSubview(childVC.view)
        childVC.endAppearanceTransition()
        childVC.view.frame = CGRect(x: offsetX, y: 0, width: self.width, height: self.height)
        
        //记录上个展示的子控制器
        self.lastVC = childVC
        
        //处理内容偏移
        self.scrollView.contentOffset = CGPoint(x: offsetX, y: 0)
    }
}

// ========================================================================
// MARK: - UIScrollViewDelegate
// ========================================================================
extension SX_PageContentView: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.lastVC != nil {
            self.lastVC?.beginAppearanceTransition(false, animated: false)
            self.lastVC?.endAppearanceTransition()
        }
        
        let offsetX: CGFloat = scrollView.contentOffset.x
        let index: Int = Int(offsetX / scrollView.frame.size.width)
        let childVC: UIViewController = self.childViewControllers[index]
        self.parentViewController?.addChildViewController(childVC)
        childVC.beginAppearanceTransition(true, animated: false)
        self.scrollView.addSubview(childVC.view)
        childVC.endAppearanceTransition()
        //记录上个展示的子控制器
        self.lastVC = childVC
        childVC.view.frame = CGRect(x: offsetX, y: 0, width: self.width, height: self.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var progress: CGFloat  = 0
        var originalIndex: Int = 0
        var targetIndex: Int   = 0
        //判断是左滑还是右滑
        let currentOffsetX: CGFloat = scrollView.contentOffset.x
        let scrollViewW: CGFloat = scrollView.width
        if currentOffsetX > self.startOffsetX { // 左滑
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            originalIndex = Int(currentOffsetX / scrollViewW)
            targetIndex = originalIndex + 1
            if targetIndex >= self.childViewControllers.count {
                progress = 1
                targetIndex = self.childViewControllers.count - 1
            }
            //如果完全划过去
            if currentOffsetX - self.startOffsetX == scrollViewW {
                progress = 1
                targetIndex = originalIndex
            }
        } else { // 右滑
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            targetIndex = Int(currentOffsetX / scrollViewW)
            originalIndex = targetIndex + 1
            if originalIndex >= self.childViewControllers.count {
                originalIndex = self.childViewControllers.count - 1
            }
        }
        pageContentViewDelegate?.pageContentViewScroll(progress: progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}

