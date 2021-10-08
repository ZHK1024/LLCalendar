//
//  LLCalendarMonthViewCell.swift
//  LLCalendar
//
//  Created by ZHK on 2021/10/8.
//  
//

import UIKit

open class LLCalendarMonthViewCell: UICollectionViewCell {
    
    public static let identifier = "LLCalendarMonthViewCell"
    
    var day: LLCalendar.Day? {
        didSet {
            label.text = day?.name
            label.isHidden = day == nil
        }
    }
    
    private let label = UILabel()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(label)
        contentView.backgroundColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
    }
}
