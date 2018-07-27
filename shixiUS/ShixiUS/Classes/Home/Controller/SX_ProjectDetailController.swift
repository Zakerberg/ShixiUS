//
//  SX_ProjectDetailController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/18/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  实训项目详情

import UIKit

let projectDetailCellID = "projectDetailCellID"

class SX_ProjectDetailController: UIViewController {
    
// =================================================================================================================================
// MARK: - Lazy
// =================================================================================================================================
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: self.view.bounds.height), style: .grouped)
        table.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT-CGFloat(kNavH), 0, 0, 0);
        table.delegate = self
        table.dataSource = self
        
        return table
    }()
    
    lazy var detailScrollerView: SX_CycleScrollerView = {
        let frame = CGRect(x: 0, y: -IMAGE_HEIGHT, width: SCREEN_WIDTH, height: IMAGE_HEIGHT)
        let cycleView = SX_CycleScrollerView(frame: frame, type: .LOCAL, imgs: nil, descs: nil)
        cycleView.delegate = self
        
        return cycleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let localImgs = ["localImg4","localImg6","localImg3","localImg5"]
        
        detailScrollerView.localImgArray = localImgs
        tableView.addSubview(detailScrollerView)
        view.addSubview(tableView)
        
        navBarBackgroundAlpha = 0

    }
    
    deinit {
        tableView.delegate = nil
        print("项目详情VC deinit")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// =================================================================================================================================
// MARK: - Other Method
// =================================================================================================================================
extension SX_ProjectDetailController {
    
    func fetchData() {
        
        
    }
}

// =================================================================================================================================
// MARK: - UITableViewDelegate
// =================================================================================================================================
extension SX_ProjectDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 26
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: projectDetailCellID)
        cell.textLabel?.text = "这是实训项目详情的\(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

// =================================================================================================================================
// MARK: - SXCycleScrollerViewDelegate
// =================================================================================================================================
extension SX_ProjectDetailController: SXCycleScrollerViewDelegate {
    func cycleScrollerDidScroll(to index: Int, cycleScrollerView: SX_CycleScrollerView) {
        
    }
    
    func cycleScrollViewDidSelect(at index: Int, cycleScrollView: SX_CycleScrollerView) {
        SXLog("点击了实训项目详情轮播的\(index)")
    }
}

// =================================================================================================================================
// MARK: - UIScrollViewDelegate
// =================================================================================================================================
extension SX_ProjectDetailController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if (offsetY > NAVBAR_COLORCHANGE_POINT) {
            let alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / CGFloat(kNavH)
            navBarBackgroundAlpha = alpha
            navBarTintColor = UIColor.white.withAlphaComponent(alpha)
            navBarTitleColor = UIColor.white.withAlphaComponent(alpha)
            title = "项目详情"
        } else {
            navBarBackgroundAlpha = 0
            navBarTintColor = .clear
            navBarTitleColor = .clear
            title = "项目详情"
        }
        
        // 限制下拉距离
        if (offsetY < LIMIT_OFFSET_Y) {
            scrollView.contentOffset = CGPoint.init(x: 0, y: LIMIT_OFFSET_Y)
        }
        
        // 改变图片框的大小 (上滑的时候不改变)
        // 这里不能使用offsetY，因为当（offsetY < LIMIT_OFFSET_Y）的时候，y = LIMIT_OFFSET_Y 不等于 offsetY
        let newOffsetY = scrollView.contentOffset.y
        if (newOffsetY < -IMAGE_HEIGHT) {
            detailScrollerView.frame = CGRect(x: 0, y: newOffsetY, width: SCREEN_WIDTH, height: -newOffsetY)
        }
    }
    
    // private
    fileprivate func imageScaledToSize(image:UIImage, newSize:CGSize) -> UIImage
    {
        UIGraphicsBeginImageContext(CGSize(width: newSize.width * 2.0, height: newSize.height * 2.0))
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width * 2.0, height: newSize.height * 2.0))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? image
        UIGraphicsEndImageContext()
        return newImage
    }
}



