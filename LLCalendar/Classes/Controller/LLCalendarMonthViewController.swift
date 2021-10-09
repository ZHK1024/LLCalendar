//
//  LLCalendarMonthViewController.swift
//  LLCalendar
//
//  Created by ZHK on 2021/10/8.
//  
//

import UIKit

open class LLCalendarMonthViewController: UIViewController {
    
    /// FlowLayout
    private let flowLayout = UICollectionViewFlowLayout()
    
    /// UICollectionView
    private let collectionView: UICollectionView
    
    /// Weekday View
    let weekdayView = LLCalendarWeekdayView()
    
    /// ViewModel
    private let vm = LLCalendarMonthViewModel()
    
    // MARK: - Init
    
    public init(date: Date) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(LLCalendarMonthViewCell.self, forCellWithReuseIdentifier: LLCalendarMonthViewCell.identifier)
        collectionView.register(LLCalendarMonthHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: LLCalendarMonthHeaderView.identifier)
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycel

    open override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI
    private func setupUI() {
        title = "日历"
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        view.addSubview(weekdayView)
        
        flowLayout.minimumLineSpacing = 3
        flowLayout.minimumInteritemSpacing = 3
        let w = floor((UIScreen.main.bounds.width - 24.0) / 7.0)
        flowLayout.itemSize = CGSize(width: w, height: w)
        flowLayout.headerReferenceSize = CGSize(width: 0.0, height: 60.0)
        flowLayout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 0, right: 2)
        print(w)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 5.0, left: 0, bottom: 0, right: 0)
        collectionView.reloadData()
        
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let month = Calendar.current.component(.month, from: Date())
        if let date = Calendar.current.date(from: DateComponents(year: 2021, month: month)) {
            let week = Calendar.current.component(.weekOfYear, from: date)
            let of = CGFloat(week) * (flowLayout.itemSize.height + 3.0) + CGFloat(month) * 60.0
            collectionView.contentOffset = CGPoint(x: 0, y: of)
            
            print(of, flowLayout.itemSize.height)
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let month = Calendar.current.component(.month, from: Date())
        if let date = Calendar.current.date(from: DateComponents(year: 2021, month: month)) {
            let week = Calendar.current.component(.weekOfYear, from: date)
            let of = CGFloat(week) * (flowLayout.itemSize.height + 3.0) + CGFloat(month) * 60.0
//            collectionView.contentOffset = CGPoint(x: 0, y: of)
            print(date, month)
            collectionView.setContentOffset(CGPoint(x: 0, y: of), animated: true)
            print(of)
        }
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        recalViewsFrame()
    }
    
    open override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        recalViewsFrame()
    }
    
    ///  重新计算 `CollectionView` 的 `frame`
    private func recalViewsFrame() {
        weekdayView.frame = CGRect(x: view.safeAreaInsets.left,
                                   y: view.safeAreaInsets.top,
                                   width: view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right,
                                   height: 50.0)
        collectionView.frame = CGRect(x: weekdayView.frame.minX,
                                      y: weekdayView.frame.maxY,
                                      width: weekdayView.frame.width,
                                      height: view.bounds.height - weekdayView.frame.maxY - view.safeAreaInsets.bottom)
    }
}

extension LLCalendarMonthViewController: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vm.calendar.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.calendar[section].count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LLCalendarMonthViewCell.identifier, for: indexPath) as! LLCalendarMonthViewCell
        let month = vm.calendar[indexPath.section]
        if indexPath.row >= month.offset {
            cell.day = month.days[indexPath.row - month.offset]
        } else {
            cell.day = nil
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LLCalendarMonthHeaderView.identifier, for: indexPath) as! LLCalendarMonthHeaderView
        header.label.text = "\(indexPath.section + 1) 月"
        return header
    }
}

extension LLCalendarMonthViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let month = vm.calendar[indexPath.section]
        if indexPath.row < month.offset { return }
        print(month.days[indexPath.row - month.offset])
    }
}
