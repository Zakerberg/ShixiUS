////
////  SX_ProjectDetailStarTimeCollectionViewCell.swift
////  ShixiUS
////
////  Created by Michael 柏 on 7/30/18.
////  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
////  项目详情出发时间CollectionViewCell
//
//import UIKit
//
//class SX_ProjectDetailStarTimeCollectionViewCell: UICollectionViewCell {
//    
//    var remainingCount: UILabel?
//    var dateLabel: UILabel?
//    var priceLabel: UILabel?
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//         configCell()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }    
//}
//
//// ==============================================================================================================================
//// MARK: - configCell
//// ==============================================================================================================================
//extension SX_ProjectDetailStarTimeCollectionViewCell {
//    
//    func configCell() {
//        
//        self.remainingCount = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
//            make.top.equalToSuperview().offset(8.FloatValue.IPAD_XValue)
//            make.width.equalToSuperview()
//            make.height.equalTo(Margin-3)
//        }).config({ (remainingCount) in
//            remainingCount.sizeToFit()
//            remainingCount.font = UIFont.systemFont(ofSize: 12)
//            remainingCount.textColor = UIColor.colorWithHexString(hex: "d30303", alpha: 1)
//            remainingCount.textAlignment = .center
//        })
//        
//        self.dateLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
//            make.top.equalTo(self.remainingCount!.snp.bottom).offset(8.FloatValue.IPAD_XValue)
//            make.width.equalToSuperview()
//            make.height.equalTo(12)
//        }).config({ (date) in
//            date.sizeToFit()
//            date.textAlignment = .center
//            date.textColor = UIColor.black
//            date.font = UIFont.systemFont(ofSize: 12)
//        })
//        
//        self.priceLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
//            make.top.equalTo(self.dateLabel!.snp.bottom).offset(8.FloatValue.IPAD_XValue)
//            make.width.equalToSuperview()
//            make.height.equalTo(12)
//        }).config({ (price) in
//            price.sizeToFit()
//            price.font = UIFont.systemFont(ofSize: 12)
//            price.textAlignment = .center
//            price.textColor = UIColor.black
//        })
//    }
//}
