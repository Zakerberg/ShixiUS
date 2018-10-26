//
//  SX_TrainDetailTeacherCell.swift
//  ShixiUS
//
//  Created by heather on 2018/10/23.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  培训认证里面的 老师 列表cell

/*
 在所有的情诗中我只写了其中最轻的一行
 在最轻的一行里
 我只写了你最轻的名字
 */

import UIKit

class SX_TrainDetailTeacherCell: UITableViewCell {
    
    var icon:UIImageView?
    var name:UILabel?
    /// 天津大学, 硕士, 注册会计师
    var info:UILabel?
    
    var describe:UILabel?
    
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

// ===============================================================================
// MARK: - ConfigCell()
// ===============================================================================
extension SX_TrainDetailTeacherCell {
    func ConfigCell() {
        
        self.icon = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.top.equalToSuperview().offset(Margin)
            make.height.width.equalTo(60.FloatValue.IPAD_XValue)
        }).config({ (ICON) in
            ICON.layer.masksToBounds = true
            ICON.image = #imageLiteral(resourceName: "icon")
            ICON.layer.cornerRadius  = 30
        })
        
        self.name = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.icon!.snp.top).offset(Margin)
            make.left.equalTo(self.icon!.snp.right).offset(10.FloatValue.IPAD_XValue)
            make.height.equalTo(Margin)
        }).config({ (NAME) in
            NAME.sizeToFit()
            NAME.textColor     = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
            NAME.textAlignment = .left
        })
        
        self.info = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.name!.snp.bottom).offset(5.FloatValue.IPAD_XValue)
            make.left.equalTo(self.name!)
            make.height.equalTo(13.FloatValue.IPAD_XValue)
        }).config({ (INFO) in
            INFO.sizeToFit()
            INFO.textColor     = UIColor.colorWithRGB(r: 102, g:102 , b: 102)
            INFO.textAlignment = .left
        })
        
        let line = UIView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.icon!.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.left.equalToSuperview().offset(Margin)
            make.right.equalToSuperview().offset(-Margin)
            make.height.equalTo(0.5)
        }).config({ (LINE) in
            LINE.backgroundColor = UIColor.SX_LineColor()
        })
        
        self.describe = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(line.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.left.equalTo(self.icon!)
            make.right.equalToSuperview().offset(-Margin)
        }).config({ (DESCRIBE) in
            DESCRIBE.numberOfLines = 0
            DESCRIBE.textColor     = UIColor.colorWithRGB(r: 102, g: 102, b: 102)
            DESCRIBE.font          = UIFont.systemFont(ofSize: 14)
        })
    }
}
