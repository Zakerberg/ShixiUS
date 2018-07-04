//
//  SX_TrainingCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/20/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  热门实训,培训认证,实习户外 tableViewCell

import UIKit

private let CollectionViewCellID = "CollectionViewCellID"

class SX_TrainingCell: UITableViewCell {
    
    var titleLabel: UILabel?
    var moreButton: UIButton?
    var collectionView: UICollectionView?
    /// collectionView 高度约束
    var collectionViewHeight:NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.collectionView?.delegate = self as? UICollectionViewDelegate
        self.collectionView?.dataSource = self as? UICollectionViewDataSource
        self.collectionView?.register(SX_TrainingCollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCellID)
        configCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell()  {
        
        self.titleLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.left.equalToSuperview().offset(Margin)
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
        
        self.collectionView = UICollectionView().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.titleLabel!.snp.bottom).offset(10)
            
            
        }).config({ (collectionView) in

              collectionView.backgroundColor = UIColor.red
        })
    }
}
