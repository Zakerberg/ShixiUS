//
//  SX_PageTitleView.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/3.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  所有的分段选择 Menu (我的申请, 我的收藏...)

/*
 我爱你
 在我身上投下的时间与汗水
 我都记在心里
 刚好此生别无他求
 只想永生相伴
 慢慢还你
 */

protocol SXPageTitleViewDelegate: NSObjectProtocol {
    func selectedIndexInPageTitleView(pageTitleView: SX_PageTitleView, selectedIndex: Int)
}

import UIKit

class SX_PageTitleView: UIView {
    
    var config: SX_PageTitleViewConfig?
    
    //选中标题按钮下标，默认为 0
    var selectedIndex: Int = 0 {
        didSet {
            self.btnDidClick(sender: btnArr[selectedIndex])
        }
    }
    
    //scrollView
    private lazy var scrollView: UIScrollView = {
        let scrollV = UIScrollView(frame: self.bounds)
        scrollV.showsHorizontalScrollIndicator = false
        return scrollV
    }()
    
    //底部分隔线
    private lazy var line: UIView = {
        let lineV = UIView(frame: CGRect(x: 0, y: self.height-1, width: self.width, height: 1))
        lineV.backgroundColor = UIColor.colorWithRGB(r: 244, g: 244, b: 244)
        return lineV
    }()
    
    //指示器
    private lazy var indicatorView: UIView = {
        let indicatorView = UIView(frame: CGRect(x: 0, y: scrollView.height-3, width: 0, height: 2))
        indicatorView.backgroundColor = self.config?.indicatorColor
        return indicatorView
    }()
    
    //标题数组
    var titles = [String]()
    //存储标题按钮的数组
    private var btnArr = [UIButton]()
    //标记按钮下标
    private var signBtnIndex: Int = 0
    //按钮的总宽度
    private var allBtnWidth: CGFloat = 0
    private var lastBtn: UIButton?
    private var totalExtraWidth: CGFloat = 0
    
    weak var pageTitleViewDelegate: SXPageTitleViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, titles: [String], config: SX_PageTitleViewConfig) {
        self.init()
        self.backgroundColor = UIColor.white
        self.frame = frame
        if titles.count < 1 {
            NSException(name: NSExceptionName(rawValue: "SXPagingView"), reason: "标题数组元素不能为0", userInfo: nil).raise()
        }
        self.titles = titles
        self.config = config
        setupUI()
    }
    
    deinit {
        print("deinit")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //选中按钮下标初始值
        let lastBtn: UIButton = self.btnArr.last!
        if lastBtn.tag >= selectedIndex && selectedIndex >= 0 {
            btnDidClick(sender: self.btnArr[selectedIndex])
        }else {
            return
        }
    }
}

// ==============================================================
// MARK: - Private func
// ==============================================================
extension SX_PageTitleView {
    private func setupUI() {
        //处理偏移量
        let tempView = UIView(frame: CGRect.zero)
        self.addSubview(tempView)
        self.addSubview(scrollView)
        if let showBottomSeparator = self.config?.showBottomSeparator {
            if showBottomSeparator {
                self.addSubview(line)
            }
        }
        scrollView.insertSubview(indicatorView, at: 0)
        setupButtons()
    }
    
