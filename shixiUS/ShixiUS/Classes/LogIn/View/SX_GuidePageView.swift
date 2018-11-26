//
//  SX_GuidePageView.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/8/31.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

/*
 我爱你
 我不想做你的英雄
 因为英雄
 善始
 不善终
 */

import UIKit

public class SX_GuidePageView: UIView {
    
    private var imageArray: Array<String>?
    private var isHiddenSkipBtn: Bool  = false           // 是否隐藏跳过按钮(true 隐藏; false 不隐藏)，default: false
    private var isHiddenStartBtn: Bool = false          // 是否隐藏立即体验按钮(true 隐藏; false 不隐藏)，default: false
    private lazy var guideScrollView: UIScrollView = {
        let view = UIScrollView.init()
        view.backgroundColor = UIColor.lightGray
        view.bounces         = false
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.delegate        = self
        return view
    }()
    
    var skipButton: UIButton?
    // 立即申请
    var startButton: UIButton?
    var startCompletion: (() -> ())?
    var loginCompletion: (() -> ())?
    let pageControlHeight: CGFloat = 40.0
    let startHeigth: CGFloat       = 30.0
    let loginHeight: CGFloat       = 40.0
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /****
     App启动引导页
     */
    public convenience init(frame: CGRect = UIScreen.main.bounds,
                            images: Array<String>,
                            isHiddenSkipBtn: Bool = false,
                            isHiddenStartBtn: Bool = false,
                            loginRegistCompletion: (() -> ())?,
                            startCompletion: (() -> ())?) {
        self.init(frame: frame)
        
        self.imageArray       = images
        self.isHiddenSkipBtn  = isHiddenSkipBtn
        self.isHiddenStartBtn = isHiddenStartBtn
        self.startCompletion  = startCompletion
        self.loginCompletion  = loginRegistCompletion
        
        setupSubviews(frame: frame)
        self.backgroundColor  = UIColor.lightGray
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup
    private func setupSubviews(frame: CGRect) {
        
        let size = UIScreen.main.bounds.size
        guideScrollView.frame       = frame
        guideScrollView.contentSize = CGSize.init(width: frame.size.width * CGFloat(imageArray?.count ?? 0), height: frame.size.height)
        self.addSubview(guideScrollView)
        
        self.skipButton = UIButton(type: .custom).addhere(toSuperView: self).layout(snapKitMaker: { (make) in
            make.top.equalToSuperview().offset(40.FloatValue.IPAD_XValue)
            make.right.equalToSuperview().offset(Margin)
            make.width.equalTo(50.FloatValue.IPAD_XValue)
            make.height.equalTo(24.FloatValue.IPAD_XValue)
        }).config({ (SKIP) in
            SKIP.backgroundColor     = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
            SKIP.layer.cornerRadius  = 5.0
            SKIP.layer.masksToBounds = true
            SKIP.setTitle("跳 过", for: .normal)
            SKIP.titleLabel?.font    = UIFont.systemFont(ofSize: 12)
            SKIP.setTitleColor(UIColor.white, for: .normal)
            SKIP.titleLabel?.sizeToFit()
            SKIP.addTarget(self, action: #selector(skipBtnClicked), for: .touchUpInside)
            SKIP.isHidden = isHiddenSkipBtn
        })
        
        guard imageArray.isSome, imageArray?.count ?? 0 > 0 else { return }
        for index in 0..<(imageArray?.count ?? 1) {
            let name        = imageArray![index]
            let imageFrame  = CGRect.init(x: size.width * CGFloat(index), y: 0.0, width: size.width, height: size.height)
            let filePath    = Bundle.main.path(forResource: name, ofType: nil) ?? ""
            let data: Data? = try? Data.init(contentsOf: URL.init(fileURLWithPath: filePath), options: Data.ReadingOptions.uncached)
            var view: UIView
            let type = SX_GifImageOperation.checkDataType(data: data)
            if type  == DataType.gif {   // gif
                view = SX_GifImageOperation.init(frame: imageFrame, gifData: data!)
            } else { // 其它图片
                // Warning: 假如说图片是放在Assets中的，使用Bundle的方式加载不到，需要使用init(named:)方法加载。
                view = UIImageView.init(frame: imageFrame)
                view.contentMode = .scaleAspectFill
                (view as! UIImageView).image = (data.isSome ? UIImage.init(data: data!) : UIImage.init(named: name))
            }
            
            guideScrollView.addSubview(view)
        }
    }
    
    // MARK: - actions
    private func removeGuideViewFromSupview() {
        UIView.animate(withDuration: 1.0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    /// 点击“跳过”按钮事件，立即退出引导页
    @objc private func skipBtnClicked() {
        if self.startCompletion.isSome {
            self.startCompletion!()
        }
        self.removeGuideViewFromSupview()
    }
    
    /// 点击“立即体验”按钮事件，退出引导页
    @objc private func startBtnClicked() {
        if self.startCompletion.isSome {
            self.startCompletion!()
        }
        self.removeGuideViewFromSupview()
    }
}
// =========================================================
// MARK: - UIScrollViewDelegate
// =========================================================
extension SX_GuidePageView: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page: Int = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        // 显示“立即体验”按钮
        if !isHiddenStartBtn, (imageArray?.count ?? 0) - 1 == page {
            UIView.animate(withDuration: 1.0, animations: {
                self.startButton?.alpha  = 1.0
            })
        }
    }
}
