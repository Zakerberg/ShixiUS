//
//  SX_CycleScrollerView.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/25/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

protocol SXCycleScrollerViewDelegate {
    
    // 点击图片的回调
    func cycleScrollerViewSelected(at index:Int, cycleScrollerView: SX_CycleScrollerView)
    // 图片滚动的回调
    func cycleScrollerDidScroller(to index: Int, cycleScrollerView: SX_CycleScrollerView)
}

class SX_CycleScrollerView: UIView {
    
    var delegate: SXCycleScrollerViewDelegate?
    
    fileprivate var proxy: SXProxy!
    fileprivate var flowLayout: UICollectionViewFlowLayout?
    fileprivate var collectionView: UICollectionView?
    fileprivate var cellID = "SXCycleCellID"
    fileprivate var pageControl: SX_PageControl!
    var timer:Timer?
    
    var outerPageControlFrame: CGRect? {
        didSet{
            setupPageControl()
        }
    }
    
    //MARK: - 数据相关
    var imgsType: ImgType = .SERVER
    var localImageArray:[String]? {
        didSet{
            if let local = localImageArray {
                proxy = SXProxy(type: .LOCAL, array: local)
                reloadData()
            }
        }
    }
    
    
    var serverImgArray:[String]? {
        didSet{
            if let server = serverImgArray {
                proxy = SXProxy(type: .SERVER, array: server)
                reloadData()
            }
        }
    }
    
    var descTextArray: [String]?
    var placeholderImage: UIImage?
    
    // SX_CycleCell相关
    var imageContentMode: UIViewContentMode?
    var descLabelFont: UIFont?
    var descLabelTxetColor: UIColor?
    var descLabelHeight: CGFloat?
    var descLabelTextAlignment: NSTextAlignment?
    var bottonViewBackgroundColor: UIColor?
    
    // 主要功能需求
    override var frame: CGRect {
        didSet{
            flowLayout?.itemSize = frame.size
            collectionView?.frame = bounds
        }
    }
    
    var isAutoScroll: Bool = true {
        didSet{
            timer?.invalidate()
            timer = nil
            if isAutoScroll == true {
                setupTimer()
            }
        }
    }
    
    var isEndlessScroll: Bool = true {
        didSet{
            timer?.invalidate()
            timer = nil
            if isEndlessScroll == true {
                setEndTimer()
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - 对外的方法
    func reloadData() {
        
        timer?.invalidate()
        timer = nil
        collectionView?.reloadData()
        
        setupPageControl()


    }
    
    
    func setupTimer() {
        
        
    }
    
    func setEndTimer() {
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}

// MARK: - PageControl页面
extension SX_CycleScrollerView {
    
    fileprivate func setupPageControl() {
        
        
        
        
        
    }
}
