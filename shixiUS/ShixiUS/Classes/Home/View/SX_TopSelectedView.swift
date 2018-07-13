//
//  SX_TopSelectedView.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/10/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  头部选择View

import UIKit

class SX_TopSelectedView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: 0))
        path.move(to: CGPoint(x: 0, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        
        path.lineWidth = 0.5
        UIColor.colorWithHexString(hex: "b2b2b2", alpha: 1).set()
        context?.drawPath(using: CGPathDrawingMode.fill)
    }
}
