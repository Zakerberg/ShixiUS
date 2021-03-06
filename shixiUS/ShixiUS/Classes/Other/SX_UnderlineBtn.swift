//
//  SX_UnderlineBtn.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/23/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  下划线Btn

/*
 你是风是雾是罂粟
 唯独不是归宿
 我是喜是悲是孤独
 都停不下跟随你的脚步
 */

import UIKit

class SX_UnderlineBtn: UIButton {
    
    var lineColor: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        lineColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setlineColor(color: UIColor) {
        self.setNeedsDisplay()
        lineColor = color
    }
    
    override func draw(_ rect: CGRect) {
        let textRect   = self.titleLabel?.frame
        let contextRef = UIGraphicsGetCurrentContext()
        let descender  = self.titleLabel?.font.descender
        
        if self.lineColor!.isKind(of: UIColor.self) {
            contextRef?.setStrokeColor(lineColor!.cgColor)
        }
        
        contextRef?.move(to: CGPoint(x: textRect!.origin.x, y: textRect!.origin.y + textRect!.size.height + descender!+1))
        contextRef?.addLine(to: CGPoint(x: textRect!.origin.x + textRect!.size.width, y: textRect!.origin.y + textRect!.size.height + descender!+1))
        contextRef?.closePath()
        contextRef?.drawPath(using: .stroke)
    }
}
