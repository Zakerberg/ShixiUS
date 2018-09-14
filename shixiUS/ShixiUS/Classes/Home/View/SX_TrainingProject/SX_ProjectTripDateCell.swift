//
//  SX_ProjectTripDateCell.swift
//  ShixiUS
//
//  Created by heather on 2018/9/11.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  项目详情的 行程出发时间cell

/*
 江南小镇风景秀丽
 我行至烟雨长廊的尽头，驻目远望
 你若在，风景应是你
 */

import UIKit

class SX_ProjectTripDateCell: UITableViewCell {
    
    let TRIPBTNWIDTH = 100
    let DATEBTNWIDTH = 65
    
    var tripScrollView: UIScrollView?
    var dateScrollView: UIScrollView?
    
    var tripBtn: UIButton?
    var dateBtn: UIButton?
    /// 更多日期
    var moreDate: UIButton?
    
    /// 行程A
    /// tripBtn 直接设置title
    
    /// 06.12
    var date: UILabel?
    /// $5252
    var price: UILabel?
    
    /// 行程
    var tripArr: [String]? {
        willSet{
            if tripArr == newValue {
                return
            }
            tripArr = newValue
            
            self.tripScrollView = UIScrollView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
                make.top.left.equalToSuperview().offset(Margin)
                make.right.equalToSuperview().offset(-Margin)
                make.height.equalTo(45.FloatValue.IPAD_XValue)
            }).config({ (TRIPS) in
                TRIPS.contentSize                    = CGSize(width: (TRIPBTNWIDTH+20)*(self.tripArr?.count ?? 0), height: 0)
                TRIPS.showsVerticalScrollIndicator   = false
                TRIPS.showsHorizontalScrollIndicator = false
                TRIPS.bounces                        = true
                TRIPS.isUserInteractionEnabled       = true
            })
            
