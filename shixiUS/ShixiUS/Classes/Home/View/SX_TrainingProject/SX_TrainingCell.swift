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
import SwiftyJSON

let CollectionViewCellID = "CollectionViewCellID"

protocol SX_TrainingCellDelegate {
    func clickCell(item: String)
}

class SX_TrainingCell: UITableViewCell, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var titleLabel: UILabel?
    var moreButton: UIButton?
    var collectionView: UICollectionView?
    
    var trainModels: [SX_HomeTrainModel]?
    var trainingModels:[SX_HomeTrainingModel]?
    
    // delegate
    var delegate: SX_TrainingCellDelegate?
    
    var id:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCell()
        
        self.collectionView?.delegate   = self
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
        return self.trainModels?.count ?? self.trainingModels?.count ?? 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.trainModels?.count ?? self.trainingModels?.count ?? 2
    }
    
    /// 返回对应的单元格
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID, for: indexPath) as! SX_TrainingCollectionViewCell
        
        cell.layer.shadowColor = UIColor.colorWithHexString(hex: "cccccc", alpha: 0.3).cgColor
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        cell.backgroundColor = UIColor.white
        
        var index = 0;
        
        if indexPath.section == 0 && indexPath.row == 0 {
            index = 0
        }else if indexPath.section == 0 && indexPath.row == 1 {
            index = 1
        }else if indexPath.section == 0 && indexPath.row == 2 {
            index = 2
        }else if indexPath.section == 0 && indexPath.row == 3 {
            index = 3
        }
        
        if let trainModels = trainModels, trainModels.count >= 4 {
            
            let model = trainModels[index]
            cell.certificateLabel?.text = model.category
            if let url = URL(string: model.image ?? ""){
                cell.sourceImageView?.kf.setImage(with: url)
            }else{
                cell.sourceImageView?.image = #imageLiteral(resourceName: "icon_placeholdericon_Image")
            }
            cell.priceLabel?.text = ("￥" + model.price!)
            cell.sourceName?.text = model.name
            self.id               = model.id
        }
        
        if let trainingModels = trainingModels, trainingModels.count >= 4 {
            let model = trainingModels[index]
            
            if let url = URL(string: model.image ?? ""){
                cell.sourceImageView?.kf.setImage(with: url)
            }else{
                cell.sourceImageView?.image = #imageLiteral(resourceName: "icon_placeholdericon_Image")
            }
            self.id               = model.id
            cell.sourceName?.text = model.title
            cell.priceLabel?.text = ("￥" + model.price!)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SXLog("点击了CollectionView的\(indexPath.section)---\(indexPath.row)")
        
        self.delegate?.clickCell(item: self.id ?? "0")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
    // ===============================================================================
    // MARK: - UICollectionViewDelegateFlowLayout
    // ===============================================================================
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(165).IPAD_XValue, height: 165.FloatValue.IPAD_XValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: Margin, right: 0)
    }
    
    // ===============================================================================
    // MARK: - configCell
    // ===============================================================================
    func configCell()  {
        
        self.titleLabel = UILabel().addhere(toSuperView: self.contentView).layout(snapKitMaker: { (make) in
            make.top.left.lessThanOrEqualTo(Margin)
            make.height.lessThanOrEqualTo(Margin)
        }).config({ (TITLE) in
            TITLE.sizeToFit()
            TITLE.textColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
            TITLE.font = UIFont.systemFont(ofSize: 15)
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
}

// ===============================================================================
// MARK: - 1.查找所在的ViewController
// ===============================================================================
extension SX_TrainingCell {
    
    /*
     // MARK: - 查找所在的ViewController
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
