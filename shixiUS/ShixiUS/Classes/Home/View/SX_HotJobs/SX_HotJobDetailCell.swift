//
//  SX_HotJobDetailCell.swift
//  ShixiUS
//
//  Created by heather on 2018/9/10.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  热门岗位详情  职位信息Cell

/*
 过去，你未曾出现
 我写情诗
 寻找世间的美好
 */

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
            make.left.top.equalToSuperview().offset(Margin-1)
            make.height.equalTo(19.FloatValue.IPAD_XValue)
        }).config({ (NAME) in
            NAME.sizeToFit()
            NAME.font      = UIFont.boldSystemFont(ofSize: 18)
            NAME.textColor = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
        })
        
        let Time = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.jobName!.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.left.equalTo(self.jobName!)
            make.height.equalTo(11.FloatValue.IPAD_XValue)
        }).config({ (TIME) in
            TIME.text      = "发布时间: "
            TIME.font      = UIFont.systemFont(ofSize: 10)
            TIME.textColor = UIColor.colorWithRGB(r: 153, g: 153, b: 153)
        })
        
        self.jobReleaseTime = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.height.centerY.equalTo(Time)
            make.left.equalTo(Time.snp.right).offset(5)
        }).config({ (RELEASE) in
            RELEASE.sizeToFit()
            RELEASE.font      = UIFont.systemFont(ofSize: 10)
            RELEASE.textColor = UIColor.colorWithRGB(r: 153, g: 153, b: 153)
        })
        
        let industryImage = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalTo(self.jobName!)
            make.top.equalTo(self.jobReleaseTime!.snp.bottom).offset(Margin)
            make.width.height.equalTo(14)
        }).config({ (INDUSTRYIV) in
            INDUSTRYIV.image = #imageLiteral(resourceName: "icon_hotJob_industry")
        })
        
        /// 行业
        self.jobIndustry = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.height.centerY.equalTo(industryImage)
            make.left.equalTo(industryImage.snp.right).offset(5)
        }).config({ (INDUSTRY) in
            INDUSTRY.sizeToFit()
            INDUSTRY.font      = UIFont.systemFont(ofSize: 13)
            INDUSTRY.textColor = UIColor.colorWithRGB(r: 102, g: 102, b: 102)
        })
        
        let palceImage = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.height.centerY.equalTo(industryImage)
            make.left.equalTo(self.jobIndustry!.snp.right).offset(5)
        }).config({ (PLACEIV) in
            PLACEIV.image = #imageLiteral(resourceName: "address")
        })
        
        self.jobPlace = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.height.centerY.equalTo(industryImage)
            make.left.equalTo(palceImage.snp.right).offset(5)
        }).config({ (PLACE) in
            PLACE.sizeToFit()
            PLACE.font      = UIFont.systemFont(ofSize: 13)
            PLACE.textColor = UIColor.colorWithRGB(r: 102, g: 102, b: 102)
        })
        
        let countImage = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.height.centerY.equalTo(industryImage)
            make.left.equalTo(self.jobPlace!.snp.right).offset(5)
        }).config({ (COUNTIV) in
            COUNTIV.image = #imageLiteral(resourceName: "icon_hotJob_peopleCount")
        })
        
        self.jobPeopleCount = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.height.centerY.equalTo(industryImage)
            make.left.equalTo(countImage.snp.right).offset(5)
        }).config({ (COUNT) in
            COUNT.sizeToFit()
            COUNT.font      = UIFont.systemFont(ofSize: 13)
            COUNT.textColor = UIColor.colorWithRGB(r: 102, g: 102, b: 102)
        })
        
        let fulltimeImage = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.height.centerY.equalTo(industryImage)
            make.left.equalTo(self.jobPeopleCount!.snp.right).offset(5)
        }).config({ (FULLTIMEIV) in
            FULLTIMEIV.image = #imageLiteral(resourceName: "icon_hotJob_fullTime")
        })
        
        /// 全职类型
        self.jobFullTime = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.height.centerY.equalTo(industryImage)
            make.left.equalTo(fulltimeImage.snp.right).offset(5)
        }).config({ (FULLTIME) in
            FULLTIME.sizeToFit()
            FULLTIME.font      = UIFont.systemFont(ofSize: 13)
            FULLTIME.textColor = UIColor.colorWithRGB(r: 102, g: 102, b: 102)
        })
        
        
        let intershipImage = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.height.centerY.equalTo(industryImage)
            make.left.equalTo(self.jobFullTime!.snp.right).offset(5)
        }).config({ (INTERSHIPIV) in
            INTERSHIPIV.image = #imageLiteral(resourceName: "icon_hotJob_intership")
        })
        
        /// 实习类型
        self.jobInterShip = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.height.centerY.equalTo(industryImage)
            make.left.equalTo(intershipImage.snp.right).offset(5)
        }).config({ (INTERSHIP) in
            INTERSHIP.sizeToFit()
            INTERSHIP.font      = UIFont.systemFont(ofSize: 13)
            INTERSHIP.textColor = UIColor.colorWithRGB(r: 102, g: 102, b: 102)
        })
        
        
        let salaryImage = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.height.centerY.equalTo(industryImage)
            make.left.equalTo(self.jobInterShip!.snp.right).offset(5)
        }).config({ (SALARYIV) in
            SALARYIV.image = #imageLiteral(resourceName: "icon_hotJob_salary")
        })
        
        /// 薪资
        self.jobSalary = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.height.centerY.equalTo(industryImage)
            make.left.equalTo(salaryImage.snp.right).offset(5)
        }).config({ (SALARY) in
            SALARY.sizeToFit()
            SALARY.font      = UIFont.systemFont(ofSize: 13)
            SALARY.textColor = UIColor.colorWithRGB(r: 102, g: 102, b: 102)
        })
        
// ---------------------------------------------//-----------------------------------//-------------------------------------
        
        let lineView = UIView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(industryImage.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.left.equalToSuperview().offset(Margin)
            make.right.equalToSuperview().offset(-Margin)
            make.height.equalTo(0.5)
        }).config({ (LINE) in
            LINE.backgroundColor = UIColor.SX_LineColor()
        })
        
        /// 职位介绍
        self.jobIntroduce = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.left.right.equalTo(lineView)
        }).config({ (INTRODUCE) in
            INTRODUCE.sizeToFit()
            INTRODUCE.font          = UIFont.systemFont(ofSize: 10)
            INTRODUCE.textColor     = UIColor.colorWithRGB(r: 102, g: 153, b: 0)
            INTRODUCE.numberOfLines = 0
        })
    }
}
