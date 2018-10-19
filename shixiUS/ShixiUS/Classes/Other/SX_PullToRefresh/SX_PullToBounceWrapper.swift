//
//  SX_PullToBounceWrapper.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/10/19.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

fileprivate func < <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

open class SX_PullToBounceWrapper: UIView {
    
    var pullDist: CGFloat = 80
    var bendDist: CGFloat = 40
    var stopPos:CGFloat {
        get {
            return pullDist + bendDist
        }
    }
    
    open var didPullToRefresh: (()->())?
    
    var bounceView: SX_BounceView!
    open var scrollView: UIScrollView?
    
    public init(
        scrollView: UIScrollView,
        bounceDuration: CFTimeInterval = 0.8,
        ballSize:CGFloat               = 36,
        ballMoveTimingFunc:CAMediaTimingFunction = CAMediaTimingFunction(controlPoints:0.49,0.13,0.29,1.61),
        moveUpDuration:CFTimeInterval  = 0.25,
        pullDistance: CGFloat          = 96,
        bendDistance: CGFloat          = 40,
        didPullToRefresh: (()->())?    = nil
        )
    {
        if scrollView.frame == CGRect.zero {
            assert(false, "scrollView.frame is CGRectZero.设置scrollView.frame! ")
        }
        super.init(frame: scrollView.frame)
        
        self.pullDist         = pullDistance
        self.bendDist         = bendDistance
        self.didPullToRefresh = didPullToRefresh
        
        let moveUpDist = pullDist/2 + ballSize/2
        
        bounceView = SX_BounceView (
            frame: scrollView.frame
            , bounceDuration: bounceDuration
            , ballSize: ballSize
            , ballMoveTimingFunc: ballMoveTimingFunc
            , moveUpDuration: moveUpDuration
            , moveUpDist: moveUpDist
            , color: scrollView.backgroundColor
        )
        self.addSubview(bounceView)
        
        self.scrollView = scrollView
        // scrollView.frame = self.frame
        scrollView.backgroundColor = UIColor.clear
        self.addSubview(scrollView)
        scrollView.addObserver(self, forKeyPath: contentOffsetKeyPath, options: .initial, context: &KVOContext)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        scrollView?.removeObserver(self, forKeyPath: contentOffsetKeyPath, context: &KVOContext)
    }
    
    func scrollViewDidScroll() {
        if scrollView?.contentOffset.y < 0 {
            let y = scrollView!.contentOffset.y * -1
            if y < pullDist {
                bounceView.frame.y = y
                bounceView.wave(0)
                scrollView?.alpha = (pullDist - y)/pullDist
            }
            else if y < stopPos {
                bounceView.wave(y - pullDist)
                scrollView?.alpha = 0
            }
            else if y > stopPos {
                scrollView?.isScrollEnabled = false
                scrollView?.setContentOffset(CGPoint(x: scrollView!.contentOffset.x, y: -stopPos), animated: false)
                bounceView.frame.y = pullDist
                bounceView.wave(stopPos - pullDist)
                bounceView.didRelease(stopPos - pullDist)
                self.didPullToRefresh?()
                scrollView?.alpha = 0
            }
        } else {
            bounceView.frame.y = 0
            scrollView?.alpha = 1
        }
    }
    
    open func stopLoadingAnimation() {
        bounceView.endingAnimation {
            self.scrollView?.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            self.scrollView?.isScrollEnabled = true
        }
    }
    
    // MARK: ScrollView KVO
    fileprivate var KVOContext           = "PullToRefreshKVOContext"
    fileprivate let contentOffsetKeyPath = "contentOffset"
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (context == &KVOContext && keyPath == contentOffsetKeyPath && object as? UIScrollView == scrollView) {
            scrollViewDidScroll()
        }
        else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}
