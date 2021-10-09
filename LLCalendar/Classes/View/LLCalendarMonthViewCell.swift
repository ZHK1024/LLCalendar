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
            gregorianLabel.text = day?.gregorian
            chineseLabel.text = day?.chinese
            contentView.isHidden = day == nil
            tagLabel.text = "休"
        }
    }
    
    /// 公历
    private let gregorianLabel = UILabel()
    
    /// 农历
    private let chineseLabel = UILabel()
    
    /// 角标 (班/休)
    private let tagLabel = UILabel()
    
    /// UIStackView
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 2.0
        return stackView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(stackView)
        contentView.addSubview(tagLabel)
        contentView.backgroundColor = .white
        
        stackView.addArrangedSubview(gregorianLabel)
        stackView.addArrangedSubview(chineseLabel)
        
//        gregorianLabel.backgroundColor = .white
        gregorianLabel.textAlignment = .center
        chineseLabel.textAlignment = .center
        
        contentView.backgroundColor = .red.withAlphaComponent(0.2)
        contentView.layer.cornerRadius = 5.0
        contentView.clipsToBounds = true
        
        chineseLabel.font = UIFont.systemFont(ofSize: 10.0)
        tagLabel.font = UIFont.systemFont(ofSize: 10.0)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let w = bounds.width - 20
        stackView.frame = CGRect(x: 10, y: 10, width: w, height: w)
        tagLabel.frame = CGRect(x: 5, y: 5, width: 10, height: 10)
    }
}
