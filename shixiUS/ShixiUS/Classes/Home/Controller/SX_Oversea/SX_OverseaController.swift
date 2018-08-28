//
//  SX_OverseaController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  海外就业

/*
 如果我要的你一开始就给了我
 那我就失去了与你纠缠不休的理由
 你也知道
 我没有多余的故事
 也只有你这一件往事
 */

import UIKit

class SX_OverseaController: UIViewController {
    
// ======================================================================================================================
// MARK: - Lazy
// ======================================================================================================================
    lazy var tableView: UITableView = {
        let table:UITableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: self.view.bounds.height), style: .grouped)
        table.contentInset = UIEdgeInsetsMake(-CGFloat(kNavH), 0, 0, 0);
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    lazy var overseaScrollerView: SX_CycleScrollerView = {
        let frame = CGRect(x: 0, y: -IMAGE_HEIGHT, width: SCREEN_WIDTH, height: IMAGE_HEIGHT)
        let cycleView = SX_CycleScrollerView(frame: frame, type: .LOCAL, imgs: nil, descs: nil)
        cycleView.delegate = self
        return cycleView
    }()
    
    
    var titleDataArr = ["关于我们","我们的服务","我们的宗旨"]
    
    var contentDataArr = ["     实习科技是基于大数据应用的中国首家全球化就业、实习、职场教育和培训的一站式人力资源服务平台。实习网的核心业务是基于就业与实习为切入，整合全国高等院校、高校学生和优秀企业资源，运用信息化智能化大数据应用技术建立的平台系统，为就业实习人才提供智能简历、为企业精准匹配人才等线上线下为一体的人力资源服务。目前，实习网已经成为企业定制化人才培养，定制化人才批量输出，实习与就业全球化和职场教育与培训一站式服务综合平台，为中国的国际化人才培养，为“一带一路”沿线国家发展输送优秀人才做出贡献。",
                          
                          " ● 对于那些急切寻找工作的毕业生来说，通过我们的专属定制服务可以更快、更准确的对接业界知名企业，提升个人竞争力，获得实习或正式工作岗位。\n\n ● 通过专业顾问与候选人进行沟通和模拟面试，对个人竞争力和求职能力进行评估，给出评估反馈，进行课程规划，提出短板技能的学习建议，帮助锁定目标行业岗位。\n\n ● 对简历文书和英文求职信进行精修，添加岗位关键性词汇，深度挖掘个人优势和潜力，对经历进行润色提炼，全面提升履历质量。\n\n ● 设计定制化的求职规划方案，实时掌握行业招聘动态，精准对接内推职位，提供一手独家内推渠道及精选岗位。\n\n ● 基于岗位要求进行面试辅导，准备模拟面试并给出建议。\n\n ● 全额退款机制保障，签订服务合同协议，若最终未被企业录取，所交费用将会全额退款.",
                          
                          "     实习网的战略方针是 “从中国发起，向全球发展”，最终成为全球最大的实习和就业平台。其目标是建立和发展中国实习文化和实习标准，提高学生素质，培养具有社会责任感、企业精神文化、全球化视野、和生活综合化的高素质学生，为社会和企业输送合格实用的人才。\n 公司口号：体验你的未来，全球机会！\n Explore Your Future, Global Opportunities! \n 公司指导原则：SHIXI \n Our Philosophy:Serve 服务 / Honor 荣誉 / Initiative 主动性 / X-Cross Skills 综合能力 / Innovation 创造力"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let localImgs = ["image11","image12","image13","image14","image15"]
        
        overseaScrollerView.localImgArray = localImgs
        view.addSubview(tableView)
        tableView.tableHeaderView = overseaScrollerView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        tableView.delegate = nil
        print("deinit-----")
    }
}

// =========================================================================================================================
// MARK: - Other Method
// =========================================================================================================================
extension SX_OverseaController {
    
    
    
}

// =========================================================================================================================
// MARK: - Other Method 2 响应
// =========================================================================================================================
extension SX_OverseaController {
    
    
}

