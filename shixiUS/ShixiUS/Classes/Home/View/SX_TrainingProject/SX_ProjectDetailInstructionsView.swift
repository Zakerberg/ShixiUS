//
//  SX_ProjectDetailInstructionsView.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/1/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  项目详情界面 项目说明(项目亮点,日程安排....)View

import UIKit

class SX_ProjectDetailInstructionsView: UIView {
    
    typealias titleClickClosure = ((_ row: NSInteger)->Void)
    var titleClosure: titleClickClosure?
    
    var bottomView: UIView?
    var indicateLine:UIView?
    var instructionBtn: UIButton?
    var titleBtnArray :NSMutableArray?
    var titleArr = ["项目亮点","日程安排","费用说明","预定须知"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ConfigCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// ===============================================================================================================================
// MARK: - ConfigCell()
// ===============================================================================================================================
extension SX_ProjectDetailInstructionsView {
    
    func ConfigCell() {
        
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40.FloatValue.IPAD_XValue)
        self.backgroundColor = UIColor.white
        let btnWidth = SCREEN_WIDTH/4
        
        for i in 0...3 {
            self.instructionBtn = UIButton(type: .custom).addhere(toSuperView: self).layout(snapKitMaker: { (make) in
                make.top.equalToSuperview()
                make.left.equalToSuperview().offset(i*Int(btnWidth))
                make.width.equalTo(btnWidth)
                make.height.equalToSuperview()
            }).config { (btn) in
                btn.setTitle(titleArr[i], for: .normal)
                btn.titleLabel?.textColor = UIColor.black

                if i == 0 {
                    btn.setTitleColor(UIColor.SX_MainColor(), for: .normal)
                }else{
                    btn.setTitleColor(UIColor.colorWithHexString(hex: "666666", alpha: 1), for: .normal)
                }
                
                btn.setTitleColor(UIColor.SX_MainColor(), for: .selected)
                btn.tag = i
                btn.backgroundColor = UIColor.white
                self.titleBtnArray?.add(btn)
            }
        }
        
        self.indicateLine = UIView().addhere(toSuperView: self).layout(snapKitMaker: { (make) in
            make.width.equalTo(self.instructionBtn!)
            make.width.equalTo(1.FloatValue.IPAD_XValue)
            make.top.equalTo(self.instructionBtn!.snp.bottom).offset(1)
        }).config({ (indicateLine) in
            indicateLine.backgroundColor = UIColor.SX_MainColor()
        })
    }
}


extension SX_ProjectDetailInstructionsView {
    
    func setItemSelected(colunm: NSInteger) {
        
        for index in 0...3 {
            let btn = titleBtnArray![index] as? UIButton
            if index == colunm {
                btn?.setTitleColor(UIColor.SX_MainColor(), for: .normal)
            } else {
                btn?.setTitleColor(UIColor.colorWithHexString(hex: "ff7900", alpha: 1), for: .normal)
            }
        }
        
        let btnWidth = SCREEN_WIDTH/CGFloat(self.titleBtnArray!.count)
        self.indicateLine?.frame = CGRect(x: btnWidth*CGFloat(colunm), y: 49, width: btnWidth, height: 1)
    }
}

// MARK: -  S U B V I E W  ! ! !
// ===============================================================================================================================
// ---------------------------------------------------- S U B V I E W ------------------------------------------------------------
// ===============================================================================================================================

class SX_SubView: UIView {
    
    var contenView: UIScrollView?
    typealias contentViewScrollEvent = ((_ integer: NSInteger)->Void)
    var ScrollEventClosure: contentViewScrollEvent? // 回调点击事件
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contenView = UIScrollView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.contenView?.contentSize = CGSize(width: frame.size.width*3, height: frame.size.height)
        self.contenView?.isPagingEnabled = false
        self.contenView?.bounces  = true
        self.contenView?.delegate = self
        self.contenView?.showsHorizontalScrollIndicator = false
        self.addSubview(self.contenView!)
        
        
        let aSubTable = SX_ProjectDetailInstructionsTableView(frame: CGRect(x: frame.size.width, y: 0, width: frame.size.width, height: frame.size.height))
        self.contenView?.addSubview(aSubTable)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// ===============================================================================================================================
// MARK: - SubView -- UIScrollViewDelegate
// ===============================================================================================================================
extension SX_SubView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let pageNum: NSInteger = NSInteger(offsetX/SCREEN_WIDTH)
        
        if (self.ScrollEventClosure != nil) {
            self.ScrollEventClosure!(pageNum)
        }
    }
}

// MARK: - I N S T R U C T I O N S T A B L E V I E W ! ! !
// ===============================================================================================================================
// ----------------------------------------------- I N S T R U C T I O N S  ------------------------------------------------------
// ===============================================================================================================================
class SX_ProjectDetailInstructionsTableView: UIView {
    
    let projectDetailInstructionsTableViewCellId = "projectDetailInstructionsTableViewCellId"
    
    lazy var table: SX_PorjectDetailTableView = {
        
        let tableView = SX_PorjectDetailTableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.type = .Sub
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.table.frame = self.bounds
        self.addSubview(self.table)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// ===============================================================================================================================
// MARK: - UITableViewDelegate
// ===============================================================================================================================
extension SX_ProjectDetailInstructionsTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let insructionsCell = UITableViewCell(style: .default, reuseIdentifier: projectDetailInstructionsTableViewCellId)
        insructionsCell.textLabel?.text = "+_+ +_+ 我是日程安排! !"
        
        return insructionsCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

