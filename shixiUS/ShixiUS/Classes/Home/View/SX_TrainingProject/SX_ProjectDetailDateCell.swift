//
//  SX_ProjectDetailDateCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/26/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  项目详情行程日期cell

import UIKit

let projectDetailTripCellID  = "projectDetailTripCellID"
let projectDetailStarTimeID  = "projectDetailStarTimeID"

class SX_ProjectDetailDateCell: UITableViewCell {
    
    var tripCollectionView: UICollectionView?
    var dateCollectionView: UICollectionView?
    var moreDateBtn: UIButton?
    
    var tripDataArr = [0,1,2,3]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCell()
        
        self.tripCollectionView?.delegate = self
        self.tripCollectionView?.dataSource = self
        //        self.tripCollectionView?.tag = 0
        self.tripCollectionView?.register(SX_ProjectDetailTripCollectionViewCell.self, forCellWithReuseIdentifier: projectDetailTripCellID)
        
        //        self.dateCollectionView?.delegate = self
        //        self.dateCollectionView?.dataSource = self
        //        self.dateCollectionView?.register(SX_ProjectDetailStarTimeCollectionViewCell.self, forCellWithReuseIdentifier: projectDetailStarTimeID)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

// ===============================================================================================================================
// MARK: - configCell()
// ===============================================================================================================================
extension SX_ProjectDetailDateCell {
    
    func configCell() {
        
        let flowLayout = SX_CollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: CGFloat(100).IPAD_XValue, height: 55.FloatValue.IPAD_XValue)
        self.tripCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalToSuperview().offset(10.FloatValue.IPAD_XValue)
            make.left.equalToSuperview().offset(Margin)
            make.right.equalToSuperview().offset(-Margin)
            make.height.equalTo(55.FloatValue.IPAD_XValue)
        }).config({ (tripCollectionView) in
            tripCollectionView.backgroundColor = UIColor.white
            tripCollectionView.alwaysBounceHorizontal = true
            tripCollectionView.showsVerticalScrollIndicator = false
            tripCollectionView.showsHorizontalScrollIndicator = false
            tripCollectionView.tag = 0
        })
        
        let starTime = UILabel().addhere(toSuperView: self.contentView).layout { (make) in
            make.top.equalTo(self.tripCollectionView!.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.left.equalTo(self.tripCollectionView!)
            make.height.equalTo(Margin)
            }.config { (starTime) in
                starTime.text = "出发时间"
                starTime.font = UIFont.systemFont(ofSize: 15)
                starTime.sizeToFit()
                starTime.textColor = UIColor.black
        }
        
        //        self.dateCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
        //               make.top.equalTo(starTime.snp.bottom).offset(10.FloatValue.IPAD_XValue)
        //               make.left.equalTo(starTime)
        //               make.right.equalToSuperview().offset(-80.FloatValue.IPAD_XValue)
        //               make.height.equalTo(75.FloatValue.IPAD_XValue)
        //        }).config({ (dateCollectionView) in
        //            dateCollectionView.backgroundColor = UIColor.green
        //            dateCollectionView.isScrollEnabled = false
        //            dateCollectionView.showsVerticalScrollIndicator = false
        //            dateCollectionView.tag = 1
        //        })
        //
        //        self.moreDateBtn = UIButton(type: .custom).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
        //            make.top.equalTo(starTime.snp.bottom).offset(10.FloatValue.IPAD_XValue)
        //            make.height.equalTo(self.dateCollectionView!)
        //            make.left.equalTo(self.dateCollectionView!.snp.right).offset(10.FloatValue.IPAD_XValue)
        //            make.right.equalToSuperview().offset(-10.FloatValue.IPAD_XValue)
        //        }).config({ (moreBtn) in
        //            moreBtn.backgroundColor = UIColor.yellow
        //
        //
        //        })
    }
}

// ===============================================================================================================================
// MARK: - UICollectionViewDelegate
// ===============================================================================================================================
extension SX_ProjectDetailDateCell: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tripDataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let tripCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: projectDetailTripCellID, for: indexPath)
        
//        let view = UIView()
//        view.backgroundColor = UIColor.SX_MainColor()
//        tripCollectionViewCell.selectedBackgroundView = view
//
//
//        if tripCollectionViewCell.isSelected == true {
//
//            tripCollectionViewCell.backgroundColor = UIColor.SX_MainColor()
//        }else{
//
            tripCollectionViewCell.backgroundColor = UIColor.colorWithHexString(hex: "e6e6e6", alpha: 1)
//        }
        
        tripCollectionViewCell.layer.masksToBounds = true
        tripCollectionViewCell.layer.cornerRadius  = 6
        
        
        return tripCollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SXLog("点击项目详情界面 行程CollectionView  ---- \(indexPath.row)")
        
                let tripCell = collectionView.cellForItem(at: indexPath)
        
//                let tripModel = self.tripDataArr[indexPath.row]
//
//                if tripModel.isSelected == true {
//                    tripCell?.backgroundColor = UIColor.SX_MainColor()
//                } else{
//                    tripCell?.backgroundColor = UIColor.colorWithHexString(hex: "e6e6e6", alpha: 1)
//                }
        
        
        collectionView.reloadData()
        
    }
}

// ===============================================================================================================================
// MARK: - UICollectionViewDelegateFlowLayout
// ===============================================================================================================================
extension SX_ProjectDetailDateCell: UICollectionViewDelegateFlowLayout {
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        return CGSize(width: CGFloat(100).IPAD_XValue, height: 55.FloatValue.IPAD_XValue)
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        return UIEdgeInsets(top: 0, left: Margin+6, bottom: 0, right: 0)
    //    }
}

// ===============================================================================================================================
// MARK: - Other Method
// ===============================================================================================================================
extension SX_ProjectDetailDateCell {
    
    func changeTripItemColor(Item: Int) {
        
    }
}

// ===============================================================================================================================
// MARK: - SX_CollectionViewFlowLayout
// ===============================================================================================================================
class SX_CollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        scrollDirection = UICollectionViewScrollDirection.horizontal
    }
    //（该方法默认返回false） 返回true  frame发生改变就重新布局  内部会重新调用prepare 和layoutAttributesForElements InRect
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
