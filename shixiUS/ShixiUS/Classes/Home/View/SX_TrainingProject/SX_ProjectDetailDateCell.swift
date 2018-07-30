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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCell()
        
        self.tripCollectionView?.delegate = self
        self.tripCollectionView?.dataSource = self
        self.tripCollectionView?.register(SX_ProjectDetailTripCollectionViewCell.self, forCellWithReuseIdentifier: projectDetailTripCellID)
        
        self.dateCollectionView?.delegate = self
        self.dateCollectionView?.dataSource = self
        self.dateCollectionView?.register(SX_ProjectDetailStarTimeCollectionViewCell.self, forCellWithReuseIdentifier: projectDetailTripCellID)
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
        
        let flowLayout = UICollectionViewFlowLayout()
        self.tripCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(Margin)
            make.right.equalToSuperview().offset(-Margin)
            make.height.equalTo(70.FloatValue.IPAD_XValue)
        }).config({ (tripCollectionView) in
            tripCollectionView.isScrollEnabled = false
            tripCollectionView.showsVerticalScrollIndicator = false
            tripCollectionView.tag = 0
        })
        
        let starTime = UILabel().addhere(toSuperView: self.contentView).layout { (make) in
            make.top.equalTo(self.tripCollectionView!.snp.bottom).offset(Margin)
            make.left.equalTo(self.tripCollectionView!)
            make.height.equalTo(Margin)
            }.config { (starTime) in
                starTime.text = "出发时间"
                starTime.font = UIFont.systemFont(ofSize: 14)
                starTime.sizeToFit()
                starTime.textColor = UIColor.black
        }
        
        self.dateCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
            
        }).config({ (dateCollectionView) in
            dateCollectionView.backgroundColor = UIColor.green
            dateCollectionView.isScrollEnabled = false
            dateCollectionView.showsVerticalScrollIndicator = false
            dateCollectionView.tag = 1
        })
        
        self.moreDateBtn = UIButton(type: .custom).addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            
        }).config({ (moreBtn) in
            
        })
    }
}

// ===============================================================================================================================
// MARK: - UICollectionViewDelegate
// ===============================================================================================================================
extension SX_ProjectDetailDateCell: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let projectDetailTripCell = collectionView.dequeueReusableCell(withReuseIdentifier: projectDetailTripCellID, for: indexPath)
        return projectDetailTripCell
        
    }
}

// ===============================================================================================================================
// MARK: - UICollectionViewDelegateFlowLayout
// ===============================================================================================================================
extension SX_ProjectDetailDateCell: UICollectionViewDelegateFlowLayout {
    
    
    
    
    
    
    
    
    
}





