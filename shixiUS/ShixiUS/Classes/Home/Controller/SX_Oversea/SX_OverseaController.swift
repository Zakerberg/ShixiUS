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

    lazy var tableView: UITableView = {
        let table:UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .grouped)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        fetchData()
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

// ====================================================================================
// MARK: - Other Method
// ==================================================================================
extension SX_OverseaController {
    
    func setUI() {
        view.backgroundColor = UIColor.white
        title = "海外就业"
        self.view.addSubview(tableView)
        
    }
    
    func fetchData() {
        
        
        
    }
}

// =========================================================================================
// MARK: - UITableViewDelegate
// =====================================================================================
extension SX_OverseaController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //        return 5
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SX_HotJobsCell(style: .default, reuseIdentifier: "hotJobCellID")
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
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
                moreButton.rx.tap.subscribe(onNext: { (_) in
                    SXLog("进入更多界面")
                    let vc = SX_MoreHotJobController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }, onError: { (error) in
                    
                }, onCompleted: nil, onDisposed: nil)
        }
        return hotJobHeaderView
    }
}

// ==========================================================================================
// MARK: -
// ==========================================================================================
extension SX_OverseaController {
    
    
}