    private func setupButtons() {
        var totalTextWidth: CGFloat = 0
        
        for title in self.titles {
            // 计算所有按钮的文字宽度
            if let titleFont = self.config?.titleFont {
                let tempWidth = title.SX_widthWithString(font: titleFont, size: CGSize(width: 0, height: 0))
                totalTextWidth += tempWidth
            }
        }
        
        // 所有按钮文字宽度 ＋ 按钮之间的间隔
        self.allBtnWidth = (self.config?.spacingBetweenButtons)! * (CGFloat)(self.titles.count + 1) + totalTextWidth
        
        let count: CGFloat = CGFloat(self.titles.count)
        if self.allBtnWidth <= self.bounds.width {
            var btnX: CGFloat = 0
            let btnY: CGFloat = 0
            let btnH: CGFloat = self.bounds.height
            
            for (index, title) in self.titles.enumerated() {
                var btnW: CGFloat = self.bounds.width / count
                let tempWidth = title.SX_widthWithString(font: (self.config?.titleFont)!, size: CGSize(width: 0, height: 0)) + (self.config?.spacingBetweenButtons)!
                if tempWidth > btnW {
                    let extraWidth = tempWidth - btnW
                    btnW = tempWidth
                    totalExtraWidth += extraWidth
                }
                
                let btn = UIButton(type: .custom)
                btn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
                btnX += btnW
                btn.tag = index
                btn.setTitle(title, for: .normal)
                btn.setTitleColor(self.config?.titleColor, for: .normal)
                btn.setTitleColor(self.config?.titleSelectedColor, for: .selected)
                btn.titleLabel?.font = self.config?.titleFont
                btn.addTarget(self, action: #selector(btnDidClick(sender:)), for: .touchUpInside)
                scrollView.addSubview(btn)
                btnArr.append(btn)
            }
            
            scrollView.contentSize = CGSize(width: self.bounds.width + totalExtraWidth, height: 0)
        }else {
            var btnX: CGFloat = 0
            let btnY: CGFloat = 0
            let btnH: CGFloat = self.bounds.height
            
            for (index, title) in self.titles.enumerated() {
                let btnW = title.SX_widthWithString(font: (self.config?.titleFont)!, size: CGSize(width: 0, height: 0)) + (self.config?.spacingBetweenButtons)!
                let btn = UIButton(type: .custom)
                btn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
                btnX += btnW
                btn.tag = index
                btn.setTitle(title, for: .normal)
                btn.setTitleColor(self.config?.titleColor, for: .normal)
                btn.setTitleColor(self.config?.titleSelectedColor, for: .selected)
                btn.titleLabel?.font = self.config?.titleFont
                btn.addTarget(self, action: #selector(btnDidClick(sender:)), for: .touchUpInside)
                scrollView.addSubview(btn)
                btnArr.append(btn)
            }
            let scrollViewWidth = scrollView.subviews.last?.frame.maxX
            scrollView.contentSize = CGSize(width: scrollViewWidth!, height: 0)
        }
    }
    
    //滚动标题选中按钮居中
    private func scrollCenter(selectedBtn: UIButton) {
        var offsetX = selectedBtn.centerX - self.width * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        let maxOffsetX = scrollView.contentSize.width - self.width
        if offsetX > maxOffsetX {
            offsetX = maxOffsetX
        }
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    //改变按钮的选择状态
    private func changeSelectedButton(button: UIButton) {
        if self.lastBtn == nil {
            button.isSelected = true
            self.lastBtn = button
        } else if self.lastBtn != nil && self.lastBtn == button {
            button.isSelected = true
        } else if self.lastBtn != button && self.lastBtn != nil {
            self.lastBtn?.isSelected = false
            button.isSelected = true
            self.lastBtn = button
        }
    }
}

// ==============================================================
// MARK: - @objc
// ==============================================================
extension SX_PageTitleView {
    @objc func btnDidClick(sender:UIButton) {
        self.changeSelectedButton(button: sender)
        scrollCenter(selectedBtn: sender)
        
        if self.allBtnWidth > self.width || totalExtraWidth > 0 {
            scrollCenter(selectedBtn: sender)
        }
        
        UIView.animate(withDuration: 0.1) {
            self.indicatorView.width = sender.currentTitle!.SX_widthWithString(font: (self.config?.titleFont)!, size: CGSize(width: 0, height: 0))
            self.indicatorView.center.x = sender.centerX
        }
        
        pageTitleViewDelegate?.selectedIndexInPageTitleView(pageTitleView: self, selectedIndex: sender.tag)
        self.signBtnIndex = sender.tag
    }
}

// ==============================================================
// MARK: - 给外界提供的方法
// ==============================================================
extension SX_PageTitleView {
    func setPageTitleView(progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        let originalBtn: UIButton = self.btnArr[originalIndex]
        let targetBtn: UIButton = self.btnArr[targetIndex]
        self.signBtnIndex = targetBtn.tag
        
        scrollCenter(selectedBtn: targetBtn)
        //处理指示器的逻辑
        if self.allBtnWidth <= self.bounds.width {
            if totalExtraWidth > 0 {
                indicatorScrollAtScroll(progress: progress, originalBtn: originalBtn, targetBtn: targetBtn)
            }else {
                indicatorScrollAtStatic(progress: progress, originalBtn: originalBtn, targetBtn: targetBtn)
            }
        }else {
            indicatorScrollAtScroll(progress: progress, originalBtn: originalBtn, targetBtn: targetBtn)
        }
    }
    
    private func indicatorScrollAtStatic(progress: CGFloat, originalBtn: UIButton, targetBtn: UIButton) {
        if (progress >= 0.8) {
            changeSelectedButton(button: targetBtn)
        }
        
        /// 计算 indicatorView 偏移量
        let targetBtnTextWidth: CGFloat = (targetBtn.currentTitle?.SX_widthWithString(font: (self.config?.titleFont)!, size: CGSize.zero))!
        let targetBtnIndicatorX: CGFloat = targetBtn.frame.maxX - targetBtnTextWidth - 0.5 * (self.width / CGFloat(self.titles.count) - targetBtnTextWidth)
        let originalBtnTextWidth: CGFloat = (originalBtn.currentTitle?.SX_widthWithString(font: (self.config?.titleFont)!, size: CGSize.zero))!
        let originalBtnIndicatorX: CGFloat = originalBtn.frame.maxX - originalBtnTextWidth - 0.5 * (self.width / CGFloat(self.titles.count) - originalBtnTextWidth)
        
        let totalOffsetX: CGFloat = targetBtnIndicatorX - originalBtnIndicatorX
        
        let btnWidth: CGFloat = self.width / CGFloat(self.titles.count)
        let targetBtnRightTextX: CGFloat = targetBtn.frame.maxX - 0.5 * (btnWidth - targetBtnTextWidth)
        let originalBtnRightTextX: CGFloat = originalBtn.frame.maxX - 0.5 * (btnWidth - originalBtnTextWidth)
        let totalRightTextDistance: CGFloat = targetBtnRightTextX - originalBtnRightTextX
        
        let offsetX: CGFloat = totalOffsetX * progress
        let distance: CGFloat = progress * (totalRightTextDistance - totalOffsetX)
        
        self.indicatorView.x = originalBtnIndicatorX + offsetX
        
        let tempIndicatorWidth: CGFloat = originalBtnTextWidth + distance
        if tempIndicatorWidth >= targetBtn.width {
            let moveTotalX: CGFloat = targetBtn.x - originalBtn.x
            let moveX: CGFloat = moveTotalX * progress
            self.indicatorView.center.x = originalBtn.centerX + moveX
        }else{
            self.indicatorView.width = tempIndicatorWidth
        }
    }
    
    private func indicatorScrollAtScroll(progress: CGFloat, originalBtn: UIButton, targetBtn: UIButton) {
        if (progress >= 0.8) {
            changeSelectedButton(button: targetBtn)
        }
        
        let totalOffsetX: CGFloat = targetBtn.x - originalBtn.x
        let totalDistance: CGFloat = targetBtn.frame.maxX - originalBtn.frame.maxX
        var offsetX: CGFloat = 0
        var distance: CGFloat = 0
        
        let targetBtnTextWidth: CGFloat = (targetBtn.currentTitle?.SX_widthWithString(font: (self.config?.titleFont)!, size: CGSize.zero))!
        let tempIndicatorWidth: CGFloat = targetBtnTextWidth
        
        if tempIndicatorWidth >= targetBtn.width {
            offsetX = totalOffsetX * progress
            distance = progress * totalDistance - totalOffsetX
            self.indicatorView.x = originalBtn.x + offsetX
            self.indicatorView.width = originalBtn.width + distance
        }else{
            offsetX = totalOffsetX * progress + 0.5 * (self.config?.spacingBetweenButtons)!
            distance = progress * (totalDistance - totalOffsetX) - (self.config?.spacingBetweenButtons)!
            self.indicatorView.x = originalBtn.x + offsetX;
            self.indicatorView.width = originalBtn.width + distance
        }
    }
}
