//
//  LLCalendarWeekdayView.swift
//  LLCalendar
//
//  Created by ZHK on 2021/10/8.
//  
//

import UIKit

class LLCalendarWeekdayView: UIView {
    
    private let stackView = UIStackView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(stackView)
        stackView.distribution = .fillEqually
        
//        Calendar.current.shortWeekdaySymbols.forEach { text in
        ["日", "一", "二", "三", "四", "五", "六"].forEach { text in
            stackView.addArrangedSubview(UILabel(text: NSLocalizedString(text, comment: text)))
        }
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.2

//        clipsToBounds = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    private func label() -> UILabel {
        let label = UILabel()
        return label
    }
}

fileprivate extension UILabel {
    
    convenience init(text: String) {
        self.init()
        self.text = text
        textAlignment = .center
    }
}
