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
        flowLayout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 0, right: 2)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 5.0, left: 0, bottom: 0, right: 0)
        collectionView.reloadData()
        
        navigationController?.navigationBar.shadowImage = UIImage()
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
        print(vm.calendar.count)
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
}

extension LLCalendarMonthViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let month = vm.calendar[indexPath.section]
        if indexPath.row < month.offset { return }
        print(month.days[indexPath.row - month.offset])
    }
}
