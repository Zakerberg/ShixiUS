//
//  SX_TrainingScheduleCell.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/10/29.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  热们实训详情 日程安排cell

/*
 太想爱你是我压抑不了的念头
 想要全面占领你的喜怒哀愁
 你已征服了我
 可还不属于我
 叫我如何不去猜测你在想什么
 张信哲
 */
import UIKit

class SX_TrainingScheduleCell: UITableViewCell {

    var title: UILabel?
    var location: UILabel?
    var content: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        ConfigCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// ===============================================================================
// MARK: - ConfigCell
// ===============================================================================
extension SX_TrainingScheduleCell {
    func ConfigCell() {
 
        
        
        
        
        
    }
}

