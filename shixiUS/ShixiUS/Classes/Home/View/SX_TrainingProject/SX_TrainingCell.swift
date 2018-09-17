//
//  SX_TrainingCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/20/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  热门实训,培训认证,实习户外 tableViewCell

/*
 你在，我的情诗为你
 你走，我写自己
 写我想你
 */

import UIKit

let CollectionViewCellID = "CollectionViewCellID"

protocol SX_TrainingCellDelegate {
    func clickCell(item: Int)
}

class SX_TrainingCell: UITableViewCell, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var titleLabel: UILabel?
    var moreButton: UIButton?
    var collectionView: UICollectionView?
    
    // delegate
    var delegate: SX_TrainingCellDelegate?
    
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
    
// ===============================================================================
// MARK: - UICollectionViewDelegate
// ===============================================================================
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
        
        /*
         **
         *** 此方法对应下面的Extension
         
         let tapSingle = UITapGestureRecognizer(target: self, action: #selector(Tap(_:)))
         tapSingle.numberOfTapsRequired = 1
         tapSingle.numberOfTouchesRequired = 1
         cell.addGestureRecognizer(tapSingle)
         */
        
        cell.sourceImageView?.image = #imageLiteral(resourceName: "localImg3")
        cell.priceLabel?.text = "￥" + "2998.00"
        cell.sourceName?.text = "课程名称课程名称测试"
        cell.certificateLabel?.text = "职业技术证书"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SXLog("点击了CollectionView的\(indexPath.section)---\(indexPath.row)")
        
        self.delegate?.clickCell(item: indexPath.section)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
    // =============================================================================================
    // MARK: - UICollectionViewDelegateFlowLayout
    // =============================================================================================
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(165).IPAD_XValue, height: 165.FloatValue.IPAD_XValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: Margin, right: 0)
    }
    
    // =============================================================================================
    // MARK: - configCell
    // =============================================================================================
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
            moreButton.setTitle("更多 ", for: .normal)
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

// =============================================================================================
// MARK: - 查找所在的ViewController
// =============================================================================================
extension SX_TrainingCell {
    
/*
     MARK: - 查找所在的ViewController
     func responderViewController() -> UIViewController? {
     for view in sequence(first: self.superview, next: {$0?.superview}) {
     if let responder = view?.next {
     if responder.isKind(of: UIViewController.self) {
     return responder as? UIViewController
     }
     }
     }
     return nil
     }
     
     @objc func Tap(_ recognizer:UITapGestureRecognizer) {
     // MARK: - secondVC是目标页面
     let secondVC = SX_ProjectDetailController()
     // MARK: - firstVC是所在页面
     let firstVC = self.responderViewController()
     firstVC?.navigationController?.pushViewController(secondVC, animated: true)
     }
     */

}


