//
//  SX_GuidePageControl.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/8/31.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

/*
 我爱你
 我们都曾想做勇者
 可生活把一切变得苦涩
 如果金钱是你梦想的绊脚石
 记得来找我
 */

import UIKit

@IBDesignable
open class SX_GuidePageControl: UIPageControl {
    
    @IBInspectable
     open override var numberOfPages: Int {
        didSet {
            self.setNeedsCreateIndicators()
        }
    }
    
    @IBInspectable
     open override var currentPage: Int {
        didSet {
            self.setNeedsUpdateIndicators()
        }
    }
    
    @IBInspectable
    open var itemSpacing: CGFloat = 6 {
        didSet {
            self.setNeedsUpdateIndicators()
        }
    }
    
    @IBInspectable
    open var interitemSpacing: CGFloat = 6 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    open var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    open override var contentHorizontalAlignment: UIControlContentHorizontalAlignment {
        didSet {
            self.setNeedsLayout()
        }
    }

    internal var strokeColors: [UIControlState: UIColor]         = [:]
    internal var fillColors: [UIControlState: UIColor]           = [:]
    internal var paths: [UIControlState: UIBezierPath]           = [:]
    internal var images: [UIControlState: UIImage]               = [:]
    internal var alphas: [UIControlState: CGFloat]               = [:]
    internal var transforms: [UIControlState: CGAffineTransform] = [:]
    
    fileprivate weak var contentView: UIView!
    
    fileprivate var needsUpdateIndicators = false
    fileprivate var needsCreateIndicators = false
    fileprivate var indicatorLayers       = [CAShapeLayer]()
    
