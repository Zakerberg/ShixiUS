//
//  SX_PageControl.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/25/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

private let SXPageControlPointWidth: CGFloat = 7
private let SXPageControlPointHeight: CGFloat = 20

class SX_PageControl: UIPageControl
{
    var currentImage: UIImage?
    var defaultImage: UIImage?
    var pointSpace: CGFloat = 15
    var pageSize: CGSize {
        get {
            if let curImage = currentImage, let defImage = defaultImage {
                let pageH = curImage.size.height
                let defDotW = defImage.size.width
                let curDotW = curImage.size.width
                let pageW = CGFloat(numberOfPages - 1) * (pointSpace + defDotW + defDotW) + curDotW
                return CGSize(width: pageW, height: pageH)
            }
            else {
                let pageW = CGFloat(numberOfPages - 1) * (pointSpace + SXPageControlPointWidth) + SXPageControlPointWidth
                return CGSize(width: pageW, height: SXPageControlPointHeight)
            }
        }
    }
    
    override var currentPage: Int {
        didSet {
            updatePageControl()
        }
    }
    
    init(frame: CGRect, currentImage: UIImage?, defaultImage: UIImage?)
    {
        super.init(frame: frame)
        self.currentImage = currentImage
        self.defaultImage = defaultImage
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//=========================================================================================================================================
// MARK: - update index
//=========================================================================================================================================
extension SX_PageControl
{
    func updatePageControl()
    {
        for index in 0..<subviews.count
        {
            let newSize = getDotSize(currentIndex: index)
            let dot = subviews[index]
            dot.frame = CGRect(x: dot.frame.origin.x, y: dot.frame.origin.y, width: newSize.width, height: newSize.height)
            if dot.subviews.count == 0 {
                let imgView = UIImageView(frame: dot.bounds)
                imgView.contentMode = .scaleAspectFit
                dot.addSubview(imgView)
            }
            let imgView = dot.subviews.first as! UIImageView
            imgView.frame = dot.bounds
            if index == currentPage
            {
                if let curImage = currentImage {
                    imgView.image = curImage
                    dot.backgroundColor = UIColor.clear
                } else {
                    imgView.image = nil
                    dot.backgroundColor = currentPageIndicatorTintColor
                }
            }
            else if let defImage = defaultImage {
                imgView.image = defImage
                dot.backgroundColor = UIColor.clear
            }
            else {
                imgView.image = nil
                dot.backgroundColor = pageIndicatorTintColor
            }
        }
    }
    
    func getDotSize(currentIndex:Int) -> CGSize
    {
        var newSize = CGSize(width: 0, height: 0)
        if let curImage = currentImage, let defImage = defaultImage {
            if currentIndex == currentPage {
                newSize = curImage.size
            } else {
                newSize = defImage.size
            }
        } else {
            newSize = CGSize(width: SXPageControlPointWidth, height: SXPageControlPointWidth)
        }
        return newSize
    }
}
