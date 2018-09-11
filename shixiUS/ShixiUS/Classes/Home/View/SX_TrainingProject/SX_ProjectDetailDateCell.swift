////
////  SX_ProjectDetailDateCell.swift
////  ShixiUS
////
////  Created by Michael 柏 on 7/26/18.
////  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
////  项目详情行程日期cell
//
//import UIKit
//
//let projectDetailTripCellID  = "projectDetailTripCellID"
//let projectDetailStarTimeID  = "projectDetailStarTimeID"
//
//class SX_ProjectDetailDateCell: UITableViewCell {
//
//    var tripCollectionView: UICollectionView?
//    var dateCollectionView: UICollectionView?
//    var moreDateBtn: UIButton?
//
//    var tripDataArr = [0,1,2,3]
//    var starTimeDataArr = [5,6,7,8]
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        configCell()
//
//        self.tripCollectionView?.delegate = self
//        self.tripCollectionView?.dataSource = self
//        self.tripCollectionView?.tag = 0
//        self.tripCollectionView?.register(SX_ProjectDetailTripCollectionViewCell.self, forCellWithReuseIdentifier: projectDetailTripCellID)
//
//        self.dateCollectionView?.delegate = self
//        self.dateCollectionView?.dataSource = self
//        self.dateCollectionView?.tag = 1
//        self.dateCollectionView?.register(SX_ProjectDetailStarTimeCollectionViewCell.self, forCellWithReuseIdentifier: projectDetailStarTimeID)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//}
//
//// ===============================================================================================================================
//// MARK: - configCell()
//// ===============================================================================================================================
//extension SX_ProjectDetailDateCell {
//
//    func configCell() {
//
//        let flowLayout = SX_CollectionViewFlowLayout()
//        flowLayout.itemSize = CGSize(width: CGFloat(100).IPAD_XValue, height: 55.FloatValue.IPAD_XValue)
//        self.tripCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
//            make.top.equalToSuperview().offset(10.FloatValue.IPAD_XValue)
//            make.left.equalToSuperview().offset(Margin)
//            make.right.equalToSuperview().offset(-Margin)
//            make.height.equalTo(55.FloatValue.IPAD_XValue)
//        }).config({ (tripCollectionView) in
//            tripCollectionView.backgroundColor = UIColor.white
//            tripCollectionView.alwaysBounceHorizontal = true
//            tripCollectionView.showsVerticalScrollIndicator = false
//            tripCollectionView.showsHorizontalScrollIndicator = false
//        })
//
//        let starTime = UILabel().addhere(toSuperView: self.contentView).layout { (make) in
//            make.top.equalTo(self.tripCollectionView!.snp.bottom).offset(10.FloatValue.IPAD_XValue)
//            make.left.equalTo(self.tripCollectionView!)
//            make.height.equalTo(Margin)
//            }.config { (starTime) in
//                starTime.text = "出发时间"
//                starTime.font = UIFont.systemFont(ofSize: 15)
//                starTime.sizeToFit()
//                starTime.textColor = UIColor.black
//        }
//
//        let dateFlowLayout = UICollectionViewFlowLayout()
//        dateFlowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
//        dateFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 0)
//        dateFlowLayout.itemSize = CGSize(width: CGFloat(65).IPAD_XValue, height: 65.FloatValue.IPAD_XValue)
//        self.dateCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: dateFlowLayout).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
//            make.top.equalTo(starTime.snp.bottom).offset(10.FloatValue.IPAD_XValue)
//            make.left.equalTo(starTime)
//            make.right.equalToSuperview().offset(-60.FloatValue.IPAD_XValue)
//            make.height.equalTo(65.FloatValue.IPAD_XValue)
//        }).config({ (dateCollectionView) in
//            dateCollectionView.backgroundColor = UIColor.white
//            dateCollectionView.showsVerticalScrollIndicator = false
//            dateCollectionView.showsHorizontalScrollIndicator = false
//        })
//
//        self.moreDateBtn = UIButton(type: .custom).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
//            make.top.equalTo(starTime.snp.bottom).offset(10.FloatValue.IPAD_XValue)
//            make.height.equalTo(self.dateCollectionView!)
//            make.left.equalTo(self.dateCollectionView!.snp.right).offset(5.FloatValue.IPAD_XValue)
//            make.right.equalToSuperview().offset(-10.FloatValue.IPAD_XValue)
//        }).config({ (moreBtn) in
//            moreBtn.backgroundColor = UIColor.white
//            moreBtn.setTitle("更多日期", for: .normal)
//            moreBtn.setImage(UIImage.init(named: "arrow"), for: .normal)
//            moreBtn.setTitleColor(UIColor.yellow, for: .normal)
//        })
//    }
//}
//
//// ===============================================================================================================================
//// MARK: - UICollectionViewDelegate
//// ===============================================================================================================================
//extension SX_ProjectDetailDateCell: UICollectionViewDelegate,UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        if collectionView.tag == 0 {
//            return self.tripDataArr.count
//        }
//        return self.starTimeDataArr.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        if collectionView.tag == 0 {
//
//            let tripCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: projectDetailTripCellID, for: indexPath) as! SX_ProjectDetailTripCollectionViewCell
//            tripCollectionViewCell.backgroundColor = UIColor.colorWithHexString(hex: "e6e6e6", alpha: 1)
//            tripCollectionViewCell.layer.masksToBounds = true
//            tripCollectionViewCell.layer.cornerRadius  = 6
//            tripCollectionViewCell.tripName?.text = "行程A"
//            tripCollectionViewCell.tripArrange?.text = "5天行程安排"
//
//            return tripCollectionViewCell
//        }
//
//        let starTimeColltionCell = collectionView.dequeueReusableCell(withReuseIdentifier: projectDetailStarTimeID, for: indexPath) as! SX_ProjectDetailStarTimeCollectionViewCell
//        starTimeColltionCell.backgroundColor = UIColor.white
//        starTimeColltionCell.layer.masksToBounds  = true
//        starTimeColltionCell.layer.cornerRadius   = 6
//        starTimeColltionCell.layer.borderWidth    = 0.5
//        starTimeColltionCell.layer.borderColor    = UIColor.gray.cgColor
//        starTimeColltionCell.remainingCount?.text = "余3"
//        starTimeColltionCell.dateLabel?.text      = "06.14"
//        starTimeColltionCell.priceLabel?.text     = "￥5888"
//
//        return starTimeColltionCell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        if collectionView.tag == 0 {
//            SXLog("点击项目详情界面 行程CollectionView  ---- \(indexPath.row)")
//            
//
//        }
//
//        SXLog("点击项目详情界面 出发时间CollectionView  ---- \(indexPath.row)")
//
//        let tripCell = collectionView.cellForItem(at: indexPath)
//
//        //      let tripModel = self.tripDataArr[indexPath.row]
//        //      if tripModel.isSelected == true {
//        //      tripCell?.backgroundColor = UIColor.SX_MainColor()
//        //       } else {
//        //       tripCell?.backgroundColor = UIColor.colorWithHexString(hex: "e6e6e6", alpha: 1)
//        //       }
//
//        collectionView.reloadData()
//    }
//}
//
//// ===============================================================================================================================
//// MARK: - UICollectionViewDelegateFlowLayout
//// ===============================================================================================================================
//extension SX_ProjectDetailDateCell: UICollectionViewDelegateFlowLayout {
//
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        return CGSize(width: CGFloat(65).IPAD_XValue, height: 65.FloatValue.IPAD_XValue)
////    }
//
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
////        return UIEdgeInsets(top: 0, left: Margin+6, bottom: 0, right: 0)
////    }
//}
//
//// ===============================================================================================================================
//// MARK: - Other Method
//// ===============================================================================================================================
//extension SX_ProjectDetailDateCell {
//
//    func changeTripItemColor(Item: Int) {
//
//    }
//}
//
//// ===============================================================================================================================
//// MARK: - SX_CollectionViewFlowLayout
//// ===============================================================================================================================
//class SX_CollectionViewFlowLayout: UICollectionViewFlowLayout {
//
//    override func prepare() {
//        super.prepare()
//        scrollDirection = UICollectionViewScrollDirection.horizontal
//    }
//    //（该方法默认返回false） 返回true  frame发生改变就重新布局  内部会重新调用prepare 和layoutAttributesForElements InRect
//    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        return true
//    }
//}
//
