//
//  SX_TrainingCollectionViewCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/26/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  热门实训CollectionViewCell

import UIKit

class SX_TrainingCollectionViewCell: UICollectionViewCell {
    
    var titleLabel: UILabel?
    var moreButton: UIButton?
    var imageView: UIImageView?
    var descTitle: UILabel?
    var priceLabel: UILabel?
    var symbolLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView()  {
        
        self.titleLabel = UILabel()
        self.titleLabel?.addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
        }).config({ (titleLabel) in
            self.titleLabel?.text = "热门实训"
            self.titleLabel?.textColor = UIColor.gray
            self.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        })
        
        self.moreButton = UIButton()
        
        self.moreButton?.addhere(toSuperView: self.contentView.layout(snapKitMaker: { (make) in
            make.top.equalTo((self.titleLabel?.snp.top)!).offset(0)
            make.left.equalToSuperview().offset(-10)
        })).config({ (morebutton) in
            self.moreButton?.backgroundColor = UIColor.blue
            self.moreButton?.titleLabel?.text = "更多"
            self.moreButton?.titleLabel?.textAlignment = .right
        })
        
        
        self.imageView?.addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (imageView) in
            self.imageView?.image = UIImage(named: "")
        })
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    
    }
}

