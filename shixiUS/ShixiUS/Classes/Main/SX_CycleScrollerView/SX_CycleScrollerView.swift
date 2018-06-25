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
    
    var outerPageControlFrame: CGRect? {
        didSet{
            setupPageControl()
        }
    }
}

// MARK: - PageControl页面
extension SX_CycleScrollerView {
   
   fileprivate func setupPageControl() {
        
        
    
    
 
    
    
    
    
    
        
    }
}