// ========================================================================================================================
// MARK: - UITableViewDelegate
// ========================================================================================================================
extension SX_OverseaController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return  4
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 {
            
            let cell = SX_UsInOverseaCell(style: .default, reuseIdentifier: "usinOverCellID")
             cell.titleLabel?.text = self.titleDataArr[indexPath.section]
             cell.contentLabel?.text = self.contentDataArr[indexPath.section]
           
            return cell
            
        } else if indexPath.section == 3 {
            let cell = SX_HotJobsCell(style: .default, reuseIdentifier: "hotJobCellID")
            cell.selectionStyle = .none
            
            return cell
        }
        
        let shixiTrainingCell = SX_TrainingCell(style: .default, reuseIdentifier: "shixiTrainingCellId")
        shixiTrainingCell.selectionStyle = .none
        
        return shixiTrainingCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return (UILabel.SX_getSpaceLabelHeight(self.contentDataArr[indexPath.section] as NSString, font: UIFont.systemFont(ofSize: 14), width: SCREEN_WIDTH-20, space: 0, zpace: 0)) + 40

        } else if indexPath.section == 1 {
            return UILabel.SX_getSpaceLabelHeight(self.contentDataArr[indexPath.section] as NSString, font: UIFont.systemFont(ofSize: 14), width: SCREEN_WIDTH-20, space: 0, zpace: 0) + 40
            
        } else if indexPath.section == 2 {
            return UILabel.SX_getSpaceLabelHeight(self.contentDataArr[indexPath.section] as NSString, font: UIFont.systemFont(ofSize: 14), width: SCREEN_WIDTH-20, space: 0, zpace: 0) + 40
            
        } else if indexPath.section == 3{
             return 90.FloatValue.IPAD_XValue
        }
        
        return 400.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNormalMagnitude
            
        } else if section == 3{
            return 42
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 3 {
            let hotJobHeaderView = UIView()
            hotJobHeaderView.backgroundColor = UIColor.white
            
            let hotTitle = UILabel().addhere(toSuperView: hotJobHeaderView).layout { (make) in
                make.top.left.equalTo(hotJobHeaderView).offset(Margin)
                make.height.lessThanOrEqualTo(Margin)
                }.config { (hotTitle) in
                    hotTitle.sizeToFit()
                    hotTitle.text = "热门岗位--测试"
                    hotTitle.font = UIFont.systemFont(ofSize: 15)
                    hotTitle.textColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
            }
            
            let _ = UIButton().addhere(toSuperView: hotJobHeaderView).layout { (make) in
                make.top.equalTo(hotTitle.snp.top)
                make.height.centerY.equalTo(hotTitle)
                make.right.equalToSuperview().offset(-Margin)
                }.config { (moreButton) in
                    moreButton.setImage(UIImage.init(named: "more"), for: .normal)
                    moreButton.setTitle("更多", for: .normal)
                    moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                    moreButton.setTitleColor(UIColor.colorWithHexString(hex: "999999", alpha: 1), for: .normal)
                    moreButton.titleEdgeInsets = UIEdgeInsetsMake(0, -moreButton.imageView!.bounds.size.width, 0, moreButton.imageView!.bounds.size.width)
                    moreButton.imageEdgeInsets = UIEdgeInsetsMake(0, moreButton.titleLabel!.bounds.size.width, 0, -moreButton.titleLabel!.bounds.size.width)
                    moreButton.rx.tap.subscribe(onNext: { (self) in
                        SXLog("进入更多界面")
                    }, onError: { (error) in
                        
                    }, onCompleted: nil, onDisposed: nil)
            }
            return hotJobHeaderView
        }
        return UIView()
    }
}

// =======================================================================================================================
// MARK: - UIScrollViewDelegate
// =======================================================================================================================
extension SX_OverseaController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let offsetY = scrollView.contentOffset.y
        if (offsetY > NAVBAR_COLORCHANGE_POINT) {
            let alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / CGFloat(kNavH)
            navBarBackgroundAlpha = alpha
            navBarTintColor = UIColor.white.withAlphaComponent(alpha)
            navBarTitleColor = UIColor.white.withAlphaComponent(alpha)
            statusBarStyle = .default
            title = "海外就业"
        } else {
            navBarBackgroundAlpha = 0
            navBarTintColor = .clear
            navBarTitleColor = .clear
            statusBarStyle = .lightContent
            title = "海外就业"
        }
    }
}

// =======================================================================================================================
// MARK: - SXCycleScrollerViewDelegate
// =======================================================================================================================
extension SX_OverseaController: SXCycleScrollerViewDelegate {
    
    func cycleScrollerDidScroll(to index: Int, cycleScrollerView: SX_CycleScrollerView) {
        
    }
    
    func cycleScrollViewDidSelect(at index: Int, cycleScrollView: SX_CycleScrollerView) {
        
        SXLog("点击了oversea\(index)")
    }
}
