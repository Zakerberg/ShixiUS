//
//  SX_TrainingCollectionViewCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/17/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  trainingViewCell 

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

/// Other Method
extension SX_TrainingCollectionViewCell {
    func configCell() {
        
        self.sourceImageView = UIImageView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
          make.top.left.right.equalToSuperview()
          make.height.equalTo(95)
        }).config({ (sourceImageView) in
            
        })
        
        self.sourceName = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.sourceImageView!.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(5)
        
        }).config({ (sourceName) in
            sourceName.numberOfLines = 0
            sourceName.textColor = UIColor.black
            sourceName.font = UIFont.systemFont(ofSize: 13)
        })
        
        self.certificateLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.sourceName!.snp.bottom).offset(5)
            make.left.equalTo(self.sourceName!)
        }).config({ (certificateLabel) in
            certificateLabel.textColor = UIColor.gray
            certificateLabel.font = UIFont.systemFont(ofSize: 12)
        })
        
        self.priceLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.certificateLabel!.snp.bottom).offset(5)
            make.left.equalTo(self.sourceName!.snp.left)
        }).config({ (priceLabel) in
            priceLabel.textColor = UIColor.SX_MainColor()
            priceLabel.font = UIFont.systemFont(ofSize: 13)
        })
    }
}








