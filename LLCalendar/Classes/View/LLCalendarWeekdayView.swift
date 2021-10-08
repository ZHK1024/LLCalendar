//
//  LLCalendarWeekdayView.swift
//  LLCalendar
//
//  Created by ZHK on 2021/10/8.
//  
//

import UIKit

class LLCalendarWeekdayView: UIStackView {
    
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
        distribution = .fillEqually
        
        Calendar.current.shortWeekdaySymbols.forEach { text in
            addArrangedSubview(UILabel(text: text))
        }
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
