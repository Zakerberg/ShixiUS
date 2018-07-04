//
//  SX_TrainingCollectionViewCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/26/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  热门实训等... CollectionViewCell

import UIKit

class SX_TrainingCollectionViewCell: UICollectionViewCell {

    var sourceImageView:UIImageView?
    var sourceTitle:UILabel?
    var priceLabel:UILabel?
    // 课程下面的title
    var certificateTitle:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 配置Cell
    func configCell() {
        
        self.sourceImageView?.addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(50)
        }).config({ (sourceImageView) in
            sourceImageView.image = UIImage(named: "placeholder")
        })
        
        self.sourceTitle?.addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.lessThanOrEqualTo(self.sourceImageView!.snp.bottom).offset(Margin)
            make.left.lessThanOrEqualTo(self.contentView).offset(Margin)
        }).config({ (sourceTitle) in
            sourceTitle.text = "课程标题 测试测试课程标题 测试测试课程标题 测试测试课程标题 测试测试000"
            sourceTitle.font = UIFont.boldSystemFont(ofSize: 12)
            sourceTitle.textColor = UIColor.black
            sourceTitle.numberOfLines = 0
        })
        
        self.certificateTitle?.addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.lessThanOrEqualTo(self.sourceTitle!.snp.bottom).offset(Margin)
            make.right
            
        }).config({ (certificateTitle) in
            certificateTitle.text = "证书标题 测试证书000"
            certificateTitle.font = UIFont.systemFont(ofSize: 7)
            certificateTitle.textColor = UIColor.gray
        })
        
        self.priceLabel?.addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.lessThanOrEqualTo(self.certificateTitle!.snp.bottom).offset(Margin)
        }).config({ (priceLabel) in
            priceLabel.text = "人名币2000元"
            priceLabel.textColor = UIColor.SX_MainColor()
            priceLabel.font = UIFont.boldSystemFont(ofSize: 10)
        })
    }
}
