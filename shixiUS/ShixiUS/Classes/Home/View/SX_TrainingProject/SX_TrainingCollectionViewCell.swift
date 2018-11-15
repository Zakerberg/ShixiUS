//
//  SX_TrainingCollectionViewCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/17/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  首页的CollectionViewCell

/*
 问佛为何求不得，答曰无缘
 却为何又心心念念
 不执着不生娑婆
 */

import UIKit

class SX_TrainingCollectionViewCell: UICollectionViewCell {
    
    var sourceImageView: UIImageView?
    var priceLabel: UILabel?
    var sourceName: UILabel?
    var certificateLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// ===============================================================================
// MARK: - ConfigCell
// ===============================================================================
extension SX_TrainingCollectionViewCell {
    func configCell() {
        self.sourceImageView = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
          make.top.left.right.equalToSuperview()
          make.height.equalTo(95)
        }).config({ (SOURCEIMAGE) in
            
        })
        
        self.sourceName = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.sourceImageView!.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
        }).config({ (SOURCE) in
            SOURCE.numberOfLines = 0
            SOURCE.textColor     = UIColor.black
            SOURCE.font          = UIFont.systemFont(ofSize: 13)
        })
        
        self.certificateLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.sourceName!.snp.bottom).offset(5)
            make.left.equalTo(self.sourceName!)
        }).config({ (LABEL) in
            LABEL.textColor = UIColor.gray
            LABEL.font      = UIFont.systemFont(ofSize: 12)
        })
        
        self.priceLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.certificateLabel!.snp.bottom).offset(5)
            make.left.equalTo(self.sourceName!.snp.left)
        }).config({ (PRICE) in
            PRICE.textColor = UIColor.SX_MainColor()
            PRICE.font      = UIFont.systemFont(ofSize: 13)
        })
    }
}

