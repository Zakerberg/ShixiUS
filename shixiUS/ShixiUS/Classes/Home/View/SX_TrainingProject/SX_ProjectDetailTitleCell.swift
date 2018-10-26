//
//  SX_ProjectDetailTitleCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/27/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  项目详情 title Cell

/*
 你的名字是世间最温柔的结
 将一笔一画都绑在了我的心里
 我解不开，也不想解
 */

import UIKit

class SX_ProjectDetailTitleCell: UITableViewCell {
    
    var projectName : UILabel?
    var projectCity : UILabel?
    var projectContent: UILabel?
    var projectPrice: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCell()
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
// MARK: - configCell()
// ===============================================================================
extension SX_ProjectDetailTitleCell {
    
    func configCell() {
        
        self.projectName = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalToSuperview().offset(Margin)
            make.left.equalToSuperview().offset(Margin)
            make.height.equalTo(Margin+2)
        }).config({ (NAME) in
            NAME.sizeToFit()
            NAME.font      = UIFont.boldSystemFont(ofSize: 16)
            NAME.textColor = UIColor.black
        })
        
        self.projectContent = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.projectName!.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.left.equalTo(self.projectName!)
            make.right.equalToSuperview().offset(-Margin)
        }).config({ (CONTENT) in
            CONTENT.numberOfLines = 0
            CONTENT.textColor     = UIColor.colorWithRGB(r: 102, g: 102, b: 102)
            CONTENT.font          = UIFont.systemFont(ofSize: 14)
        })
        
        self.projectCity = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.projectContent!.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.left.equalTo(self.projectName!)
        }).config({ (CITY) in
            CITY.sizeToFit()
            CITY.textColor  = UIColor.gray
            CITY.font       = UIFont.systemFont(ofSize: 13)
        })
        
        self.projectPrice   = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.projectCity!.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.left.equalTo(self.projectName!)
        }).config({ (PRICE) in
            PRICE.sizeToFit()
            PRICE.font      = UIFont.boldSystemFont(ofSize: 14)
            PRICE.textColor = UIColor.red
        })
    }
}
