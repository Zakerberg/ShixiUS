//
//  SX_ADScrollerView.swift
//  SX_NetWork
//
//  Created by heather on 2018/3/21.
//  Copyright © 2018年 Shixi (Beijing) Technology Limited (Company). All rights reserved.
// 

//import UIKit
//
//var kViewHeight = CGFloat(200)
//let CellIdentifier = "CellIdentifier"
//
//class SX_ADScrollerView: UIView {
//
//    fileprivate lazy var adCollectionView: UICollectionView = { [unowned self] in
//
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
//        layout.itemSize = CGSize(width: SCREEN_WIDTH, height: kViewHeight)
//        layout.minimumLineSpacing = 0
//        let adCollectionView : UICollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
//        adCollectionView.showsHorizontalScrollIndicator = false
//        adCollectionView.isPagingEnabled = true
//
//        adCollectionView.backgroundColor = UIColor.cyan
//        adCollectionView.register(SX_ADCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifier)
//        adCollectionView.dataSource = self
//        adCollectionView.delegate = self
//        return adCollectionView
//        }()
//
//    fileprivate lazy var pageControl : UIPageControl = {
//        let pageControl: UIPageControl = UIPageControl()
//        pageControl.translatesAutoresizingMaskIntoConstraints = false
//        pageControl.numberOfPages = 1
//        return pageControl
//    }()
//
//    var timer : Timer?
//
//    var adScrollModelArr : [SX_ADScrollModel]? {
//        didSet{
//            self.adCollectionView.reloadData()
//            pageControl.numberOfPages = adScrollModelArr?.count ?? 0
//            let index = (adScrollModelArr?.count ?? 0)*10
//            self.adCollectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .left, animated: false)
//
//            removeTimer()
//            addTimer()
//        }
//    }
//
//    init(Y: CGFloat, H: CGFloat) {
//        kViewHeight = H
//        super.init(frame: CGRect(x: 0, y: Y, width: SCREEN_WIDTH, height: kViewHeight))
//        setUI()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
////MARK: - Set UI
//extension SX_ADScrollerView {
//    func setUI() {
//        self.addSubview(adCollectionView)
//        self.addSubview(pageControl)
//        // 给pageControl 添加约束
//        let rightContraint : NSLayoutConstraint = NSLayoutConstraint(item: pageControl, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -10)
//        let bottomContrain : NSLayoutConstraint = NSLayoutConstraint(item: pageControl, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -5)
//        let heightContrain : NSLayoutConstraint = NSLayoutConstraint(item: pageControl, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20)
//        pageControl.superview?.addConstraint(rightContraint)
//        pageControl.superview?.addConstraint(bottomContrain)
//        pageControl.superview?.addConstraint(heightContrain)
//    }
//}
//
////MARK: - CollectionViewDelegate
//extension SX_ADScrollerView : UICollectionViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offset = scrollView.contentOffset.x + SCREEN_WIDTH / 2
//        pageControl.currentPage = Int(offset / SCREEN_WIDTH) % (adScrollModelArr?.count ?? 1)
//    }
//}
//
////MARK: - CollectionViewDataSource
//extension SX_ADScrollerView : UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10000*(adScrollModelArr?.count ?? 0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let collectionItem = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as! SX_ADCollectionViewCell
//        let index = indexPath.item % adScrollModelArr!.count
//        collectionItem.adScrollModel = adScrollModelArr![index]
//        return collectionItem
//    }
//}
//
////MARK: - Timer
//extension SX_ADScrollerView {
//    func addTimer()  {
//        timer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
//        RunLoop.main.add(timer!, forMode: .commonModes)
//    }
//
//    func removeTimer() {
//        timer?.invalidate()
//        timer = nil
//    }
//
//    @objc func scrollToNextPage() {
//        // 当前偏移量加上一页的宽度
//        let offSetX = adCollectionView.contentOffset.x + SCREEN_WIDTH
//        adCollectionView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: true)
//    }
//}
