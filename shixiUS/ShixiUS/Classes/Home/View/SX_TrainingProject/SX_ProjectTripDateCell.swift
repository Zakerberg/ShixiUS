//
//  SX_ProjectTripDateCell.swift
//  ShixiUS
//
//  Created by heather on 2018/9/11.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  项目详情的 行程出发时间cell

import UIKit

class SX_ProjectTripDateCell: UITableViewCell {
    
    let TRIPBTNWIDTH = 100
    let DATEBTNWIDTH = 65
    
    var tripScrollView: UIScrollView?
    var dateScrollView: UIScrollView?
    
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
                TRIPS.contentSize = CGSize(width: (TRIPBTNWIDTH+20)*(self.tripArr?.count ?? 0), height: 0)
                TRIPS.showsVerticalScrollIndicator = false
                TRIPS.showsHorizontalScrollIndicator = false
                TRIPS.bounces = true
            })
            
            for index in 0..<(self.tripArr?.count ?? 0) {
                self.tripBtn = UIButton(type: .custom).addhere(toSuperView: self.tripScrollView!).layout(snapKitMaker: { (make) in
                    make.height.top.equalToSuperview()
                    make.left.equalToSuperview().offset(index*(TRIPBTNWIDTH+20))
                    make.width.equalTo(TRIPBTNWIDTH.FloatValue.IPAD_XValue)
                }).config({ (TRIP) in
                    TRIP.backgroundColor = UIColor.cyan
                })
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
            }).config({ (TITLE) in
                TITLE.sizeToFit()
                TITLE.text = "出发时间"
                TITLE.textColor = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
                TITLE.font = UIFont.systemFont(ofSize: 15)
            })
            
            self.dateScrollView = UIScrollView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
                make.top.equalTo(title.snp.bottom).offset(Margin)
                make.left.equalTo(title)
                make.height.equalTo(65.FloatValue.IPAD_XValue)
                make.right.equalToSuperview().offset(-50.FloatValue.IPAD_XValue)
            }).config({ (DATES) in
                DATES.showsVerticalScrollIndicator = false
                DATES.showsHorizontalScrollIndicator = false
                DATES.scrollsToTop = false
                DATES.bounces = true
            })
            
            for i in 0..<(self.dateArr?.count ?? 0) {
                self.dateBtn = UIButton(type: .custom).addhere(toSuperView: self.dateScrollView!).layout(snapKitMaker: { (make) in
                    make.height.top.equalToSuperview()
                    make.left.equalToSuperview().offset(i*(DATEBTNWIDTH+8))
                    make.width.equalTo(DATEBTNWIDTH.FloatValue.IPAD_XValue)
                }).config({ (DATE) in
                    DATE.backgroundColor = UIColor.yellow
                })
            }
            
            self.moreDate = UIButton(type: .custom).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
                make.height.centerY.equalTo(self.dateBtn!)
                make.right.equalToSuperview().offset(-Margin)
                make.width.equalTo(50.FloatValue.IPAD_XValue)
            }).config({ (MORE) in
                MORE.backgroundColor = UIColor.blue
                
            })
        }
    }
    
    var tripBtn: UIButton?
    var dateBtn: UIButton?
    /// 更多日期
    var moreDate: UIButton?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        ConfigCell()
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
// MARK: - ConfigCell()
// =================================================================================================================
extension SX_ProjectTripDateCell {
    func ConfigCell() {
        
    }
}



