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
        view.addSubview(collectionView)
        flowLayout.minimumLineSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        let w = floor((UIScreen.main.bounds.width - 16.0) / 7.0)
        flowLayout.itemSize = CGSize(width: w, height: w)
        flowLayout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 0, right: 2)
        
//        print(vm.calendar)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.reloadData()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        recalCollectionViewFrame()
    }
    
    open override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        recalCollectionViewFrame()
    }
    
    ///  重新计算 `CollectionView` 的 `frame`
    private func recalCollectionViewFrame() {
        collectionView.frame = CGRect(x: view.safeAreaInsets.left,
                                      y: view.safeAreaInsets.top,
                                      width: view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right,
                                      height: view.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
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
