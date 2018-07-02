//
//  SX_TrainingCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/20/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  热门实训,培训认证,实习户外 tableViewCell

import UIKit
class SX_TrainingCell: UITableViewCell {
    
    var titleLabel: UILabel?
    var moreButton: UIButton?
    
    private lazy var collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.contentView.bounds.size.width, height: self.contentView.bounds.size.height), collectionViewLayout: flowLayout)
        
        collectionView.delegate = self as? UICollectionViewDelegate
        collectionView.dataSource = self as? UICollectionViewDataSource
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCellID")
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.colorWithHexString(hex: "f0f0f0", alpha: 0)
        
        return collectionView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell()  {
        
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
    }

    func reloadData() {
    
        
        
        
        
        
    }







}
