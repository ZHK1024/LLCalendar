//
//  LLCalendarMonthHeaderView.swift
//  LLCalendar
//
//  Created by ZHK on 2021/10/9.
//  
//

import UIKit

class LLCalendarMonthHeaderView: UICollectionReusableView {
    
    static let identifier = "LLCalendarMonthHeaderView"
    
    public let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(label)
        
        label.textAlignment = .center
        
        label.backgroundColor = .systemTeal.withAlphaComponent(0.3)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