            for index in 0..<(self.tripArr?.count ?? 0) {
                self.tripBtn = UIButton(type: .custom).addhere(toSuperView: self.tripScrollView!).layout(snapKitMaker: { (make) in
                    make.height.top.equalToSuperview()
                    make.left.equalToSuperview().offset(index*(TRIPBTNWIDTH+20))
                    make.width.equalTo(TRIPBTNWIDTH.FloatValue.IPAD_XValue)
                }).config { (TRIPBTN) in
                    TRIPBTN.setTitle(self.tripArr?[index], for: .normal)
                    TRIPBTN.setTitleColor(UIColor.white, for: .selected)
                    TRIPBTN.setTitleColor(UIColor.colorWithRGB(r: 51, g: 51, b: 51), for: .normal)
                    TRIPBTN.titleLabel?.font          = UIFont.boldSystemFont(ofSize: 15)
                    TRIPBTN.titleLabel?.textAlignment = .center
                    TRIPBTN.setBackgroundImage(#imageLiteral(resourceName: "icon_projectDetail_Gray"), for: .normal)
                    TRIPBTN.setBackgroundImage(#imageLiteral(resourceName: "icon_projectDetail_MainColor"), for: .selected)
                    TRIPBTN.tag                       = 5000+index
                    SXLog(TRIPBTN.tag)
                    if index == 0 {
                        TRIPBTN.isSelected = true
                    }
                    
                    TRIPBTN.addTarget(self, action: #selector(tripBtnClick), for: .touchUpInside)
                }
            }
        }
    }
    
    /// 出发时间Arr
    var dateArr: [String]? {
        willSet {
            if dateArr == newValue {
                return
            }
            
            dateArr = newValue
            
            let title = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
                make.top.equalTo(self.tripScrollView!.snp.bottom).offset(Margin)
                make.left.equalTo(self.tripScrollView!)
                make.height.equalTo(Margin)
            }).config{ (TITLE) in
                TITLE.sizeToFit()
                TITLE.text      = "出发时间"
                TITLE.textColor = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
                TITLE.font      = UIFont.systemFont(ofSize: 15)
            }
            
            self.dateScrollView = UIScrollView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
                make.top.equalTo(title.snp.bottom).offset(Margin)
                make.left.equalTo(title)
                make.height.equalTo(65.FloatValue.IPAD_XValue)
                make.right.equalToSuperview().offset(-50.FloatValue.IPAD_XValue)
            }).config { (DATES) in
                DATES.showsVerticalScrollIndicator = false
                DATES.showsHorizontalScrollIndicator = false
                DATES.scrollsToTop = false
                DATES.bounces      = true
            }
            
            for i in 0..<(self.dateArr?.count ?? 0) {
                self.dateBtn = UIButton(type: .custom).addhere(toSuperView: self.dateScrollView!).layout(snapKitMaker: { (make) in
                    make.height.top.equalToSuperview()
                    make.left.equalToSuperview().offset(i*(DATEBTNWIDTH+8))
                    make.width.equalTo(DATEBTNWIDTH.FloatValue.IPAD_XValue)
                }).config { (DATE) in
                    DATE.tag                       = i+3000
                    DATE.layer.cornerRadius        = 5
                    DATE.layer.borderColor         = UIColor.init(white: 0.6, alpha: 1).cgColor
                    DATE.layer.borderWidth         = 0.6
                    
                    SXLog(DATE.tag)
                    if i == 0 {
                        DATE.isSelected = true
                    }
                    
                    DATE.addTarget(self, action: #selector(dateBtnClick), for: .touchUpInside)
                }
            }
            
            self.moreDate = UIButton(type: .custom).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
                make.height.centerY.equalTo(self.dateBtn!)
                make.right.equalToSuperview().offset(-Margin)
                make.width.equalTo(50.FloatValue.IPAD_XValue)
            }).config({ (MORE) in
                
                
                
                
                
            })
        }
    }
    
    /// 出发时间Btn 的dateArr
    var dateTArr:[String]? {
        willSet{
            if dateTArr == newValue {
                return
            }
            dateTArr = newValue
            
            for index in 0..<(self.dateArr?.count ?? 0) {
                /// 加 date Label
                self.date = UILabel().addhere(toSuperView: self.dateScrollView!).layout(snapKitMaker: { (make) in
                    make.top.equalToSuperview().offset(Margin)
                    make.left.equalToSuperview().offset(index*(DATEBTNWIDTH+8)+Int(Margin))
                    make.height.equalTo(13.FloatValue.IPAD_XValue)
                }).config { (DATE) in
                    DATE.sizeToFit()
                    if self.dateBtn?.isSelected == true {
                        DATE.font = UIFont.boldSystemFont(ofSize: 12)
                        DATE.textColor = UIColor.SX_MainColor()
                    }else{
                        DATE.font = UIFont.systemFont(ofSize: 12)
                        DATE.textColor = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
                    }
                    DATE.text = self.dateTArr?[index]
                }
            }
        }
    }
    
    /// 出发时间Btn 的priceTArr
    var priceTArr:[String]? {
        willSet{
            if priceTArr == newValue {
                return
            }
            priceTArr = newValue
            /// 加 price Label
            for index in 0..<(self.priceTArr?.count ?? 0) {
                self.price = UILabel().addhere(toSuperView: self.dateScrollView!).layout(snapKitMaker: { (make) in
                    make.top.equalTo(self.date!.snp.bottom).offset(Margin)
                    make.height.equalTo(self.date!)
                    make.left.equalToSuperview().offset(index*(DATEBTNWIDTH+8)+Int(Margin))
                }).config({ (PRICE) in
                    PRICE.sizeToFit()
                    if self.dateBtn?.isSelected == true  {
                        PRICE.font = UIFont.boldSystemFont(ofSize: 12)
                        PRICE.textColor = UIColor.SX_MainColor()
                    }else{
                        PRICE.font = UIFont.systemFont(ofSize: 12)
                        PRICE.textColor = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
                    }
                    PRICE.text = self.priceTArr?[index]
                })
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

// ==================================================================================================================
// MARK: - 
// =================================================================================================================
extension SX_ProjectTripDateCell {
    @objc func tripBtnClick(btn: UIButton) {
        SXLog(btn.tag)
        for index in 0...(self.tripArr?.count ?? 0) {
            let button = self.viewWithTag(5000+index) as? UIButton
            if button?.tag != btn.tag {
                button?.setBackgroundImage(#imageLiteral(resourceName: "icon_projectDetail_Gray"), for: .normal)
                button?.isSelected = false
            }else{
                button?.setBackgroundImage(#imageLiteral(resourceName: "icon_projectDetail_MainColor"), for: .selected)
                button?.isSelected = true
            }
        }
    }
    
    /// 出发日期 Btn
    @objc func dateBtnClick(btn: UIButton) {
        SXLog(btn.tag)
        for index in 0...(self.dateArr?.count ?? 0) {
            let button = self.viewWithTag(3000+index) as? UIButton
            if button?.tag != btn.tag {
                button?.layer.borderColor = UIColor.init(white: 0.6, alpha: 1).cgColor
                button?.layer.borderWidth = 0.6
                button?.isSelected = false
            }else{
                button?.layer.borderColor = UIColor.SX_MainColor().cgColor
                button?.layer.borderWidth = 0.6
//                self.date?.textColor = UIColor.SX_MainColor()
//                self.price?.textColor = UIColor.SX_MainColor()
                button?.isSelected = true
            }
        }
    }
}
