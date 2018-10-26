//
//  SX_NoDataView.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/10/11.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

/*
 笑那浮华落尽
 月色如洗
 笑那悄然而逝 飞花万盏
 谁是那轻轻颤动的百合
 在你的清辉下亘古不变
 */

import UIKit

class SX_NoDataView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        self.backgroundColor = UIColor.SX_BackGroundColor()
        let imageV           = UIImageView(image: #imageLiteral(resourceName: "icon_nodata")).addhere(toSuperView: self).layout { (make) in
            make.center.equalToSuperview()
            }.config { (IMAGEV) in
        }
        
        _ = UILabel().addhere(toSuperView: self).layout { (make) in
            make.centerX.equalTo(imageV)
            make.top.equalTo(imageV.snp.bottom).offset(Margin)
            }.config { (LABEL) in
                LABEL.font      = UIFont.systemFont(ofSize: 16)
                LABEL.text      = "抱歉, 暂无数据"
                LABEL.textColor = UIColor.colorWithHexString(hex: "c2c9cf", alpha: 1)
        }
    }
}
