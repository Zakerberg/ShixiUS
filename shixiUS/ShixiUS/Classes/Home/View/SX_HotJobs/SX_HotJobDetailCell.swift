//
//  SX_HotJobDetailCell.swift
//  ShixiUS
//
//  Created by heather on 2018/9/10.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  热门岗位详情  职位信息Cell

import UIKit

class SX_HotJobDetailCell: UITableViewCell {

    var jobName        : UILabel?
    var jobReleaseTime : UILabel?
    /// 行业
    var jobIndustry    : UILabel?
    var jobPlace       : UILabel?
    var jobPeopleCount : UILabel?
    /// 全职类型
    var jobFullTime    : UILabel?
    /// 实习类型
    var jobInterShip   : UILabel?
    /// 薪资
    var jobSalary      : UILabel?
    /// 职位介绍
    var jobIntroduce   : UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCell()
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
// MARK: - configCell()
// =================================================================================================================
extension SX_HotJobDetailCell {
    
    func configCell() {
        
        self.jobName = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
        }).config({ (Name) in

        })
        
        self.jobReleaseTime = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
        }).config({ (RELEASE) in
            
        })
        
        /// 行业
        self.jobIndustry = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
        }).config({ (INDUSTRY) in
            
        })
        
        
        self.jobPlace = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
        }).config({ (PLACE) in
            
        })
        
        
        self.jobPeopleCount = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
        }).config({ (COUNT) in
            
        })
        
        /// 全职类型
        self.jobFullTime = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
        }).config({ (FULLTIME) in
            
        })
        
        /// 实习类型
        self.jobInterShip = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
        }).config({ (INTERSHIP) in
            
        })
        
        /// 薪资
        self.jobSalary = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
        }).config({ (SALARY) in
            
        })
    
        let lineView = UIView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in

        }).config({ (LINE) in
            LINE.backgroundColor = UIColor.SX_LineColor()
        })

        /// 职位介绍
        self.jobIntroduce = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
        }).config({ (INTRODUCE) in
            
        })
    }
}
