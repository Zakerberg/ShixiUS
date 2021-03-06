//
//  SX_TrainingScheduleCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/10/29.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  热们实训详情 日程安排cell

/*
 太想爱你是我压抑不了的念头
 想要全面占领你的喜怒哀愁
 你已征服了我
 可还不属于我
 叫我如何不去猜测你在想什么
 张信哲 -- 太想爱你 
 */
import UIKit

class SX_TrainingScheduleCell: UITableViewCell {
    
    var title: UILabel?
    var day: UILabel?
    var content: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        ConfigCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

// ===============================================================================
// MARK: - ConfigCell
// ===============================================================================
extension SX_TrainingScheduleCell {
    func ConfigCell() {
        
        let cicleIV = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.top.equalToSuperview().offset(Margin)
            make.width.height.equalTo(10.FloatValue.IPAD_XValue)
        }).config({ (CICLE) in
            CICLE.image = #imageLiteral(resourceName: "icon_trainingDetail_Cicle")
        })
        
        let dialogIV = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.equalTo(cicleIV.snp.right).offset(5.FloatValue.IPAD_XValue)
            make.centerY.equalTo(cicleIV)
            make.width.equalTo(60.FloatValue.IPAD_XValue)
            make.height.equalTo(20.FloatValue.IPAD_XValue)
        }).config({ (DIALOG) in
            DIALOG.image = #imageLiteral(resourceName: "icon_trainingDetail_Dialog")
        })
        
        self.day = UILabel().addhere(toSuperView: dialogIV).layout(snapKitMaker: { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12.FloatValue.IPAD_XValue)
            make.right.equalToSuperview()
        }).config({ (DAY) in
            DAY.sizeToFit()
            DAY.font      = UIFont.boldSystemFont(ofSize: Margin)
            DAY.textColor = UIColor.white
        })
        
        self.title = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.centerY.equalTo(dialogIV)
            make.left.equalTo(dialogIV.snp.right).offset(8.FloatValue.IPAD_XValue)
            make.height.equalTo(self.day!)
        }).config({ (TITLE) in
            TITLE.sizeToFit()
            TITLE.font      = UIFont.boldSystemFont(ofSize: Margin)
            TITLE.textColor = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
        })
        
        self.content = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(dialogIV.snp.bottom).offset(Margin)
            make.left.equalTo(dialogIV)
            make.right.equalToSuperview().offset(-20.FloatValue.IPAD_XValue)
        }).config({ (CONTENT) in
            CONTENT.numberOfLines = 0
            CONTENT.font          = UIFont.systemFont(ofSize: 14)
            CONTENT.textColor     = UIColor.colorWithRGB(r: 102, g: 102, b: 102)
        })
    }
}

