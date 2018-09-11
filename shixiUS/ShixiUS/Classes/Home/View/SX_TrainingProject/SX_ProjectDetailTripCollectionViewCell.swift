////
////  SX_ProjectDetailTripCollectionViewCell.swift
////  ShixiUS
////
////  Created by Michael 柏 on 7/30/18.
////  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
////  项目详情行程CollectionViewCell
//
//import UIKit
//
//class SX_ProjectDetailTripCollectionViewCell: UICollectionViewCell {
//    
//    var tripName: UILabel?
//    var tripArrange: UILabel?
//    
//    override init(frame: CGRect) {
//       super.init(frame: frame)
//        configCell()
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
//extension SX_ProjectDetailTripCollectionViewCell {
//    
//    func configCell() {
//        
//        /// 行程A
//        self.tripName = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
//            make.top.equalToSuperview().offset(8.FloatValue.IPAD_XValue)
//            make.width.equalToSuperview()
//            make.height.equalTo(Margin+3)
//        }).config({ (tripName) in
//            tripName.sizeToFit()
//            tripName.textAlignment = .center
//            tripName.textColor = UIColor.black
//            tripName.font = UIFont.boldSystemFont(ofSize: 15)
//       })
//        
//        /// 5天日程安排
//        self.tripArrange = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
//            make.top.equalTo(self.tripName!.snp.bottom).offset(8.FloatValue.IPAD_XValue)
//            make.width.equalTo(self.tripName!)
//            make.height.equalTo(12.FloatValue.IPAD_XValue)
//        }).config({ (tripArrange) in
//            tripArrange.sizeToFit()
//            tripArrange.font = UIFont.systemFont(ofSize: 14)
//            tripArrange.textColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
//            tripArrange.textAlignment = .center
//        })
//    }
//}
//
//