    fileprivate var runLoopObserver: CFRunLoopObserver?
    fileprivate var runLoopCallback: CFRunLoopObserverCallBack = {
        (observer: CFRunLoopObserver?, activity: CFRunLoopActivity, info: UnsafeMutableRawPointer?) -> Void in
        guard let info = info else {
            return
        }
        let pageControl = Unmanaged<SX_GuidePageControl>.fromOpaque(info).takeUnretainedValue()
        pageControl.createIndicatorsIfNecessary()
        pageControl.updateIndicatorsIfNecessary()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    deinit {
        CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), self.runLoopObserver, .commonModes)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = {
            let x      = self.contentInsets.left
            let y      = self.contentInsets.top
            let width  = self.frame.width - self.contentInsets.left - self.contentInsets.right
            let height = self.frame.height - self.contentInsets.top - self.contentInsets.bottom
            let frame  = CGRect(x: x, y: y, width: width, height: height)
            return frame
        }()
    }
    
    open override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        let diameter   = self.itemSpacing
        let spacing    = self.interitemSpacing
        var x: CGFloat = {
            switch self.contentHorizontalAlignment {
            case .left:
                return 0
            case .center, .fill:
                let midX = self.contentView.bounds.midX
                let amplitude = CGFloat(self.numberOfPages/2) * diameter + spacing*CGFloat((self.numberOfPages-1)/2)
                return midX - amplitude
            case .right:
                let contentWidth = diameter*CGFloat(self.numberOfPages) + CGFloat(self.numberOfPages-1)*spacing
                return contentView.frame.width - contentWidth
            case .leading:
                return 0
            case .trailing:
                return 0
            }
        }()
        for (index, value) in self.indicatorLayers.enumerated() {
            let state: UIControlState = (index == self.currentPage) ? .selected : .normal
            let image   = self.images[state]
            let size    = image?.size ?? CGSize(width: diameter, height: diameter)
            let origin  = CGPoint(x: x - (size.width-diameter)*0.5, y: self.contentView.bounds.midY-size.height*0.5)
            value.frame = CGRect(origin: origin, size: size)
            x += (spacing + diameter)
        }
        
    }
    
    @objc(setStrokeColor:forState:)
    open func setStrokeColor(_ strokeColor: UIColor?, for state: UIControlState) {
        guard self.strokeColors[state] != strokeColor else {
            return
        }
        self.strokeColors[state] = strokeColor
        self.setNeedsUpdateIndicators()
    }
    
    @objc(setFillColor:forState:)
    open func setFillColor(_ fillColor: UIColor?, for state: UIControlState) {
        guard self.fillColors[state] != fillColor else {
            return
        }
        self.fillColors[state] = fillColor
        self.setNeedsUpdateIndicators()
    }
    
    @objc(setImage:forState:)
    open func setImage(_ image: UIImage?, for state: UIControlState) {
        guard self.images[state] != image else {
            return
        }
        self.images[state] = image
        self.setNeedsUpdateIndicators()
    }
    
    @objc(setAlpha:forState:)
    
    open func setAlpha(_ alpha: CGFloat, for state: UIControlState) {
        guard self.alphas[state] != alpha else {
            return
        }
        self.alphas[state] = alpha
        self.setNeedsUpdateIndicators()
    }
    
    @objc(setPath:forState:)
    open func setPath(_ path: UIBezierPath?, for state: UIControlState) {
        guard self.paths[state] != path else {
            return
        }
        self.paths[state] = path
        self.setNeedsUpdateIndicators()
    }
    
    // MARK: - Private functions
    fileprivate func commonInit() {
        
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.clear
        self.addSubview(view)
        self.contentView = view
        
        let runLoop = CFRunLoopGetCurrent()
        let activities: CFRunLoopActivity = [.entry, .afterWaiting]
        var context = CFRunLoopObserverContext(version: 0, info: Unmanaged.passUnretained(self).toOpaque(), retain: nil, release: nil, copyDescription: nil)
        self.runLoopObserver = CFRunLoopObserverCreate(nil, activities.rawValue, true, Int.max, self.runLoopCallback, &context)
        CFRunLoopAddObserver(runLoop, self.runLoopObserver, .commonModes)
        
    }
    
    fileprivate func setNeedsUpdateIndicators() {
        self.needsUpdateIndicators = true
        self.setNeedsLayout()
    }
    
    fileprivate func updateIndicatorsIfNecessary() {
        guard self.needsUpdateIndicators else {
            return
        }
        guard !self.indicatorLayers.isEmpty else {
            return
        }
        self.needsUpdateIndicators = false
        self.indicatorLayers.forEach { (layer) in
            self.updateIndicatorAttributes(for: layer)
        }
    }
    
    fileprivate func updateIndicatorAttributes(for layer: CAShapeLayer) {
        let index = self.indicatorLayers.index(of: layer)
        let state: UIControlState = index == self.currentPage ? .selected : .normal
        if let image = self.images[state] {
            layer.strokeColor = nil
            layer.fillColor = nil
            layer.path = nil
            layer.contents = image.cgImage
        } else {
            layer.contents = nil
            let strokeColor = self.strokeColors[state]
            let fillColor = self.fillColors[state]
            if strokeColor == nil && fillColor == nil {
                layer.fillColor = (state == .selected ? UIColor.white : UIColor.gray).cgColor
                layer.strokeColor = nil
            } else {
                layer.strokeColor = strokeColor?.cgColor
                layer.fillColor = fillColor?.cgColor
            }
            layer.path = self.paths[state]?.cgPath ?? UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: self.itemSpacing, height: self.itemSpacing)).cgPath
        }
        if let transform = self.transforms[state] {
            layer.transform = CATransform3DMakeAffineTransform(transform)
        }
        layer.opacity = Float(self.alphas[state] ?? 1.0)
    }
    
    fileprivate func setNeedsCreateIndicators() {
        self.needsCreateIndicators = true
    }
    
    fileprivate func createIndicatorsIfNecessary() {
        guard self.needsCreateIndicators else {
            return
        }
        self.needsCreateIndicators = false
        self.indicatorLayers.forEach { (layer) in
            layer.removeFromSuperlayer()
        }
        self.indicatorLayers.removeAll()
        for _ in 0..<self.numberOfPages {
            let layer = CAShapeLayer()
            layer.actions = ["bounds": NSNull()]
            self.contentView.layer.addSublayer(layer)
            self.indicatorLayers.append(layer)
        }
        self.setNeedsUpdateIndicators()
        self.updateIndicatorsIfNecessary()
    }
}

extension UIControlState: Hashable {
    public var hashValue: Int {
        return Int((6777*self.rawValue+3777)%UInt(UInt16.max))
    }
}


