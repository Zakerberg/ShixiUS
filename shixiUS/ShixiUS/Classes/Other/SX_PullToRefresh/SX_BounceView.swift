//
//  SX_BounceView.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/10/19.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

/*
 霜染青丝，情丝不绝，
 婉兮美人，惶惶我心，
 愿携柔荑，白首不离
 */

import UIKit

class SX_BounceView: UIView {
    let ballView : SX_BallView!
    let waveView : SX_WaveView!
    
    init(
        frame:CGRect,
        bounceDuration: CFTimeInterval = 0.8,
        ballSize:CGFloat    = 28,//32,
        ballMoveTimingFunc:CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
        moveUpDuration:CFTimeInterval = 0.2,
        moveUpDist: CGFloat = 32 * 1.5,
        color: UIColor!     = UIColor.white
        )
    {
        var color = color
        if color == nil {
            color = UIColor.white
        }
        
        let ballViewHeight: CGFloat = 100
        
        ballView = SX_BallView(
            frame: CGRect(x: 0, y: -(ballViewHeight + 1), width: frame.width, height: ballViewHeight),
            circleSize: ballSize,
            timingFunc: ballMoveTimingFunc,
            moveUpDuration: moveUpDuration,
            moveUpDist: moveUpDist,
            color: color!
        )
        
        waveView = SX_WaveView(
            frame:CGRect(x: 0, y: 0, width: ballView.frame.width, height: frame.height),
            bounceDuration: bounceDuration,
            color: color!
        )
        
        super.init(frame: frame)
        
        ballView.isHidden = true
        
        self.addSubview(ballView)
        self.addSubview(waveView)
        
        waveView.didEndPull = {
            _ = Timer.schedule(delay: 0.2) { timer in
                self.ballView.isHidden = false
                self.ballView.startAnimation()
            }
        }
    }
    
    func endingAnimation(_ complition:(()->())? = nil) {
        ballView.endAnimation {
            self.ballView.isHidden = true
            complition?()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func wave(_ y: CGFloat) {
        waveView.wave(y)
    }
    
    func didRelease(_ y: CGFloat) {
        waveView.didRelease(amountX: 0, amountY: y)
    }
}
