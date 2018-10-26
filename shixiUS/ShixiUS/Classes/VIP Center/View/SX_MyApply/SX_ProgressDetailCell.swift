//
//  SX_ProgressDetailCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/10/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  申请进度详情Cell

/*
 无论世界多污秽
 有多少虚伪不纯粹
 都有我在你身边
 拼死给你一方碧海蓝天
 */

import UIKit

class SX_ProgressDetailCell: UITableViewCell {
    
//    var progressTitle   : UILabel?
//    var progressDes     : UILabel? // 详情
//    var progressPoint   : UIImageView?

    
    var leftRoundImageView: UIImageView?
    var leftLineView: UIView?
    var progressTitle: UILabel?
    var contentLabel: UILabel?
    var bottomLine: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     //   ConfigCell()
        configCell1()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

// ========================================================================
// MARK: - ConfigCell
// ========================================================================
extension SX_ProgressDetailCell{
    
//    func ConfigCell() {
//
//        self.progressPoint = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
//            make.left.top.equalToSuperview().offset(Margin)
//
//        }).config({ (POINT) in
//            POINT.sizeToFit()
//        })
//
//        self.progressTitle = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
//            make.centerY.equalTo(self.progressPoint!)
//            make.left.equalTo(self.progressPoint!.snp.right).offset(Margin)
//            make.height.equalTo(15.FloatValue.IPAD_XValue)
//        }).config({ (TITLE) in
//            TITLE.sizeToFit()
//            TITLE.font = UIFont.boldSystemFont(ofSize: 14)
//        })
//
//        self.progressDes = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
//            make.top.equalTo(self.progressTitle!.snp.bottom).offset(10.FloatValue.IPAD_XValue)
//            make.left.equalTo(self.progressTitle!)
//            make.right.equalToSuperview().offset(-Margin)
//        }).config({ (DES) in
//            DES.sizeToFit()
//            DES.numberOfLines = 0
//            DES.lineBreakMode = .byWordWrapping
//            DES.font = UIFont.systemFont(ofSize: 14)
//        })
//    }
}


// ========================================================================
// MARK: -
// ========================================================================
extension SX_ProgressDetailCell {
    
    func configCell1() {

        
        
        
        
    }
}





