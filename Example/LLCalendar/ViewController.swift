//
//  ViewController.swift
//  LLCalendar
//
//  Created by Ruris on 10/08/2021.
//  Copyright (c) 2021 Ruris. All rights reserved.
//

import UIKit
import LLCalendar

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func rightItemActon(_ sender: UIBarButtonItem) {
        navigationController?.pushViewController([
//            LLCalendarYearViewController(),
            LLCalendarMonthViewController(date: Date())
        ], animated: true)
    }
}

extension UINavigationController {
    
    func pushViewController(_ viewControllers: [UIViewController], animated: Bool) {
        guard let last = viewControllers.last else { return }
        pushViewController(last, animated: animated)
        if viewControllers.count > 1 {
            self.viewControllers.insert(contentsOf: viewControllers[..<(viewControllers.endIndex - 1)],
                                        at: self.viewControllers.endIndex - 1)
        }
    }
}
