//
//  SX_TrainingCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/20/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  热门实训,培训认证,实习户外 tableViewCell

import UIKit

let CollectionViewCellID = "CollectionViewCellID"

class SX_TrainingCell: UITableViewCell, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var titleLabel: UILabel?
    var moreButton: UIButton?
    var collectionView: UICollectionView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCell()
        
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.register(SX_TrainingCollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCellID)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
// ==================================================================================================================================
// MARK: - UICollectionViewDelegate
// ==================================================================================================================================
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    /// 返回对应的单元格
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID, for: indexPath) as! SX_TrainingCollectionViewCell
        
        cell.layer.shadowColor = UIColor.colorWithHexString(hex: "cccccc", alpha: 0.3).cgColor
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        cell.backgroundColor = UIColor.white
        
        cell.sourceImageView?.image = UIImage.init(named: "localImg3")
        cell.priceLabel?.text = "￥" + "2998.00"
        cell.sourceName?.text = "课程名称课程名称测试"
        cell.certificateLabel?.text = "职业技术证书"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SXLog("点击了CollectionView的\(indexPath.row)")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
// ==================================================================================================================================
// MARK: - UICollectionViewDelegateFlowLayout
// ==================================================================================================================================
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(165).IPAD_XValue, height: 165.FloatValue.IPAD_XValue)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: Margin, right: 0)
    }

// ==================================================================================================================================
// MARK: - configCell
// ==================================================================================================================================
    func configCell()  {
        
        self.titleLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.left.lessThanOrEqualTo(Margin)
            make.height.lessThanOrEqualTo(Margin)
        }).config({ (titleLabel) in
            titleLabel.sizeToFit()
            titleLabel.text = "热门实训--测试"
            titleLabel.textColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
            titleLabel.font = UIFont.systemFont(ofSize: 15)
        })
        
        self.moreButton = UIButton(type: .custom).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalToSuperview().offset(Margin)
            make.right.equalToSuperview().offset(-Margin)
            make.height.equalTo(Margin)
        }).config({ (moreButton) in
            moreButton.setImage(UIImage.init(named: "more"), for: .normal)
            moreButton.setTitle("更多", for: .normal)
            moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            moreButton.setTitleColor(UIColor.colorWithHexString(hex: "999999", alpha: 1), for: .normal)
            moreButton.titleEdgeInsets = UIEdgeInsetsMake(0, -moreButton.imageView!.bounds.size.width, 0, moreButton.imageView!.bounds.size.width)
            moreButton.imageEdgeInsets = UIEdgeInsetsMake(0, moreButton.titleLabel!.bounds.size.width, 0, -moreButton.titleLabel!.bounds.size.width)
        })
        
        let flowLayout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.titleLabel!.snp.bottom).offset(10)
            make.left.equalTo(self.titleLabel!)
            make.bottom.equalToSuperview().offset(-21)
            make.right.equalToSuperview().offset(-Margin)
        }).config({ (collectionView) in
            collectionView.isScrollEnabled = false
            collectionView.showsVerticalScrollIndicator = false
            collectionView.backgroundColor = UIColor.SX_BackGroundColor()
        })
    }
    
    /// reloadData
    func reloadData() {
        
    }
}
