//
//  SX_OverseaController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  海外就业

import UIKit

private let ArrowTag = 3000
private let ControlTag = 1000
private let LabelTag = 2000
private let overseaCellID = "overseaCellID"

class SX_OverseaController: UIViewController {
    
    var topSelectedView: SX_TopSelectedView?
    
//========================================================================================================================================
//  MARK: - lazy
//========================================================================================================================================
    /// 职位分类View
    private lazy var positionView: UIView = {
        let positionView = SX_BasePopSelectedView(frame: CGRect(x: 0, y: -241, width: SCREEN_WIDTH, height: 440)).addhere(toSuperView: self.view).config({ (positionView) in
            positionView.backgroundColor = UIColor.white
        })
        positionView.dataArr = ["不限","会计服务","航空","银行","电子商务","互联网","表演艺术","翻译和本地化","医疗","服装和时装","测试12"]
        positionView.isHidden = true
        
        return positionView
    }()
    
    /// 工作性质View
    private lazy var workNatureView: UIView = {
        let positionView = SX_BasePopSelectedView(frame: CGRect(x: 0, y: -241, width: SCREEN_WIDTH, height: 120)).addhere(toSuperView: self.view).config({ (positionView) in
            positionView.backgroundColor = UIColor.white
        })
        positionView.dataArr = ["中国","美国","不限"]
        positionView.isHidden = true
        
        return positionView
    }()
    
    /// 工作时常View
    private lazy var workTimeView: UIView = {
        let positionView = SX_BasePopSelectedView(frame: CGRect(x: 0, y: -241, width: SCREEN_WIDTH, height: 120)).addhere(toSuperView: self.view).config({ (positionView) in
            positionView.backgroundColor = UIColor.white
        })
        positionView.dataArr = ["中国","美国","不限"]
        positionView.isHidden = true
        
        return positionView
    }()
    
    /// 发布日期View
    private lazy var releaseDateView: UIView = {
        let positionView = SX_BasePopSelectedView(frame: CGRect(x: 0, y: -241, width: SCREEN_WIDTH, height: 120)).addhere(toSuperView: self.view).config({ (positionView) in
            positionView.backgroundColor = UIColor.white
        })
        positionView.dataArr = ["中国","美国","不限"]
        positionView.isHidden = true
        
        return positionView
    }()
    
    
    private lazy var overseaTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
//========================================================================================================================================
//
//========================================================================================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
       setUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ========================================================================================================================================
// MARK: - UITableViewDelegate
// ========================================================================================================================================
extension SX_OverseaController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: overseaCellID)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "测试cell"
        return cell
    }
}

// ========================================================================================================================================
// MARK: - Other Method
// ========================================================================================================================================
extension SX_OverseaController {
    
    func setUI() {
        self.title = "海外就业"
        self.view.backgroundColor = UIColor.colorWithHexString(hex: "f1f1f1", alpha: 1)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.positionView.isHidden    = true
        self.workTimeView.isHidden    = true
        self.workNatureView.isHidden  = true
        self.releaseDateView.isHidden = true
    }
    
    func fetchData() {
        
    }
    
    /// 顶部4个按钮
    func setTopSelectedView() {
        self.topSelectedView = SX_TopSelectedView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44)).addhere(toSuperView: self.view).config({ (topSelectedView) in
            topSelectedView.backgroundColor = UIColor.white
        })
        
        let _ = UIView(frame: CGRect(x: 0, y: self.topSelectedView!.frame.origin.y + self.topSelectedView!.frame.size.height + 0.1 , width: SCREEN_WIDTH, height: 0.5)).addhere(toSuperView: self.view).config { (lineView) in
            lineView.backgroundColor = UIColor.colorWithHexString(hex: "b2b2b2", alpha: 1)
        }
        
        var titleArr = ["综","的","3"]
        for index in 0..<3 {
            let view = creatBtnView(titleArr[index], frame: CGRect(x: Int((SCREEN_WIDTH/3)) * index, y: 0, width: Int(SCREEN_WIDTH/3), height: 44), tag: index)
            view.isUserInteractionEnabled = true
            self.topSelectedView?.addSubview(view)
            
            let control = UIControl(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
            control.addTarget(self, action: #selector(topSelectedBtnClick), for: .touchUpInside)
            control.tag = index + ControlTag
            
            view.addSubview(control)
        }
    }
    
    /// 创建头部选择条件View
    func creatBtnView(_ title:String, frame: CGRect, tag:NSInteger) -> UIView {
        
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.groupTableViewBackground
        
        let label = UILabel().addhere(toSuperView: view).layout { (make) in
            make.centerX.equalToSuperview().offset(-6)
            make.top.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 65, height: 14))
            }.config { (label) in
                label.text = title
                label.font = UIFont.systemFont(ofSize: 14)
                label.textColor = UIColor.black
                label.textAlignment = .right
                label.tag = tag + LabelTag
        }
        
        let _ = UIImageView(image: UIImage.init(named: "btn_down")).addhere(toSuperView: view).layout { (make) in
            make.left.equalTo(label.snp.right).offset(5)
            make.top.equalToSuperview().offset(19)
            make.size.equalTo(CGSize(width: 7, height: 4))
            }.config { (imageV) in
                imageV.tag = tag + ArrowTag
        }
        return view
    }
    
    @objc func topSelectedBtnClick() {
        


    }
}
